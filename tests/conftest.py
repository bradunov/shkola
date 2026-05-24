"""
Pytest configuration and shared fixtures for question testing.
"""
import sys
import os
import json
import random
import re
import logging

import pytest

# Add src to path so we can import server modules
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'src'))

from server.app_data import AppData
from server.page import Page
from server.question import Question
from server.types import PageLanguage


# Suppress excessive logging during tests
logging.basicConfig(level=logging.WARNING)


# Module-level cached AppData (loaded once for parametrization and fixtures)
_cached_app_data = None

def get_app_data():
    global _cached_app_data
    if _cached_app_data is None:
        import time as _time
        import functools
        t0 = _time.perf_counter()
        rel_path = os.path.join(os.path.dirname(__file__), '..')
        _cached_app_data = AppData(use_azure_blob=False, preload=False, rel_path=rel_path)
        # Preload lists only (small)
        _cached_app_data.repository.load_dir(
            _cached_app_data.repository.lists,
            _cached_app_data.repository.lists_path)

        # Patch get_question_disk with a cache so each question is read only once
        original_get_question_disk = _cached_app_data.repository.get_question_disk
        @functools.lru_cache(maxsize=None)
        def cached_get_question_disk(q_id):
            return original_get_question_disk(q_id)
        _cached_app_data.repository.get_question_disk = cached_get_question_disk

        t1 = _time.perf_counter()
        sys.stderr.write(f"[Setup] AppData ready in {t1-t0:.2f}s (questions cached on demand)\n")
        sys.stderr.flush()
    return _cached_app_data


@pytest.fixture(scope="session")
def app_data():
    """Load AppData once for the entire test session."""
    return get_app_data()


@pytest.fixture()
def fresh_page(app_data):
    """Create a fresh Page object for a single test."""
    page = Page(app_data)
    return page


def discover_all_question_languages(app_data):
    """
    Discover all (question_id, language) pairs from the repository.
    Returns a list of tuples: (q_id, language_str)
    """
    pairs = []
    for lang in ["rs", "uk", "sl", "mk"]:
        try:
            q_ids = app_data.repository.get_all_question_ids("", lang)
            for q_id in q_ids:
                # q_id comes as "/numbers/q00001" — strip leading slash
                clean_id = q_id.lstrip("/")
                pairs.append((clean_id, lang))
        except Exception:
            pass
    return pairs


def discover_questions_from_lists(app_data):
    """
    Discover all (question_id, language) pairs from the list JSON files.
    This is more reliable as it only includes questions actually used in curricula.
    """
    pairs = set()
    for list_name, list_dict in app_data.repository.lists.items():
        if not isinstance(list_dict, dict):
            continue
        if "language" not in list_dict or "questions" not in list_dict:
            continue
        lang = list_dict["language"].lower().strip()
        for q in list_dict["questions"]:
            if "name" in q:
                pairs.add((q["name"].strip(), lang))
    return sorted(pairs)


def get_question_languages(app_data, q_id):
    """Get all languages available for a specific question."""
    q = app_data.repository.get_question(q_id)
    if q is None:
        return []
    languages = []
    for key in q.keys():
        if key.startswith("text."):
            lang = key[5:]  # strip "text."
            languages.append(lang)
    return languages


def evaluate_question(app_data, q_id, language, seed=42):
    """
    Evaluate a question with a fixed seed and return (page, question, library).
    """
    random.seed(seed)
    page = Page(app_data)
    page.page_params.set_param("language", PageLanguage.fromStr(language))
    page.page_params.set_param("q_id", q_id)

    q = Question(page, q_id=q_id, language=PageLanguage.fromStr(language))
    q.set_from_file()
    q.eval(page)

    return page, q, q.lib


def extract_solutions(lib):
    """
    Extract expected answers from library solutions JS code.
    Returns a list of answer strings.
    """
    solutions = getattr(lib, 'last_solutions', lib.solutions)
    answers = []
    for sol in solutions:
        # Match patterns like: .value = '42'
        m = re.search(r"\.value\s*=\s*'([^']*)'", sol)
        if m:
            answers.append(m.group(1))
            continue
        # Match patterns like: .checked = true
        m = re.search(r"\.checked\s*=\s*(true|false)", sol)
        if m:
            answers.append(m.group(1))
            continue
        # Match fraction patterns: numerator=X; denominator=Y;
        m = re.search(r"numerator\s*=\s*(\S+?)\s*;.*?denominator\s*=\s*(\S+?)\s*;", sol)
        if m:
            whole_m = re.search(r"whole\s*=\s*(\S+?)\s*;", sol)
            if whole_m:
                answers.append("{} {}/{}".format(whole_m.group(1), m.group(1), m.group(2)))
            else:
                answers.append("{}/{}".format(m.group(1), m.group(2)))
            continue
        # Canvas solution patterns: solution_XXX[i] = 1
        canvas_matches = re.findall(r"solution_\w+\[(\d+)\]\s*=\s*(\d+)", sol)
        if canvas_matches:
            answers.append(str(canvas_matches))
            continue
        # Fallback: store raw solution
        answers.append(sol.strip())
    return answers


def classify_check_type(check_str):
    """Classify a check function name into a type."""
    if "check_number_answer" in check_str:
        return "number"
    elif "check_radio_answer" in check_str:
        return "radio"
    elif "check_fraction" in check_str:
        return "fraction"
    elif "canvas" in check_str or "sel_canvas" in check_str:
        return "canvas"
    elif "check_dropdown" in check_str:
        return "dropdown"
    else:
        return "string"


def load_annotation(questions_dir, q_id):
    """Load test_annotations.json for a question, or return None."""
    ann_path = os.path.join(questions_dir, q_id, "test_annotations.json")
    if os.path.exists(ann_path):
        with open(ann_path, 'r', encoding='utf-8') as f:
            return json.load(f)
    return None


def get_questions_dir(app_data):
    """Get the absolute path to the questions directory."""
    return os.path.join(app_data.rel_path, "questions")


# --- Custom compact output plugin ---

class CompactProgress:
    """Shows current test on one line (overwritten), only persists failures/warnings."""

    def __init__(self):
        self.passed = 0
        self.failed = 0
        self.skipped = 0
        self.xfailed = 0
        self.warnings = 0

    def pytest_report_teststatus(self, report, config):
        """Suppress the terminal reporter's per-test output."""
        if report.when == "call" or (report.when == "setup" and report.skipped):
            return "", "", ""
        return "", "", ""

    def pytest_runtest_logreport(self, report):
        if report.when != "call" and not (report.when == "setup" and report.skipped):
            return

        short_id = report.nodeid.replace("tests/", "").replace("tests\\", "")

        if report.passed:
            self.passed += 1
            # Overwrite line — only visible momentarily in terminal
            sys.stdout.write(f"\r\033[K  {short_id}")
            sys.stdout.flush()
        elif report.skipped:
            self.skipped += 1
            if hasattr(report, 'wasxfail') and report.wasxfail:
                self.xfailed += 1
            sys.stdout.write(f"\r\033[K  {short_id}")
            sys.stdout.flush()
        elif report.failed:
            self.failed += 1
            sys.stdout.write(f"\r\033[K")
            sys.stdout.flush()
            reason = ""
            if report.longreprtext:
                lines = report.longreprtext.strip().split('\n')
                reason = lines[-1].strip() if lines else ""
            print(f"FAILED {short_id} - {reason}")

    def pytest_warning_recorded(self, warning_message, when, nodeid, location):
        if nodeid:
            self.warnings += 1
            short_id = nodeid.replace("tests/", "").replace("tests\\", "")
            sys.stdout.write(f"\r\033[K")
            sys.stdout.flush()
            print(f"WARNING {short_id} - {warning_message.message}")

    def pytest_sessionfinish(self, session, exitstatus):
        sys.stdout.write(f"\r\033[K")
        sys.stdout.flush()
        parts = []
        if self.passed:
            parts.append(f"{self.passed} passed")
        if self.failed:
            parts.append(f"{self.failed} failed")
        if self.skipped:
            parts.append(f"{self.skipped} skipped")
        if self.xfailed:
            parts.append(f"{self.xfailed} xfailed")
        if self.warnings:
            parts.append(f"{self.warnings} warnings")
        total = self.passed + self.failed + self.skipped
        print(f"\n{total} total: " + ", ".join(parts))


def pytest_addoption(parser):
    parser.addoption("--compact", action="store_true", default=True,
                     help="Compact output: overwrite passing tests, only show failures/warnings")
    parser.addoption("--no-compact", action="store_false", dest="compact",
                     help="Disable compact output")
    parser.addoption("--update-baselines", action="store_true", default=False,
                     help="Regenerate baseline HTML files instead of comparing against them.")
    parser.addoption("--question", default=None,
                     help="Filter baseline tests to questions matching this substring (e.g. 'numbers/q00001').")
    parser.addoption("--timing", action="store_true", default=False,
                     help="Print detailed timing breakdown for every question in baseline tests.")
    parser.addoption("--update-snapshots", action="store_true", default=False,
                     help="Generate visual .png baselines only for questions that don't have one yet.")
    parser.addoption("--regenerate-snapshots", action="store_true", default=False,
                     help="Regenerate ALL visual .png baselines (overwrites existing).")


def pytest_configure(config):
    if config.getoption("compact", default=True):
        config.pluginmanager.register(CompactProgress(), "compactprogress")
        config.option.verbose = -2
