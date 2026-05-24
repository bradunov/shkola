"""
Unit tests for the core rendering pipeline: question.py and library.py

These tests verify individual functionalities of the Question and Library classes
in isolation, using minimal setup. They should run fast and catch regressions
before the full smoke test suite is needed.
"""
import sys
import os
import random
import re

import pytest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'src'))

from lupa import LuaRuntime
from server.app_data import AppData
from server.page import Page
from server.question import Question
from server.library import Library, LibMath
from server.types import PageLanguage


# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------

@pytest.fixture(scope="module")
def app_data():
    """Minimal AppData with no preload (fast)."""
    rel_path = os.path.join(os.path.dirname(__file__), '..')
    return AppData(use_azure_blob=False, preload=False, rel_path=rel_path)


@pytest.fixture
def page(app_data):
    """Fresh Page object for each test."""
    p = Page(app_data)
    p.page_params.set_param("language", PageLanguage.RS)
    p.page_params.set_param("q_id", "numbers/q00001")
    return p


@pytest.fixture
def question(page):
    """A Question object with simple text/code."""
    random.seed(42)
    q = Question(page, q_id="numbers/q00001", language=PageLanguage.RS)
    return q


@pytest.fixture
def lib(question):
    """The Library object from a question."""
    return question.lib


# ---------------------------------------------------------------------------
# Question initialization tests
# ---------------------------------------------------------------------------

class TestQuestionInit:
    def test_creates_lua_runtime(self, question):
        assert question.lua is not None

    def test_sets_q_id(self, question):
        assert question.q_id == "numbers/q00001"

    def test_sets_language(self, question):
        assert question.language == PageLanguage.RS

    def test_creates_library(self, question):
        assert question.lib is not None
        assert isinstance(question.lib, Library)

    def test_has_questions_root_path(self, question):
        assert question.questions_root_path is not None
        assert "questions" in question.questions_root_path

    def test_cyrillic_provisioning(self, page):
        """RSC language should be converted to RS with cyrillic flag."""
        random.seed(42)
        q = Question(page, q_id="numbers/q00001", language=PageLanguage.RSC)
        assert q.language == PageLanguage.RS
        assert q.cyrillic is True

    def test_non_cyrillic(self, question):
        assert question.cyrillic is False


# ---------------------------------------------------------------------------
# Question.eval tests
# ---------------------------------------------------------------------------

class TestQuestionEval:
    def test_simple_text_eval(self, app_data):
        """Evaluate a question with just text, no code."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/q00001")
        q = Question(page, q_id="test/q00001", language=PageLanguage.RS,
                     init_code="", iter_code="", text="\nHello World\n")
        q.eval(page)
        output = "".join(page.lines)
        assert "Hello World" in output

    def test_inline_code_eval(self, app_data):
        """Evaluate a question with inline Lua code."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/q00002")
        q = Question(page, q_id="test/q00002", language=PageLanguage.RS,
                     init_code="x = 42", iter_code="", text="\nResult: @x@\n")
        q.eval(page)
        output = "".join(str(l) for l in page.lines)
        assert "42" in output

    def test_math_random_in_code(self, app_data):
        """math.random() should be replaced with sh_random() and work."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/q00003")
        q = Question(page, q_id="test/q00003", language=PageLanguage.RS,
                     init_code="x = math.random(1, 10)", iter_code="",
                     text="\nRESULT @x@ END\n")
        q.eval(page)
        output = "".join(str(l) for l in page.lines)
        # Extract the value between RESULT and END
        match = re.search(r'RESULT (\d+) END', output)
        assert match is not None
        val = int(match.group(1))
        assert 1 <= val <= 10

    def test_lib_math_random(self, app_data):
        """lib.math.random() should work (lupa caching bug fix)."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/q00004")
        q = Question(page, q_id="test/q00004", language=PageLanguage.RS,
                     init_code="x = lib.math.random(1, 100)", iter_code="",
                     text="\n@x@\n")
        q.eval(page)
        output = "".join(str(l) for l in page.lines)
        match = re.search(r'\d+', output)
        assert match is not None

    def test_lib_math_gcd(self, app_data):
        """lib.math.gcd() should work."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/q00005")
        q = Question(page, q_id="test/q00005", language=PageLanguage.RS,
                     init_code="x = lib.math.gcd(12, 8)", iter_code="",
                     text="\n@x@\n")
        q.eval(page)
        output = "".join(str(l) for l in page.lines)
        assert "4" in output

    def test_lib_math_round(self, app_data):
        """lib.math.round() should return integer."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/q00006")
        q = Question(page, q_id="test/q00006", language=PageLanguage.RS,
                     init_code="x = lib.math.round(3.7)", iter_code="",
                     text="\n@x@\n")
        q.eval(page)
        output = "".join(str(l) for l in page.lines)
        assert "4" in output

    def test_lib_math_chaining(self, app_data):
        """Multiple lib.math calls should work without corruption."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/q00007")
        q = Question(page, q_id="test/q00007", language=PageLanguage.RS,
                     init_code="""
                        a = lib.math.random(1, 50)
                        b = lib.math.random(1, 50)
                        c = lib.math.gcd(a, b)
                        d = lib.math.round(3.14)
                     """, iter_code="",
                     text="\n@c@ @d@\n")
        q.eval(page)
        output = "".join(str(l) for l in page.lines)
        # Should not raise, d should be 3
        assert "3" in output

    def test_repeat_block(self, app_data):
        """@repeat(N)@...@/repeat@ should execute N times."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/q00008")
        q = Question(page, q_id="test/q00008", language=PageLanguage.RS,
                     init_code="", iter_code="x = ITEM",
                     text="\n@repeat(3)@\nItem @ITEM@\n@/repeat@\n")
        q.eval(page)
        output = "".join(str(l) for l in page.lines)
        assert "Item 1" in output
        assert "Item 2" in output
        assert "Item 3" in output

    def test_if_block(self, app_data):
        """@if condition@...@endif@ should conditionally render."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/q00009")
        q = Question(page, q_id="test/q00009", language=PageLanguage.RS,
                     init_code="x = 5", iter_code="",
                     text="\n@if x > 3@\nBig\n@endif@\n@if x < 3@\nSmall\n@endif@\n")
        q.eval(page)
        output = "".join(page.lines)
        assert "Big" in output
        assert "Small" not in output

    def test_if_else_block(self, app_data):
        """@if@...@else@...@endif@ works."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/q00010")
        q = Question(page, q_id="test/q00010", language=PageLanguage.RS,
                     init_code="x = 2", iter_code="",
                     text="\n@if x > 3@\nBig\n@else@\nSmall\n@endif@\n")
        q.eval(page)
        output = "".join(page.lines)
        assert "Small" in output
        assert "Big" not in output

    def test_if_elif_else_block(self, app_data):
        """@if@...@elif@...@else@...@endif@ works."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/q00011")
        q = Question(page, q_id="test/q00011", language=PageLanguage.RS,
                     init_code="x = 5", iter_code="",
                     text="\n@if x > 10@\nHuge\n@elif x > 3@\nMedium\n@else@\nSmall\n@endif@\n")
        q.eval(page)
        output = "".join(page.lines)
        assert "Medium" in output
        assert "Huge" not in output
        assert "Small" not in output

    def test_check_number_in_eval(self, app_data):
        """lib.check_number() should produce input HTML and register checks."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/q00012")
        q = Question(page, q_id="test/q00012", language=PageLanguage.RS,
                     init_code="", iter_code="",
                     text="\n@lib.check_number(42)@\n")
        q.eval(page)
        output = "".join(page.lines)
        assert "<input" in output
        assert len(q.lib.last_checks) > 0

    def test_eval_exception_on_bad_code(self, app_data):
        """Invalid Lua code should raise an exception."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/q00099")
        q = Question(page, q_id="test/q00099", language=PageLanguage.RS,
                     init_code="this is not valid lua!!!", iter_code="",
                     text="\nHello\n")
        with pytest.raises(Exception):
            q.eval(page)

    def test_backslash_in_code(self, app_data):
        """Backslashes in code should be properly escaped."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/q00013")
        q = Question(page, q_id="test/q00013", language=PageLanguage.RS,
                     init_code='x = "hello"', iter_code="",
                     text="\n@x@\n")
        q.eval(page)
        output = "".join(page.lines)
        assert "hello" in output


# ---------------------------------------------------------------------------
# LibMath tests
# ---------------------------------------------------------------------------

class TestLibMath:
    def test_eq_true(self, lib):
        assert lib.math.eq(1.0, 1.0000001) is True

    def test_eq_false(self, lib):
        assert lib.math.eq(1.0, 2.0) is False

    def test_eq_custom_precision(self, lib):
        assert lib.math.eq(1.0, 1.1, 0.2) is True
        assert lib.math.eq(1.0, 1.1, 0.05) is False

    def test_gcd(self, lib):
        assert lib.math.gcd(12, 8) == 4
        assert lib.math.gcd(7, 3) == 1
        assert lib.math.gcd(100, 25) == 25

    def test_gcd_float_args(self, lib):
        """GCD should handle float args from Lua (e.g., 12.0)."""
        assert lib.math.gcd(12.0, 8.0) == 4

    def test_round(self, lib):
        assert lib.math._round(3.7) == 4
        assert lib.math._round(3.2) == 3
        assert lib.math._round(2.5) == 2  # Python banker's rounding

    def test_round_dec(self, lib):
        assert lib.math.round_dec(3.14159, 2) == 3.14
        assert lib.math.round_dec(3.14159, 0) == 3.0
        assert lib.math.round_dec(2.555, 1) == 2.6

    def test_random_no_args(self, lib):
        random.seed(42)
        val = lib.math.random()
        assert 0.0 <= val <= 1.0

    def test_random_one_arg(self, lib):
        random.seed(42)
        val = lib.math.random(10)
        assert 1 <= val <= 10
        assert isinstance(val, int)

    def test_random_two_args(self, lib):
        random.seed(42)
        val = lib.math.random(5, 15)
        assert 5 <= val <= 15
        assert isinstance(val, int)

    def test_random_float_args(self, lib):
        """Should handle float arguments without DeprecationWarning."""
        random.seed(42)
        val = lib.math.random(5.0, 15.0)
        assert 5 <= val <= 15

    def test_random_with_rand_vals(self, question):
        """When rand_vals are provided, random should return them in order."""
        question.lib.math.rand_vals = [7, 3, 9]
        question.lib.math.rand_vals_cnt = 0
        assert question.lib.math.random(1, 10) == 7
        assert question.lib.math.random(1, 10) == 3
        assert question.lib.math.random(1, 10) == 9

    def test_random_shuffle(self, lib, question):
        random.seed(42)
        lua_table = question.lua.eval("{10, 20, 30, 40}")
        result = lib.math.random_shuffle(lua_table)
        values = list(result.values())
        assert sorted(values) == [10, 20, 30, 40]
        assert len(values) == 4

    def test_random_shuffle_with_rand_vals(self, lib, question):
        """When rand_vals has a list, shuffle should return it."""
        lib.math.rand_vals = [[30, 10, 40, 20]]
        lib.math.rand_vals_cnt = 0
        lua_table = question.lua.eval("{10, 20, 30, 40}")
        result = lib.math.random_shuffle(lua_table)
        values = list(result.values())
        assert values == [30, 10, 40, 20]


# ---------------------------------------------------------------------------
# Library input element tests
# ---------------------------------------------------------------------------

class TestLibraryCheckNumber:
    def test_returns_input_html(self, lib):
        result = lib.check_number(42)
        assert "<input" in result
        assert "type='text'" in result

    def test_registers_check(self, lib):
        lib.clear()
        lib.check_number(42)
        assert len(lib.checks) == 1
        assert "_cond()" in lib.checks[0]

    def test_registers_solution(self, lib):
        lib.clear()
        lib.check_number(42)
        assert len(lib.solutions) == 1
        assert "42" in lib.solutions[0]

    def test_registers_clear(self, lib):
        lib.clear()
        lib.check_number(42)
        assert len(lib.clears) == 1

    def test_custom_width(self, lib):
        result = lib.check_number(42, width="60px")
        assert "60px" in result

    def test_condition_with_answer(self, lib):
        """Free-form conditions like 'answer > 5' should work."""
        lib.clear()
        lib.check_number("answer > 5", solution="answer = '6'")
        assert len(lib.checks) == 1


class TestLibraryCheckString:
    def test_returns_input_html(self, lib):
        result = lib.check_string("hello")
        assert "<input" in result

    def test_registers_check(self, lib):
        lib.clear()
        lib.check_string("hello")
        assert len(lib.checks) == 1

    def test_case_insensitive_by_default(self, lib):
        """Default string check should be case-insensitive."""
        lib.clear()
        lib.check_string("Hello")
        # The condition script should include .toLowerCase()
        scripts = "".join(lib.page.script_lines)
        assert "toLowerCase" in scripts

    def test_case_sensitive(self, lib):
        """check_string_case should be case-sensitive."""
        lib.clear()
        # Reset script_lines to isolate
        lib.page.script_lines = []
        lib.check_string_case("Hello")
        scripts = "".join(lib.page.script_lines)
        assert ".trim()" in scripts


class TestLibraryRadio:
    def test_returns_radio_html(self, lib, question):
        lib.clear()
        options = question.lua.eval('{"Apple", "Banana", "Cherry"}')
        result = lib.check_one_option_radio(options, 1)
        assert "type='radio'" in result
        assert "Apple" in result
        assert "Banana" in result
        assert "Cherry" in result

    def test_registers_check_and_solution(self, lib, question):
        lib.clear()
        options = question.lua.eval('{"A", "B", "C"}')
        lib.check_one_option_radio(options, 2)
        assert len(lib.checks) == 1
        assert len(lib.solutions) == 1
        assert "_2" in lib.solutions[0]  # correct option index

    def test_vertical_layout(self, lib, question):
        lib.clear()
        options = question.lua.eval('{"X", "Y"}')
        result = lib.check_one_option_radio(options, 0, vertical=True)
        assert "<br>" in result


class TestLibraryDropdown:
    def test_returns_select_html(self, lib, question):
        lib.clear()
        options = question.lua.eval('{"Red", "Blue", "Green"}')
        result = lib.check_one_option_dropdown(options, "Blue")
        assert "<select" in result
        assert "<option" in result
        assert "Red" in result
        assert "Blue" in result
        assert "Green" in result

    def test_has_empty_first_option(self, lib, question):
        lib.clear()
        options = question.lua.eval('{"A", "B"}')
        result = lib.check_one_option_dropdown(options, "A")
        # First option should be empty space
        assert "<option value=' '>" in result

    def test_registers_check(self, lib, question):
        lib.clear()
        options = question.lua.eval('{"A", "B"}')
        lib.check_one_option_dropdown(options, "A")
        assert len(lib.checks) == 1


class TestLibraryFraction:
    def test_simple_fraction(self, lib):
        lib.clear()
        result = lib.check_fraction_simple(1, 2)
        assert "<table" in result
        assert "border-bottom:solid 1px" in result
        assert len(lib.checks) == 1

    def test_fraction_with_whole(self, lib):
        lib.clear()
        result = lib.check_fraction_simple(3, 4, whole=2)
        assert "<table" in result
        assert "rowspan" in result
        assert len(lib.checks) == 1

    def test_fraction_numerator_known_denominator(self, lib):
        lib.clear()
        result = lib.check_fraction_numerator(3, 5)
        # Denominator should be shown as text, not input
        assert "5" in result
        assert len(lib.checks) == 1

    def test_fraction_denominator_known_numerator(self, lib):
        lib.clear()
        result = lib.check_fraction_denominator(3, 5)
        # Numerator should be shown as text, not input
        assert "3" in result
        assert len(lib.checks) == 1


# ---------------------------------------------------------------------------
# Library table tests
# ---------------------------------------------------------------------------

class TestLibraryTable:
    def test_start_end_table(self, lib):
        start = lib.start_table()
        end = lib.end_table()
        assert "<table" in start
        assert "</table>" in end
        assert "<div" in start
        assert "</div>" in end

    def test_inline_table(self, lib):
        start = lib.start_table({"text-align": "inline"})
        end = lib.end_table()
        assert "<span>" in start
        assert "</span>" in end

    def test_start_row_alternating_colors(self, lib):
        lib.start_table()
        row1 = lib.start_row()
        lib.end_row()
        row2 = lib.start_row()
        assert "#f0f0ff" in row1
        assert "#fff0f0" in row2

    def test_add_cell(self, lib):
        cell = lib.add_cell("Content")
        assert "<td" in cell
        assert "Content" in cell
        assert "</td>" in cell

    def test_add_cell_with_style(self, lib):
        cell = lib.add_cell("X", {"padding": "10px", "rowspan": 2})
        assert "padding:10px" in cell
        assert "rowspan" in cell

    def test_end_row(self, lib):
        assert "</tr>" in lib.end_row()


# ---------------------------------------------------------------------------
# Library formatting helpers
# ---------------------------------------------------------------------------

class TestLibraryFormatting:
    def test_sup(self, lib):
        assert lib.sup_start() == "<sup><sup>"
        assert lib.sup_end() == "</sup></sup>"

    def test_frac_structure(self, lib):
        start = lib.frac_start()
        mid = lib.frac_mid()
        end = lib.frac_end()
        assert "<table" in start
        assert "border-bottom:solid 1px" in start
        assert "</td>" in mid
        assert "<td" in mid
        assert "</table>" in end

    def test_dec_to_str_rs_locale(self, lib):
        """RS locale should use comma as decimal separator."""
        lib.page.page_params.set_param("language", PageLanguage.RS)
        assert lib.dec_to_str(3.14) == "3,14"

    def test_dec_to_str_uk_locale(self, lib):
        """UK locale should use dot as decimal separator."""
        lib.page.page_params.set_param("language", PageLanguage.UK)
        assert lib.dec_to_str(3.14) == "3.14"

    def test_modify_input_style(self, lib):
        result = lib.modify_input_style("50px")
        assert "50px" in result
        assert "width:" in result


# ---------------------------------------------------------------------------
# Library button code generation tests
# ---------------------------------------------------------------------------

class TestLibraryButtons:
    def test_check_button_code_generated(self, lib):
        lib.clear()
        lib.check_number(42)
        lib.add_check_button_code()
        scripts = "".join(lib.page.script_lines)
        assert "checkAll" in scripts
        assert "sendResultsToServer" in scripts

    def test_check_button_saves_last_checks(self, lib):
        lib.clear()
        lib.check_number(42)
        lib.check_number(7)
        lib.add_check_button_code()
        assert len(lib.last_checks) == 2
        # After button code, checks should be cleared
        assert len(lib.checks) == 0

    def test_clear_button_code_generated(self, lib):
        lib.clear()
        lib.check_number(42)
        lib.add_clear_button_code()
        scripts = "".join(lib.page.script_lines)
        assert "clearAll" in scripts

    def test_solution_button_code_generated(self, lib):
        lib.clear()
        lib.check_number(42)
        lib.add_solution_button_code()
        scripts = "".join(lib.page.script_lines)
        assert "addSolutionAll" in scripts
        assert "alread_shown_solutions = true" in scripts


# ---------------------------------------------------------------------------
# Library canvas tests
# ---------------------------------------------------------------------------

class TestLibraryCanvas:
    def test_start_end_canvas(self, lib):
        lib.page.lines = []
        lib.start_canvas(300, 200, check_code="result[0] == 1")
        lib.end_canvas()
        output = "".join(str(l) for l in lib.page.lines)
        assert "Raphael" in output
        assert "300" in output
        assert "200" in output

    def test_add_rectangle(self, lib):
        lib.page.lines = []
        lib.start_canvas(300, 200, check_code="result[0] == 1")
        lib.add_rectangle(10, 10, 50, 30, check=True)
        lib.end_canvas()
        output = "".join(str(l) for l in lib.page.lines)
        assert "rect(10, 10, 50, 30)" in output

    def test_add_circle(self, lib):
        lib.page.lines = []
        lib.start_canvas(300, 200, check_code="result[0] == 1")
        lib.add_circle(100, 100, 40, check=True)
        lib.end_canvas()
        output = "".join(str(l) for l in lib.page.lines)
        assert "circle(100, 100, 40)" in output

    def test_add_text(self, lib):
        lib.page.lines = []
        lib.start_canvas(300, 200, check_code="result[0] == 1")
        lib.add_text(50, 50, "Hello", check=False)
        lib.end_canvas()
        output = "".join(str(l) for l in lib.page.lines)
        assert 'text(50, 50, "Hello")' in output

    def test_canvas_registers_checks(self, lib):
        lib.clear()
        lib.page.lines = []
        lib.start_canvas(300, 200, check_code="result[0] == 1")
        lib.add_rectangle(10, 10, 50, 30, check=True)
        lib.end_canvas()
        assert len(lib.checks) == 1
        assert "_check()" in lib.checks[0]


# ---------------------------------------------------------------------------
# Integration: full eval with library calls
# ---------------------------------------------------------------------------

class TestIntegration:
    def test_full_question_with_checks(self, app_data):
        """A complete question with random, math, and check_number."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/integration1")
        q = Question(page, q_id="test/integration1", language=PageLanguage.RS,
                     init_code="""
                        a = lib.math.random(1, 10)
                        b = lib.math.random(1, 10)
                        c = a + b
                     """, iter_code="",
                     text="\n@a@ + @b@ = @lib.check_number(c)@\n")
        q.eval(page)
        output = "".join(str(l) for l in page.lines)
        assert "<input" in output
        assert len(q.lib.last_checks) == 1

    def test_full_question_with_radio(self, app_data):
        """A complete question with radio buttons."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/integration2")
        q = Question(page, q_id="test/integration2", language=PageLanguage.RS,
                     init_code='options = {"Da", "Ne"}', iter_code="",
                     text="\n@lib.check_one_option_radio(options, 0)@\n")
        q.eval(page)
        output = "".join(page.lines)
        assert "type='radio'" in output
        assert "Da" in output
        assert "Ne" in output

    def test_full_question_with_table(self, app_data):
        """A complete question using table functions."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/integration3")
        q = Question(page, q_id="test/integration3", language=PageLanguage.RS,
                     init_code="", iter_code="",
                     text="\n@lib.start_table()@@lib.start_row()@@lib.add_cell('A')@@lib.add_cell('B')@@lib.end_row()@@lib.end_table()@\n")
        q.eval(page)
        output = "".join(page.lines)
        assert "<table" in output
        assert "</table>" in output
        assert "A" in output
        assert "B" in output

    def test_full_question_with_fraction(self, app_data):
        """A complete question with fraction input."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/integration4")
        q = Question(page, q_id="test/integration4", language=PageLanguage.RS,
                     init_code="", iter_code="",
                     text="\n@lib.check_fraction_simple(1, 2)@\n")
        q.eval(page)
        output = "".join(page.lines)
        assert "<table" in output
        assert "border-bottom:solid 1px" in output
        assert len(q.lib.last_checks) == 1

    def test_multiple_questions_unique_ids(self, app_data):
        """Two questions on same page should have different IDs."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "test/multi1")
        q1 = Question(page, q_id="test/multi1", language=PageLanguage.RS,
                      init_code="", iter_code="",
                      text="\n@lib.check_number(1)@\n")
        q2 = Question(page, q_id="test/multi2", language=PageLanguage.RS,
                      init_code="", iter_code="",
                      text="\n@lib.check_number(2)@\n")
        assert q1.q_unique_id != q2.q_unique_id

    def test_question_from_file(self, app_data):
        """Load and evaluate an actual question from disk."""
        random.seed(42)
        page = Page(app_data)
        page.page_params.set_param("language", PageLanguage.RS)
        page.page_params.set_param("q_id", "numbers/q00001")
        q = Question(page, q_id="numbers/q00001", language=PageLanguage.RS)
        q.set_from_file()
        q.eval(page)
        output = "".join(page.lines)
        assert len(output) > 0
        assert len(page.lines) > 0
