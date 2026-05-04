"""
Visual regression tests: screenshot each question and compare against baselines.

Usage:
    # First run — generate baselines:
    pytest tests/test_question_visual.py --update-snapshots

    # Subsequent runs — detect visual regressions:
    pytest tests/test_question_visual.py

Prerequisites:
    1. pip install playwright pytest-playwright
    2. playwright install chromium
    3. Start dev server: cd src/cherrypy && python main.py
"""
import os
import sys
import json

import pytest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'src'))

from conftest import get_questions_dir


BASE_URL = "http://localhost:8080"
SCREENSHOTS_DIR = os.path.join(os.path.dirname(__file__), "screenshots")


@pytest.fixture(scope="session")
def app_data():
    """Load AppData for annotation reading."""
    from server.app_data import AppData
    import logging
    logging.basicConfig(level=logging.WARNING)
    rel_path = os.path.join(os.path.dirname(__file__), '..')
    return AppData(use_azure_blob=False, preload=True, rel_path=rel_path)


@pytest.fixture(scope="session")
def dev_server():
    """Ensure dev server is running (same as browser test)."""
    import socket
    import subprocess
    import time

    def is_port_open(port):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            return s.connect_ex(('localhost', port)) == 0

    if is_port_open(8080):
        yield BASE_URL
        return

    server_dir = os.path.join(os.path.dirname(__file__), '..', 'src', 'cherrypy')
    env = os.environ.copy()
    env['SHKOLA_REL_PATH'] = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    env['SHKOLA_IP_ADDR'] = '127.0.0.1'
    env['SHKOLA_PORT'] = '8080'

    proc = subprocess.Popen(
        [sys.executable, 'main.py'],
        cwd=server_dir,
        env=env,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )

    for _ in range(30):
        if is_port_open(8080):
            break
        time.sleep(1)
    else:
        proc.kill()
        raise RuntimeError("Dev server failed to start")

    yield BASE_URL
    proc.terminate()
    proc.wait(timeout=5)


def collect_visual_test_questions(app_data):
    """Collect questions for visual testing (rs language only to limit screenshot count)."""
    questions_dir = get_questions_dir(app_data)
    items = []
    for root, dirs, files in os.walk(questions_dir):
        if "test_annotations.json" in files:
            q_id = os.path.relpath(root, questions_dir).replace("\\", "/")
            ann_path = os.path.join(root, "test_annotations.json")
            with open(ann_path, 'r', encoding='utf-8') as f:
                annotation = json.load(f)
            # Use 'rs' for visual baselines (most common language)
            if "rs" in annotation.get("languages", {}):
                items.append((q_id, "rs"))
            else:
                # Fall back to first available language
                langs = list(annotation.get("languages", {}).keys())
                if langs:
                    items.append((q_id, langs[0]))
    return items


class TestVisualRegression:
    """Screenshot-based visual regression tests."""

    @pytest.fixture(autouse=True)
    def setup(self, dev_server):
        self.base_url = dev_server
        os.makedirs(SCREENSHOTS_DIR, exist_ok=True)

    def test_question_visual(self, page, app_data, request):
        """Take screenshots of all annotated questions and compare to baselines."""
        update_snapshots = request.config.getoption("--update-snapshots", default=False)
        items = collect_visual_test_questions(app_data)

        if not items:
            pytest.skip("No annotated questions found")

        failures = []

        for q_id, lang in items:
            # Set consistent viewport
            page.set_viewport_size({"width": 1280, "height": 720})

            url = f"{self.base_url}/main?op=view&q_id={q_id}&language={lang}"
            page.goto(url, wait_until="networkidle")

            # Wait for rendering (MathJax, RaphaelJS)
            page.wait_for_timeout(2000)

            # Screenshot filename
            safe_name = q_id.replace("/", "_")
            screenshot_path = os.path.join(SCREENSHOTS_DIR, f"{safe_name}_{lang}.png")
            baseline_path = os.path.join(SCREENSHOTS_DIR, f"{safe_name}_{lang}_baseline.png")

            if update_snapshots or not os.path.exists(baseline_path):
                # Save as baseline
                page.screenshot(path=baseline_path, full_page=True)
            else:
                # Take current screenshot and compare
                page.screenshot(path=screenshot_path, full_page=True)

                # Use Playwright's built-in assertion for visual comparison
                # This uses pixel matching with configurable threshold
                try:
                    from PIL import Image
                    import math

                    baseline = Image.open(baseline_path)
                    current = Image.open(screenshot_path)

                    if baseline.size != current.size:
                        failures.append(f"{q_id}/{lang}: size changed {baseline.size} -> {current.size}")
                        continue

                    # Simple pixel comparison
                    diff_pixels = 0
                    total_pixels = baseline.size[0] * baseline.size[1]
                    baseline_data = list(baseline.getdata())
                    current_data = list(current.getdata())

                    for b_pixel, c_pixel in zip(baseline_data, current_data):
                        if b_pixel != c_pixel:
                            diff_pixels += 1

                    diff_ratio = diff_pixels / total_pixels
                    # Allow 1% pixel difference (for anti-aliasing, etc.)
                    if diff_ratio > 0.01:
                        failures.append(
                            f"{q_id}/{lang}: {diff_ratio:.2%} pixels differ"
                        )
                except ImportError:
                    # PIL not installed, just check file sizes match roughly
                    baseline_size = os.path.getsize(baseline_path)
                    current_size = os.path.getsize(screenshot_path)
                    # Allow 10% file size difference
                    if abs(baseline_size - current_size) / max(baseline_size, 1) > 0.10:
                        failures.append(
                            f"{q_id}/{lang}: file size changed {baseline_size} -> {current_size}"
                        )

        if failures:
            pytest.fail("Visual regressions detected:\n" + "\n".join(failures))


def pytest_addoption(parser):
    """Add --update-snapshots option."""
    parser.addoption(
        "--update-snapshots",
        action="store_true",
        default=False,
        help="Update visual regression baselines instead of comparing",
    )
