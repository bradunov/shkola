"""
Baseline rendering tests: render each question for each language with a fixed
random seed and compare the HTML output against stored baseline files.

Baselines live inside the question folder itself:
    questions/<category>/<qNNNNN>/tests/<lang>.html

Run with --update-baselines to (re-)generate baseline files without failing.
"""
import os
import re
import random
from html.parser import HTMLParser

import pytest

from conftest import get_app_data, get_question_languages
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

def render_question_html(app_data, q_id, language_str):
    """Render a question and return the question-only HTML (scripts + body)."""
    random.seed(SEED)
    page = Page(app_data)
    lang = PageLanguage.fromStr(language_str)
    page.page_params.set_param("language", lang)
    page.page_params.set_param("q_id", q_id)

    q = Question(page, q_id=q_id, language=lang)
    q.set_from_file()
    q.eval(page)

    html = ""
    for line in page.script_lines:
        html += line + "\n"
    for line in page.lines:
        html += str(line)
    return html


def baseline_path(app_data, q_id, language_str):
    """Return the path where the baseline file for q_id/language lives.

    e.g. questions/numbers/q00001/tests/rs.html
    """
    questions_root = os.path.join(app_data.rel_path, "questions")
    return os.path.join(questions_root, q_id, "tests", f"{language_str}.html")


def discover_question_language_pairs():
    """Discover all (q_id, lang) pairs by scanning question directories."""
    app_data = get_app_data()
    questions_root = os.path.join(app_data.rel_path, "questions")
    pairs = []
    for category in sorted(os.listdir(questions_root)):
        cat_path = os.path.join(questions_root, category)
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


# ---------------------------------------------------------------------------
# Pytest hooks / fixtures
# ---------------------------------------------------------------------------

def pytest_generate_tests(metafunc):
    if "q_id" in metafunc.fixturenames and "language" in metafunc.fixturenames:
        pairs = discover_question_language_pairs()
        metafunc.parametrize(
            "q_id,language",
            pairs,
            ids=[f"{q}/{l}" for q, l in pairs],
        )


# ---------------------------------------------------------------------------
# Test
# ---------------------------------------------------------------------------

class TestQuestionBaselines:

    def test_rendering_matches_baseline(self, app_data, q_id, language, request):
        """Render a question and compare against the stored baseline."""
        update_mode = request.config.getoption("--update-baselines")

        html = render_question_html(app_data, q_id, language)
        bp = baseline_path(app_data, q_id, language)

        if update_mode:
            os.makedirs(os.path.dirname(bp), exist_ok=True)
            with open(bp, "w", encoding="utf-8") as f:
                f.write(html)
            pytest.skip("Baseline updated")
        else:
            assert os.path.exists(bp), (
                f"No baseline file for {q_id}/{language}. "
                f"Run with --update-baselines to generate it."
            )
            with open(bp, "r", encoding="utf-8") as f:
                expected = f.read()

            tokens_got = _tokenize_html(html)
            tokens_exp = _tokenize_html(expected)
            diff = _first_token_diff(tokens_got, tokens_exp)
            assert diff is None, (
                f"Rendered HTML for {q_id}/{language} does not match baseline.\n"
                f"{diff}\n"
                f"Run with --update-baselines to regenerate."
            )
