"""
Baseline rendering tests: render each question for each language with a fixed
random seed and compare the HTML output against stored baseline files.

Baselines live inside the question folder itself:
    questions/<category>/<qNNNNN>/tests/<lang>.html

Run with --update-baselines to generate baseline files for questions that don't have one yet.
Run with --regenerate-baselines to regenerate ALL baseline files (overwrites existing).
"""
import os
import sys
import random
import time
from html.parser import HTMLParser

import pytest

from conftest import get_app_data
from server.page import Page
from server.question import Question
from server.types import PageLanguage

SEED = 42


# ---------------------------------------------------------------------------
# HTML semantic comparison
# ---------------------------------------------------------------------------

class _HTMLTokenizer(HTMLParser):
    """Parse HTML into a list of canonical tokens for semantic comparison.

    Normalises away differences that do not affect rendered meaning:
    * whitespace between and inside text/comment/script nodes (collapsed)
    * attribute order on tags (sorted by name)
    * CSS property order inside style attributes (sorted)
    """

    def __init__(self):
        super().__init__(convert_charrefs=False)
        self.tokens = []

    def handle_starttag(self, tag, attrs):
        norm_attrs = []
        for name, value in sorted(attrs, key=lambda a: a[0]):
            if name == "style" and value:
                parts = [p.strip() for p in value.split(";") if p.strip()]
                value = ";".join(sorted(parts))
            norm_attrs.append((name, value))
        self.tokens.append(("tag", tag, tuple(norm_attrs)))

    def handle_endtag(self, tag):
        self.tokens.append(("end", tag))

    def handle_data(self, data):
        text = " ".join(data.split())
        if text:
            self.tokens.append(("text", text))

    def handle_entityref(self, name):
        self.tokens.append(("entity", name))

    def handle_charref(self, name):
        self.tokens.append(("charref", name))

    def handle_comment(self, data):
        text = " ".join(data.split())
        if text:
            self.tokens.append(("comment", text))


def _tokenize_html(html):
    parser = _HTMLTokenizer()
    parser.feed(html)
    return parser.tokens


def _first_token_diff(tokens_a, tokens_b):
    """Return a human-readable description of the first difference."""
    for i, (a, b) in enumerate(zip(tokens_a, tokens_b)):
        if a != b:
            return f"First difference at token {i}:\n  got:      {a}\n  expected: {b}"
    if len(tokens_a) != len(tokens_b):
        return (
            f"Token count differs: {len(tokens_a)} (rendered) "
            f"vs {len(tokens_b)} (baseline)"
        )
    return None


# ---------------------------------------------------------------------------
# Rendering helpers
# ---------------------------------------------------------------------------

def render_question_html(app_data, q_id, language_str, timing_detail=None):
    """Render a question and return the question-only HTML (scripts + body)."""
    random.seed(SEED)

    t0 = time.perf_counter()
    page = Page(app_data)
    lang = PageLanguage.fromStr(language_str)
    page.page_params.set_param("language", lang)
    page.page_params.set_param("q_id", q_id)
    t1 = time.perf_counter()

    q = Question(page, q_id=q_id, language=lang)
    t2 = time.perf_counter()

    # Inline set_from_file with sub-timings
    t2a = time.perf_counter()
    q.init_code = ""
    q.iter_code = ""
    q.text = "\n\n<h3>ERROR: no code exists for question '{}' for language '{}'!</h3>".format(
        q.q_id, PageLanguage.toStr(q.language)
    )
    q.page.add_lines("\n<!-- Rendering question '{}' for language '{}' -->\n\n".format(
        q.q_id, PageLanguage.toStr(q.language)
    ))

    t2b = time.perf_counter()
    q_data = q.repository.get_question(q.q_id)
    t2c = time.perf_counter()

    if q_data is not None:
        if "init.lua" in q_data.keys():
            q.init_code = q_data["init.lua"]
        if "iter.lua" in q_data.keys():
            q.iter_code = q_data["iter.lua"]
        text_key = "text." + PageLanguage.toStr(q.language)
        if text_key in q_data.keys():
            q.text = q_data[text_key]
    t3 = time.perf_counter()

    q.eval(page)
    t4 = time.perf_counter()

    html = ""
    for line in page.script_lines:
        html += line + "\n"
    for line in page.lines:
        html += str(line)

    if timing_detail is not None:
        timing_detail.update({
            "page_setup": t1 - t0,
            "question_init": t2 - t1,
            "sff_prep": t2b - t2a,
            "sff_get_question": t2c - t2b,
            "sff_extract": t3 - t2c,
            "eval": t4 - t3,
        })

    return html


QUESTIONS_ROOT = os.path.join(os.path.dirname(__file__), "..", "questions")


def baseline_path(q_id, language_str):
    """Return the path where the baseline file for q_id/language lives.

    e.g. questions/numbers/q00001/tests/rs.html
    """
    return os.path.join(QUESTIONS_ROOT, q_id, "tests", f"{language_str}.html")


def discover_question_language_pairs():
    """Discover all (q_id, lang) pairs by scanning question directories."""
    pairs = []
    for category in sorted(os.listdir(QUESTIONS_ROOT)):
        cat_path = os.path.join(QUESTIONS_ROOT, category)
        if not os.path.isdir(cat_path) or category == "global":
            continue
        for qdir in sorted(os.listdir(cat_path)):
            q_path = os.path.join(cat_path, qdir)
            if not os.path.isdir(q_path):
                continue
            q_id = f"{category}/{qdir}"
            for fname in os.listdir(q_path):
                if fname.startswith("text.") and not fname.endswith(".lua"):
                    lang = fname[len("text."):]
                    pairs.append((q_id, lang))
    return pairs


def discover_existing_baselines():
    """Discover (q_id, lang) pairs that already have baseline files."""
    pairs = []
    for category in sorted(os.listdir(QUESTIONS_ROOT)):
        cat_path = os.path.join(QUESTIONS_ROOT, category)
        if not os.path.isdir(cat_path) or category == "global":
            continue
        for qdir in sorted(os.listdir(cat_path)):
            tests_path = os.path.join(cat_path, qdir, "tests")
            if not os.path.isdir(tests_path):
                continue
            q_id = f"{category}/{qdir}"
            for fname in os.listdir(tests_path):
                if fname.endswith(".html"):
                    lang = fname[:-len(".html")]
                    pairs.append((q_id, lang))
    return pairs


# ---------------------------------------------------------------------------
# Test
# ---------------------------------------------------------------------------

class TestQuestionBaselines:

    def test_rendering_matches_baseline(self, app_data, request, capsys):
        """Render all questions and compare against stored baselines."""
        update_mode = request.config.getoption("--update-baselines")
        regenerate_mode = request.config.getoption("--regenerate-baselines")
        question_filter = request.config.getoption("--question")
        verbose_timing = request.config.getoption("--timing")

        if update_mode or regenerate_mode:
            pairs = discover_question_language_pairs()
        else:
            pairs = discover_existing_baselines()
            assert len(pairs) > 0, (
                "No baseline files found. "
                "Run with --update-baselines to generate them."
            )

        if question_filter:
            pairs = [(q, l) for q, l in pairs if question_filter in q]

        # In update mode (not regenerate), skip pairs that already have a baseline
        if update_mode and not regenerate_mode:
            pairs = [(q, l) for q, l in pairs
                     if not os.path.exists(baseline_path(q, l))]
            if not pairs:
                pytest.skip("All questions already have baselines (use --regenerate-baselines to overwrite)")

        failures = []
        updated = 0
        passed = 0

        timings = []

        with capsys.disabled():
            for i, (q_id, language) in enumerate(pairs):
                bp = baseline_path(q_id, language)
                label = f"{q_id}/{language}"

                t_start = time.perf_counter()
                timing_detail = {}
                try:
                    html = render_question_html(app_data, q_id, language, timing_detail)
                except Exception as e:
                    elapsed = time.perf_counter() - t_start
                    timings.append((elapsed, label))
                    failures.append(f"{label}: render error: {e}")
                    sys.stdout.write(f"\r\033[KFAILED {label}: {e} ({elapsed:.3f}s)\n")
                    sys.stdout.flush()
                    continue

                if update_mode or regenerate_mode:
                    os.makedirs(os.path.dirname(bp), exist_ok=True)
                    with open(bp, "w", encoding="utf-8") as f:
                        f.write(html)
                    updated += 1
                    elapsed = time.perf_counter() - t_start
                    timings.append((elapsed, label))
                    sys.stdout.write(f"\r\033[K  Updated {label} [{updated}/{len(pairs)}] ({elapsed:.3f}s)\n")
                    sys.stdout.flush()
                else:
                    t_compare_start = time.perf_counter()
                    with open(bp, "r", encoding="utf-8") as f:
                        expected = f.read()
                    t_read_done = time.perf_counter()

                    tokens_got = _tokenize_html(html)
                    t_tok_got = time.perf_counter()

                    tokens_exp = _tokenize_html(expected)
                    t_tok_exp = time.perf_counter()

                    diff = _first_token_diff(tokens_got, tokens_exp)
                    t_compare_end = time.perf_counter()

                    timing_detail["cmp_read"] = t_read_done - t_compare_start
                    timing_detail["cmp_tok_got"] = t_tok_got - t_read_done
                    timing_detail["cmp_tok_exp"] = t_tok_exp - t_tok_got
                    timing_detail["cmp_diff"] = t_compare_end - t_tok_exp

                    elapsed = time.perf_counter() - t_start
                    timings.append((elapsed, label))

                    if diff is not None:
                        failures.append(f"{label}: {diff}")
                        sys.stdout.write(f"\r\033[KFAILED {label} ({elapsed:.3f}s)\n")
                        sys.stdout.flush()
                    else:
                        passed += 1
                        if verbose_timing:
                            parts = " | ".join(f"{k}={v:.3f}s" for k, v in timing_detail.items())
                            sys.stdout.write(f"\r\033[K  {label} [{passed}/{len(pairs)}] ({elapsed:.3f}s): {parts}\n")
                            sys.stdout.flush()
                        elif elapsed > 0.5:
                            parts = " | ".join(f"{k}={v:.3f}s" for k, v in timing_detail.items())
                            sys.stdout.write(f"\r\033[K  [SLOW] {label} ({elapsed:.3f}s): {parts}\n")
                            sys.stdout.flush()
                        else:
                            sys.stdout.write(f"\r\033[K  {label} [{passed}/{len(pairs)}] ({elapsed:.3f}s)")
                            sys.stdout.flush()

            sys.stdout.write("\r\033[K")
            sys.stdout.flush()

            if update_mode or regenerate_mode:
                print(f"\nUpdated {updated} baselines.")
            else:
                print(f"\n{passed} passed, {len(failures)} failed out of {len(pairs)}")

            # Print slowest questions
            if verbose_timing and timings:
                timings.sort(reverse=True)
                print(f"\nSlowest questions:")
                for elapsed, label in timings[:10]:
                    print(f"  {elapsed:6.3f}s  {label}")

        if update_mode or regenerate_mode:
            pytest.skip(f"{updated} baselines updated")
        elif failures:
            detail = "\n".join(failures[:20])
            if len(failures) > 20:
                detail += f"\n... and {len(failures) - 20} more"
            pytest.fail(
                f"{passed} passed, {len(failures)} failed out of "
                f"{len(pairs)}\n\n{detail}",
                pytrace=False,
            )
