"""
Answer correctness tests: verify that question answers match stored annotations.
"""
import os
import json
import pytest

from conftest import (
    evaluate_question,
    extract_solutions,
    classify_check_type,
    load_annotation,
    get_questions_dir,
    get_app_data,
)


def collect_annotated_questions(app_data):
    """Find all questions that have test_annotations.json files."""
    questions_dir = get_questions_dir(app_data)
    annotated = []
    for root, dirs, files in os.walk(questions_dir):
        if "test_annotations.json" in files:
            # Extract q_id relative to questions_dir
            q_id = os.path.relpath(root, questions_dir).replace("\\", "/")
            ann_path = os.path.join(root, "test_annotations.json")
            with open(ann_path, 'r', encoding='utf-8') as f:
                annotation = json.load(f)
            for lang in annotation.get("languages", {}).keys():
                annotated.append((q_id, lang, annotation))
    return annotated


def pytest_generate_tests(metafunc):
    """Parametrize over annotated questions."""
    if "q_id" in metafunc.fixturenames and "language" in metafunc.fixturenames and "annotation" in metafunc.fixturenames:
        app_data = get_app_data()
        items = collect_annotated_questions(app_data)
        metafunc.parametrize("q_id,language,annotation", items,
                           ids=[f"{q}/{l}" for q, l, _ in items])


class TestQuestionAnswers:
    """Verify answers match annotations."""

    def test_num_checks_matches(self, app_data, q_id, language, annotation):
        """Number of check fields should match annotation."""
        lang_ann = annotation["languages"][language]
        seed = annotation["seed"]

        page, q, lib = evaluate_question(app_data, q_id, language, seed=seed)

        checks = getattr(lib, 'last_checks', lib.checks)
        assert len(checks) == lang_ann["num_checks"], \
            f"Expected {lang_ann['num_checks']} checks, got {len(checks)}"

    def test_check_types_match(self, app_data, q_id, language, annotation):
        """Check field types should match annotation."""
        lang_ann = annotation["languages"][language]
        seed = annotation["seed"]

        page, q, lib = evaluate_question(app_data, q_id, language, seed=seed)

        checks = getattr(lib, 'last_checks', lib.checks)
        actual_types = [classify_check_type(c) for c in checks]
        assert actual_types == lang_ann["check_types"], \
            f"Expected types {lang_ann['check_types']}, got {actual_types}"

    def test_expected_answers_match(self, app_data, q_id, language, annotation):
        """Expected answer values should match annotation."""
        lang_ann = annotation["languages"][language]
        seed = annotation["seed"]

        page, q, lib = evaluate_question(app_data, q_id, language, seed=seed)

        actual_answers = extract_solutions(lib)
        expected_answers = lang_ann["expected_answers"]

        assert len(actual_answers) == len(expected_answers), \
            f"Answer count mismatch: expected {len(expected_answers)}, got {len(actual_answers)}"

        for i, (actual, expected) in enumerate(zip(actual_answers, expected_answers)):
            assert str(actual) == str(expected), \
                f"Answer {i} mismatch: expected '{expected}', got '{actual}'"

    def test_canvas_presence(self, app_data, q_id, language, annotation):
        """Canvas presence should match annotation."""
        lang_ann = annotation["languages"][language]
        seed = annotation["seed"]

        page, q, lib = evaluate_question(app_data, q_id, language, seed=seed)

        html_output = "".join(str(l) for l in page.lines)
        has_canvas = "Raphael(" in html_output or "sel_canvas_" in html_output
        assert has_canvas == lang_ann["has_canvas"], \
            f"Canvas presence mismatch: expected {lang_ann['has_canvas']}, got {has_canvas}"

    def test_table_presence(self, app_data, q_id, language, annotation):
        """Table presence should match annotation."""
        lang_ann = annotation["languages"][language]
        seed = annotation["seed"]

        page, q, lib = evaluate_question(app_data, q_id, language, seed=seed)

        html_output = "".join(str(l) for l in page.lines)
        has_table = "<table" in html_output
        assert has_table == lang_ann["has_table"], \
            f"Table presence mismatch: expected {lang_ann['has_table']}, got {has_table}"
