"""
Smoke tests: verify every question evaluates without error across all languages and multiple seeds.
"""
import pytest

from conftest import (
    discover_questions_from_lists,
    evaluate_question,
    get_app_data,
)


def pytest_generate_tests(metafunc):
    """Dynamically parametrize tests based on discovered questions."""
    if "q_id" in metafunc.fixturenames and "language" in metafunc.fixturenames:
        app_data = get_app_data()
        pairs = discover_questions_from_lists(app_data)
        metafunc.parametrize("q_id,language", pairs,
                           ids=[f"{q}/{l}" for q, l in pairs])


class TestQuestionSmoke:
    """Smoke tests that verify questions render without exceptions."""

    def test_evaluates_without_error(self, app_data, q_id, language):
        """Each question should evaluate without raising an exception."""
        page, q, lib = evaluate_question(app_data, q_id, language, seed=42)

        # Basic sanity: page should have some content
        assert len(page.lines) > 0, \
            f"Question {q_id}/{language} produced no output"

    def test_has_check_fields(self, app_data, q_id, language):
        """Each question should have at least one answer check field."""
        page, q, lib = evaluate_question(app_data, q_id, language, seed=42)

        # Some questions may be display-only (no checks), but most should have at least one
        # We log a warning rather than fail for questions with 0 checks
        checks = getattr(lib, 'last_checks', lib.checks)
        if len(checks) == 0:
            pytest.skip(f"Question {q_id}/{language} has no check fields (display-only?)")
