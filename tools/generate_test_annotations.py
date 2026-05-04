#!/usr/bin/env python3
"""
Generate test annotations for questions.

Usage:
    # Generate annotations for all questions that don't have one yet:
    python tools/generate_test_annotations.py

    # Regenerate annotations for ALL questions (overwrite existing):
    python tools/generate_test_annotations.py --force

    # Generate annotation for a specific question:
    python tools/generate_test_annotations.py --question numbers/q00001

    # Generate with a different seed:
    python tools/generate_test_annotations.py --seed 42
"""
import sys
import os
import json
import random
import re
import argparse
import logging
import traceback

# Add src to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'src'))

from server.app_data import AppData
from server.page import Page
from server.question import Question
from server.types import PageLanguage

logging.basicConfig(level=logging.WARNING)


def extract_solutions_from_list(solutions):
    """Extract expected answers from a list of solution JS strings."""
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


def get_question_languages(app_data, q_id):
    """Get all languages available for a specific question."""
    q = app_data.repository.get_question(q_id)
    if q is None:
        return []
    languages = []
    for key in q.keys():
        if key.startswith("text."):
            lang = key[5:]
            if lang in ["rs", "uk", "sl", "mk"]:
                languages.append(lang)
    return sorted(languages)


def evaluate_question_safe(app_data, q_id, language, seed):
    """Evaluate a question, returning results or None on failure."""
    try:
        random.seed(seed)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.fromStr(language))
        page.page_params.set_param("q_id", q_id)

        q = Question(page, q_id=q_id, language=PageLanguage.fromStr(language))
        q.set_from_file()
        q.eval(page)
        return page, q, q.lib
    except Exception as e:
        return None


def generate_annotation(app_data, q_id, seed=42):
    """Generate annotation for a single question across all its languages."""
    languages = get_question_languages(app_data, q_id)
    if not languages:
        return None

    annotation = {
        "seed": seed,
        "languages": {}
    }

    for lang in languages:
        result = evaluate_question_safe(app_data, q_id, lang, seed)
        if result is None:
            print(f"  WARNING: {q_id}/{lang} failed to evaluate, skipping language")
            continue

        page, q, lib = result

        # Extract data
        html_output = "".join(str(l) for l in page.lines)
        has_canvas = "Raphael(" in html_output or "sel_canvas_" in html_output
        has_table = "<table" in html_output

        # Use last_checks/last_solutions (saved before clear)
        checks = getattr(lib, 'last_checks', lib.checks)
        solutions = getattr(lib, 'last_solutions', lib.solutions)
        check_types = [classify_check_type(c) for c in checks]
        expected_answers = extract_solutions_from_list(solutions)

        # Get rand_vals_used from LibMath
        rand_vals_used = lib.math.rand_vals_used

        annotation["languages"][lang] = {
            "rand_vals_used": rand_vals_used,
            "num_checks": len(checks),
            "check_types": check_types,
            "expected_answers": expected_answers,
            "has_canvas": has_canvas,
            "has_table": has_table
        }

    if not annotation["languages"]:
        return None

    return annotation


def discover_all_question_ids(app_data):
    """Discover all question IDs by walking the questions directory."""
    questions_dir = os.path.join(app_data.rel_path, "questions")
    q_ids = []
    for root, dirs, files in os.walk(questions_dir):
        # A question directory contains at least one text.* file
        has_text = any(f.startswith("text.") for f in files)
        if has_text:
            q_id = os.path.relpath(root, questions_dir).replace("\\", "/")
            # Skip global directory
            if not q_id.startswith("global"):
                q_ids.append(q_id)
    return sorted(q_ids)


def main():
    parser = argparse.ArgumentParser(description="Generate test annotations for questions")
    parser.add_argument("--force", action="store_true",
                       help="Regenerate annotations for all questions (overwrite existing)")
    parser.add_argument("--question", type=str, default=None,
                       help="Generate annotation for a specific question (e.g., numbers/q00001)")
    parser.add_argument("--seed", type=int, default=42,
                       help="Random seed to use (default: 42)")
    args = parser.parse_args()

    rel_path = os.path.join(os.path.dirname(__file__), '..')
    print("Loading questions...")
    app_data = AppData(use_azure_blob=False, preload=True, rel_path=rel_path)
    questions_dir = os.path.join(app_data.rel_path, "questions")

    if args.question:
        q_ids = [args.question]
    else:
        q_ids = discover_all_question_ids(app_data)

    print(f"Found {len(q_ids)} questions")

    generated = 0
    skipped = 0
    failed = 0

    for q_id in q_ids:
        ann_path = os.path.join(questions_dir, q_id, "test_annotations.json")

        # Skip if annotation exists and not forcing
        if os.path.exists(ann_path) and not args.force:
            skipped += 1
            continue

        print(f"  Generating: {q_id}...", end="", flush=True)
        try:
            annotation = generate_annotation(app_data, q_id, seed=args.seed)
            if annotation is None:
                print(" SKIP (no languages)")
                skipped += 1
                continue

            # Write annotation file
            with open(ann_path, 'w', encoding='utf-8') as f:
                json.dump(annotation, f, indent=2, ensure_ascii=False)

            langs = list(annotation["languages"].keys())
            total_checks = sum(ann["num_checks"] for ann in annotation["languages"].values())
            print(f" OK ({langs}, {total_checks} checks)")
            generated += 1
        except Exception as e:
            print(f" FAILED: {e}")
            traceback.print_exc()
            failed += 1

    print(f"\nDone: {generated} generated, {skipped} skipped, {failed} failed")


if __name__ == "__main__":
    main()
