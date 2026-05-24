"""
Visual regression tests: render each question, screenshot it, and compare
against stored .png baselines.

No running server required — renders HTML fragments in Playwright directly.

Usage:
    # Generate .png baselines for questions that don't have one yet:
    pytest tests/test_question_visual.py --update-snapshots
    pytest tests/test_question_visual.py --update-snapshots --question "numb_2/q00001"

    # Regenerate ALL .png baselines (overwrite existing):
    pytest tests/test_question_visual.py --regenerate-snapshots

    # Compare current rendering against stored baselines:
    pytest tests/test_question_visual.py
    pytest tests/test_question_visual.py --question "numb_2/q00001"

Prerequisites:
    pip install playwright Pillow
    playwright install chromium

Baselines live at: questions/<category>/<qNNNNN>/tests/<lang>.png
"""
import os
import platform
import sys
import time
import random
import tempfile

import pytest

from conftest import get_app_data
from test_question_baselines import (
    render_question_html,
    discover_existing_baselines,
    discover_question_language_pairs,
    QUESTIONS_ROOT,
    SEED,
)

# Pixel difference threshold (fraction of total pixels that may differ)
PIXEL_THRESHOLD = 0.001  # 0.1%


# ---------------------------------------------------------------------------
# HTML wrapper — makes question fragments renderable as a standalone page
# ---------------------------------------------------------------------------

HTML_WRAPPER = """\
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {{
    font-family: Arial, sans-serif;
    font-size: 16px;
    margin: 20px;
    background: white;
}}
div.space {{
    display: inline-block;
    padding-left: 6px;
    padding-right: 6px;
}}
input[type="text"] {{
    padding: 3px;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 16px;
}}
select {{
    font-size: 16px;
    padding: 2px;
}}
table {{
    border-collapse: collapse;
}}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script>
// Stubs for question JS functions
function setError(id) {{
    var el = document.getElementById(id);
    if (el) el.style.border = "3px solid red";
}}
function setOK(id) {{
    var el = document.getElementById(id);
    if (el) el.style.border = "3px solid green";
}}
function clearAllWBorder(id) {{
    var el = document.getElementById(id);
    if (el) el.style.border = "1px solid #ccc";
}}
function clearAllNoBorder(id) {{
    var el = document.getElementById(id);
    if (el) el.style.border = "0px solid white";
}}
var math = {{}};
math.eq = function(x, y, precision) {{
    if (typeof precision === 'undefined') precision = 0.00001;
    return Math.abs(x - y) < precision;
}};
// Stubs for globals that question scripts reference
var global_q_id = "";
var global_language = "";
var test_id = "";
var test_order = 0;
var attempt = 0;
</script>
</head>
<body>
{content}
<script>
// Signal to Playwright that rendering is complete
document.body.setAttribute('data-rendered', 'true');
</script>
</body>
</html>
"""


# Infobox stub — the RaphaelJS infobox plugin creates HTML overlays on SVG.
# We inject a minimal stub so questions that use it don't throw errors.
INFOBOX_STUB = """\
<script>
if (typeof Infobox === 'undefined') {
    function Infobox(paper, opts) {
        var x = opts.x || 0, y = opts.y || 0;
        var w = opts.width || 50, h = opts.height || 30;
        var div = document.createElement('div');
        div.style.position = 'absolute';
        div.style.left = x + 'px';
        div.style.top = y + 'px';
        div.style.width = w + 'px';
        div.style.height = h + 'px';
        var container = paper.canvas.parentNode;
        container.style.position = 'relative';
        container.appendChild(div);
        this.div = { html: function(content) { div.innerHTML = content; return this; } };
    }
}
</script>
"""


# Platform suffix for snapshot filenames (e.g., rs.win.png or rs.linux.png)
PLATFORM_SUFFIX = "linux" if platform.system() == "Linux" else "win"


def snapshot_path(q_id, language_str):
    """Return the path where the .png baseline for q_id/language lives."""
    return os.path.join(QUESTIONS_ROOT, q_id, "tests", f"{language_str}.{PLATFORM_SUFFIX}.png")


def discover_existing_snapshots():
    """Discover (q_id, lang) pairs that already have .png baseline files for this platform."""
    suffix = f".{PLATFORM_SUFFIX}.png"
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
                if fname.endswith(suffix):
                    lang = fname[:-len(suffix)]
                    pairs.append((q_id, lang))
    return pairs


def render_to_full_html(app_data, q_id, language):
    """Render a question and return a complete standalone HTML page."""
    html_fragment = render_question_html(app_data, q_id, language)
    # Insert Infobox stub right before the question content
    full_html = HTML_WRAPPER.format(content=INFOBOX_STUB + html_fragment)
    return full_html


def compare_screenshots(baseline_bytes, current_bytes):
    """Compare two PNG screenshots. Returns (passed, diff_ratio)."""
    from PIL import Image
    import io

    baseline_img = Image.open(io.BytesIO(baseline_bytes)).convert("RGBA")
    current_img = Image.open(io.BytesIO(current_bytes)).convert("RGBA")

    if baseline_img.size != current_img.size:
        return False, f"size {baseline_img.size} vs {current_img.size}"

    total_pixels = baseline_img.size[0] * baseline_img.size[1]
    diff_pixels = 0

    baseline_data = baseline_img.tobytes()
    current_data = current_img.tobytes()

    # Compare RGBA byte-by-byte (4 bytes per pixel)
    for i in range(0, len(baseline_data), 4):
        if baseline_data[i:i+4] != current_data[i:i+4]:
            diff_pixels += 1

    diff_ratio = diff_pixels / total_pixels
    if diff_ratio > PIXEL_THRESHOLD:
        return False, f"{diff_ratio:.3%} pixels differ"
    return True, f"{diff_ratio:.3%}"


# ---------------------------------------------------------------------------
# Test
# ---------------------------------------------------------------------------

class TestVisualBaselines:
    """Screenshot-based visual regression tests (no server required)."""

    def test_visual_matches_baseline(self, app_data, request, capsys):
        """Render questions, screenshot them, and compare against stored .png baselines."""
        update_mode = request.config.getoption("--update-snapshots")
        regenerate_mode = request.config.getoption("--regenerate-snapshots")
        question_filter = request.config.getoption("--question")

        if update_mode or regenerate_mode:
            pairs = discover_question_language_pairs()
        else:
            pairs = discover_existing_snapshots()
            if not pairs:
                pytest.skip(
                    "No .png baseline files found. "
                    "Run with --update-snapshots to generate them."
                )

        if question_filter:
            pairs = [(q, l) for q, l in pairs if question_filter in q]

        # In update mode (not regenerate), skip pairs that already have a .png
        if update_mode and not regenerate_mode:
            pairs = [(q, l) for q, l in pairs if not os.path.exists(snapshot_path(q, l))]
            if not pairs:
                pytest.skip("All questions already have .png baselines (use --regenerate-snapshots to overwrite)")

        if not pairs:
            pytest.skip("No questions matched the filter")

        from playwright.sync_api import sync_playwright

        failures = []
        updated = 0
        passed = 0

        with capsys.disabled():
            with sync_playwright() as p:
                browser = p.chromium.launch()
                page = browser.new_page(viewport={"width": 800, "height": 600})

                for i, (q_id, language) in enumerate(pairs):
                    bp = snapshot_path(q_id, language)
                    label = f"{q_id}/{language}"

                    t_start = time.perf_counter()

                    try:
                        full_html = render_to_full_html(app_data, q_id, language)
                    except Exception as e:
                        failures.append(f"{label}: render error: {e}")
                        sys.stdout.write(f"\r\033[KFAILED {label}: {e}\n")
                        sys.stdout.flush()
                        continue

                    # Write HTML to a temp file and load in browser
                    with tempfile.NamedTemporaryFile(
                        mode='w', suffix='.html', encoding='utf-8', delete=False
                    ) as tmp:
                        tmp.write(full_html)
                        tmp_path = tmp.name

                    try:
                        page.goto(f"file:///{tmp_path.replace(os.sep, '/')}")

                        # Wait for RaphaelJS/Infobox rendering
                        page.wait_for_function(
                            "document.body.getAttribute('data-rendered') === 'true'",
                            timeout=10000,
                        )
                        # Extra time for SVG/canvas to settle
                        page.wait_for_timeout(500)

                        # Take screenshot of the full page
                        screenshot_bytes = page.screenshot(full_page=True)

                        elapsed = time.perf_counter() - t_start

                        if update_mode or regenerate_mode:
                            os.makedirs(os.path.dirname(bp), exist_ok=True)
                            with open(bp, "wb") as f:
                                f.write(screenshot_bytes)
                            updated += 1
                            sys.stdout.write(
                                f"\r\033[K  Updated {label} [{updated}/{len(pairs)}] ({elapsed:.2f}s)\n"
                            )
                            sys.stdout.flush()
                        else:
                            with open(bp, "rb") as f:
                                baseline_bytes = f.read()

                            ok, detail = compare_screenshots(baseline_bytes, screenshot_bytes)

                            if ok:
                                passed += 1
                                sys.stdout.write(
                                    f"\r\033[K  {label} [{passed}/{len(pairs)}] ({elapsed:.2f}s)"
                                )
                                sys.stdout.flush()
                            else:
                                failures.append(f"{label}: {detail}")
                                sys.stdout.write(f"\r\033[KFAILED {label} ({elapsed:.2f}s)\n")
                                sys.stdout.flush()

                    finally:
                        os.unlink(tmp_path)

                browser.close()

            sys.stdout.write("\r\033[K")
            sys.stdout.flush()

            if update_mode or regenerate_mode:
                print(f"\nUpdated {updated} visual baselines.")
            else:
                print(f"\n{passed} passed, {len(failures)} failed out of {len(pairs)}")

        if update_mode or regenerate_mode:
            pytest.skip(f"{updated} visual baselines updated")
        elif failures:
            detail = "\n".join(failures[:20])
            if len(failures) > 20:
                detail += f"\n... and {len(failures) - 20} more"
            pytest.fail(
                f"{passed} passed, {len(failures)} failed out of "
                f"{len(pairs)}\n\n{detail}",
                pytrace=False,
            )
