# Testing

This project includes a multi-layer testing harness for verifying math question scripts.

## Quick Start

```bash
# Install test dependencies
pip install -r tests/requirements.txt

# Install Playwright browser (for browser tests)
playwright install chromium

# Generate test annotations for all questions (first time)
python tools/generate_test_annotations.py --force

# Run Python-level tests (fast, no browser needed)
pytest tests/test_question_smoke.py
pytest tests/test_question_answers.py

# Run browser tests (requires dev server)
cd src/cherrypy && python main.py &
pytest tests/test_question_browser.py
pytest tests/test_question_visual.py --update-snapshots  # first run: generate baselines
pytest tests/test_question_visual.py                      # subsequent: detect regressions
```

## Test Layers

### 1. Smoke Tests (`tests/test_question_smoke.py`)

Evaluates every question across all languages with multiple random seeds (42, 123, 999).
Verifies:
- No exceptions during evaluation
- Page output is non-empty
- At least one answer check field exists

### 2. Answer Correctness Tests (`tests/test_question_answers.py`)

For questions with `test_annotations.json`, verifies:
- Number of check fields matches annotation
- Check field types (number, string, radio, fraction, canvas) match
- Expected answer values match
- Canvas/table presence matches

### 3. Browser Tests (`tests/test_question_browser.py`)

Uses Playwright to render questions in a real browser and verify:
- No JavaScript console errors
- All input fields have proper IDs
- Correct answers are accepted by the JS validation logic

### 4. Visual Regression Tests (`tests/test_question_visual.py`)

Screenshots each question and compares against baselines:
- First run with `--update-snapshots` saves baselines
- Subsequent runs detect pixel-level changes

## Annotation Generator

```bash
# Generate annotations for new questions only (safe to re-run):
python tools/generate_test_annotations.py

# Regenerate ALL annotations (after intentional changes):
python tools/generate_test_annotations.py --force

# Generate for one specific question:
python tools/generate_test_annotations.py --question numbers/q00001

# Use a different seed:
python tools/generate_test_annotations.py --seed 123
```

## Annotation File Format

Each question directory can have a `test_annotations.json`:

```json
{
  "seed": 42,
  "languages": {
    "rs": {
      "rand_vals_used": [5, 3, 7, 2],
      "num_checks": 2,
      "check_types": ["number", "number"],
      "expected_answers": ["8", "5"],
      "has_canvas": true,
      "has_table": false
    },
    "uk": {
      "rand_vals_used": [5, 3, 7, 2],
      "num_checks": 2,
      "check_types": ["number", "number"],
      "expected_answers": ["8", "5"],
      "has_canvas": true,
      "has_table": false
    }
  }
}
```

## Workflow for New Questions

1. Write the question (`init.lua`, `text.rs`, etc.)
2. Run: `python tools/generate_test_annotations.py`
   - Automatically detects new questions without annotations
3. Review the generated `test_annotations.json` in the question directory
4. Run: `pytest tests/` to verify everything passes
5. (Optional) Run browser tests for visual verification

## Playwright Safety

Playwright only connects to `localhost:8080` (the local CherryPy dev server). It never accesses external websites. It is a standard Microsoft-developed testing library that runs a sandboxed Chromium instance locally.
