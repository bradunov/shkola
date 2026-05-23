"""
Template renderer for the Shkola question language.

This module implements a visitor that walks the parsed template AST and
produces HTML output. It replaces the legacy make_pretty + eval logic
in question.py with a clean, grammar-driven approach.

Architecture:
  1. parse_template() splits the source into TEXT and DIRECTIVE nodes
  2. TemplateRenderer (a TemplateVisitor subclass) walks the AST:
     - TEXT nodes: output with whitespace normalization
     - DIRECTIVE nodes: classified as keywords or Lua expressions
  3. Lua expressions are evaluated via lupa (same as before)
  4. Library calls (lib.*) return HTML snippets that are inserted into output
"""
from __future__ import annotations
import re
import logging
from typing import Optional, List

from server.parser import parse_template, TemplateNode, TextNode, DirectiveNode, TemplateVisitor
from server.helpers import Transliterate
from server.types import PageLanguage


# Formatting directives that are exact keyword matches (case-insensitive)
ALIGNMENT_KEYWORDS = {'center', 'left', 'right'}
HEADER_KEYWORDS = {'h1', 'h2', 'h3', '/h1', '/h2', '/h3'}
FORMAT_KEYWORDS = {
    'sup', '/sup',
    'frac', 'frac_line', '/frac',
    'hspace', 'vspace',
}
# Keywords that take a parenthesized parameter
PARAMETERIZED_KEYWORDS = {'hspacept', 'vspacept'}

# All keywords that eval should ignore (handled during rendering)
IGNORED_KEYWORDS = ALIGNMENT_KEYWORDS | HEADER_KEYWORDS | FORMAT_KEYWORDS | {'sup', '/sup'}

# HTML replacements for formatting directives
HEADER_HTML = {
    'h1': "<div style='display:inline-block;font-weight:bold;font-size:18px;padding-top:8px;padding-bottom:6px;'>",
    'h2': "<div style='display:inline-block;font-weight:bold;font-size:18px;padding-top:6px;padding-bottom:4px;'>",
    'h3': "<div style='display:inline-block;font-weight:bold;font-size:18px;padding-top:4px;padding-bottom:2px;'>",
    '/h1': "</div>",
    '/h2': "</div>",
    '/h3': "</div>",
}

HSPACE_HTML = "<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>"
VSPACE_HTML = "<div style='display:table;padding-top:0px;padding-bottom:0px;float:center'> </div>"

SUP_START_HTML = "<sup><sup>"
SUP_END_HTML = "</sup></sup>"

FRAC_START_HTML = ("\n<table style='display:inline-table;vertical-align:middle'>\n<tbody>\n<tr>\n"
                   "<td style=\"border-bottom:solid 1px;text-align:center\">")
FRAC_MID_HTML = ("</td>\n</tr>\n<tr>\n<td style=\"text-align:center\">")
FRAC_END_HTML = ("</td>\n</tr>\n</tbody>\n</table>\n")


class TemplateRenderer:
    """Renders a template string to HTML using Lua evaluation.

    This replaces the make_pretty() + eval() pipeline in question.py.
    """

    def __init__(self, question):
        """Initialize with a Question object for access to Lua, page, library, etc."""
        self.question = question
        self.lua = question.lua
        self.page = question.page
        self.lib = question.lib
        self.repository = question.repository
        self.language = question.language
        self.cyrillic = question.cyrillic

    def render(self, text: str, init_code: str, iter_code: str) -> None:
        """Render the template text, adding output to self.page.

        Args:
            text: The template source (from text.<lang> file)
            init_code: Lua initialization code (from init.lua)
            iter_code: Lua iteration code (from iter.lua, used with @repeat@)
        """
        # Preprocess: handle line continuations and normalize whitespace
        processed = self._preprocess(text)

        # Parse into AST
        ast = parse_template(processed)

        # Classify directives (identify repeat/if blocks, keywords, expressions)
        items = self._classify_elements(ast)

        # Build and execute Lua code (same strategy as original eval)
        self._execute(items, init_code, iter_code)

    def _preprocess(self, text: str) -> str:
        """Normalize whitespace and handle line continuations."""
        assert len(text) > 0

        b = text
        # Line continuations
        b = b.replace("\\\n", " ")
        b = b.replace("\\\r\n", " ")
        b = b.replace("\r", "")
        b = b.replace("\t", " ")

        # Collapse runs of spaces (preserve newlines)
        b = b.replace("\n", "$%^&")
        b = " ".join(b.split())
        b = b.replace("$%^&", "\n")
        b = b.replace("\n ", "\n")

        # Collapse multiple blank lines
        while "\n\n" in b:
            b = b.replace("\n\n", "\n")

        if b and b[0] == "\n":
            b = b[1:]

        # Transliterate for Serbian cyrillic
        if self.cyrillic:
            b = Transliterate.transliterate(b, Transliterate.rs)

        return b

    def _classify_elements(self, ast: TemplateNode) -> List[dict]:
        """Classify each AST element into items for Lua code generation.

        Returns a list of items, each with a "type" key and relevant data.
        This mirrors the classification logic in the original eval() method.
        """
        items = []
        strings = []

        # First, apply formatting replacements to get a processed text
        # that has HTML formatting in place of keywords.
        # We rebuild the text from the AST, replacing format keywords with HTML.
        rebuilt = self._rebuild_with_formatting(ast)

        # Re-parse the rebuilt text (formatting keywords are now HTML, only
        # control-flow and expressions remain as directives)
        ast2 = parse_template(rebuilt)

        # Now classify the final AST elements
        repeat_start_index = None
        if_start_index = None

        for element in ast2.elements:
            if isinstance(element, TextNode):
                items.append({"type": "text", "string": element.content})
                strings.append(element.content)

            elif isinstance(element, DirectiveNode):
                cmd = element.content

                # Repeat
                if cmd.startswith("repeat") and '(' in cmd and cmd.rstrip().endswith(')'):
                    param = cmd[len("repeat"):].strip()
                    if param.startswith("(") and param.endswith(")"):
                        no_iter = int(param[1:-1])
                        items.append({"type": "repeat", "no_iter": no_iter})
                        strings.append("")
                        repeat_start_index = len(items) - 1
                    else:
                        # Not a valid repeat — treat as expression
                        items.append({"type": "code", "string": cmd})
                        strings.append(cmd)

                elif cmd.strip() == "/repeat":
                    items.append({"type": "repeat_end", "start": repeat_start_index})
                    strings.append("")
                    repeat_start_index = None

                # If/elif/else/endif
                elif cmd.startswith("if") and (len(cmd) == 2 or not cmd[2].isalnum()):
                    param = cmd[2:].strip()
                    items.append({"type": "if", "param": param})
                    strings.append("")
                    if_start_index = len(items) - 1

                elif cmd.startswith("elif") and (len(cmd) == 4 or not cmd[4].isalnum()):
                    param = cmd[4:].strip()
                    items.append({"type": "elif", "param": param, "start": if_start_index})
                    strings.append("")

                elif cmd.strip() == "else":
                    items.append({"type": "else", "start": if_start_index})
                    strings.append("")

                elif cmd.strip() == "endif":
                    items.append({"type": "if_end", "start": if_start_index})
                    strings.append("")
                    if_start_index = None

                # Lua expression
                else:
                    items.append({"type": "code", "string": cmd})
                    strings.append(cmd)

        if repeat_start_index is not None:
            raise ValueError("Repeat loop not ended")
        if if_start_index is not None:
            raise ValueError("If block not ended")

        return items

    def _rebuild_with_formatting(self, ast: TemplateNode) -> str:
        """Rebuild the template, replacing formatting directives with HTML.

        Processes alignment, headers, spacing, fractions, and superscripts.
        Also handles div wrapping for paragraphs.
        """
        # First pass: collect all elements, replacing format keywords
        parts = []
        for element in ast.elements:
            if isinstance(element, TextNode):
                parts.append(element.content)
            elif isinstance(element, DirectiveNode):
                cmd = element.content.strip()
                cmd_lower = cmd.lower()

                if cmd_lower in ALIGNMENT_KEYWORDS:
                    # Keep as directive (consumed during div wrapping)
                    parts.append('@' + cmd + '@')
                elif cmd_lower in HEADER_KEYWORDS:
                    parts.append(HEADER_HTML[cmd_lower])
                elif cmd_lower == 'sup':
                    parts.append(SUP_START_HTML)
                elif cmd_lower == '/sup':
                    parts.append(SUP_END_HTML)
                elif cmd_lower == 'frac':
                    parts.append(FRAC_START_HTML)
                elif cmd_lower == 'frac_line':
                    parts.append(FRAC_MID_HTML)
                elif cmd_lower == '/frac':
                    parts.append(FRAC_END_HTML)
                elif cmd_lower == 'hspace':
                    parts.append(HSPACE_HTML)
                elif cmd_lower == 'vspace':
                    parts.append(VSPACE_HTML)
                elif cmd_lower.startswith('hspacept') and '(' in cmd:
                    m = re.match(r'hspacept\s*\((.*?)\)', cmd, re.IGNORECASE)
                    if m:
                        val = m.group(1)
                        parts.append(f"<div style='display:inline-block;padding-left:0px;padding-right:{val}px;'> </div>")
                    else:
                        parts.append('@' + element.content + '@')
                elif cmd_lower.startswith('vspacept') and '(' in cmd:
                    m = re.match(r'vspacept\s*\((.*?)\)', cmd, re.IGNORECASE)
                    if m:
                        val = m.group(1)
                        parts.append(f"<div style='display:table;padding-top:0px;padding-bottom:{val}px;float:center'> </div>")
                    else:
                        parts.append('@' + element.content + '@')
                else:
                    # Keep as directive (expression, repeat, if, etc.)
                    parts.append('@' + element.content + '@')

        raw = ''.join(parts)

        # Second pass: div wrapping for paragraphs
        return self._wrap_paragraphs(raw)

    def _wrap_paragraphs(self, text: str) -> str:
        """Wrap text lines in div elements with alignment.

        Replicates the paragraph wrapping logic from make_pretty,
        handling special areas (tables) that should not be wrapped.
        """
        # Identify special/protected areas (start_table ... end_table)
        special_tags = [{"start": "@lib.start_table", "end": "@lib.end_table"}]
        special_areas = []
        ind = 0
        while True:
            min_ind = len(text) + 1
            tag = None
            for t in special_tags:
                i = text.find(t["start"], ind)
                if i < min_ind and i > -1:
                    min_ind = i
                    tag = t
            if tag:
                i = text.find(tag["end"], min_ind)
                if i > -1:
                    ind = text.find("@", i + 1) + 1
                else:
                    ind = -1
                if ind == -1:
                    raise ValueError(
                        f"Code block {tag['start']} started at position {min_ind} not finished"
                    )
                special_areas.append({"start": min_ind, "end": ind})
            else:
                break

        # Build output with div wrapping
        output = ""
        start_ind = 0
        sa_ind = 0
        para = _Paragraph()

        while True:
            if sa_ind < len(special_areas):
                end_ind = special_areas[sa_ind]["start"]
            else:
                end_ind = len(text)

            # Process text between special areas
            if start_ind < end_ind:
                chunk = text[start_ind:end_ind]
                if chunk.startswith('\n') and chunk.endswith('\n'):
                    bfrac = chunk[1:-1]
                    st_nl = True
                    end_nl = True
                elif chunk.startswith('\n'):
                    bfrac = chunk[1:]
                    st_nl = True
                    end_nl = False
                elif chunk.endswith('\n'):
                    bfrac = chunk[:-1]
                    st_nl = False
                    end_nl = True
                else:
                    bfrac = chunk
                    st_nl = False
                    end_nl = False

                old_ind = -1
                find_ind = bfrac.find("\n")
                while find_ind > -1:
                    if st_nl:
                        output += para.output_and_flush()
                    st_nl = True
                    para.append(bfrac[old_ind + 1:find_ind + 1])
                    old_ind = find_ind
                    find_ind = bfrac.find("\n", find_ind + 1)

                if st_nl:
                    output += para.output_and_flush()
                st_nl = True
                para.append(bfrac[old_ind + 1:])

                if end_nl:
                    output += para.output_and_flush()

            # Copy protected area (if exists)
            if sa_ind == len(special_areas):
                break
            else:
                para.append_special(text[special_areas[sa_ind]["start"]:special_areas[sa_ind]["end"]])
                start_ind = special_areas[sa_ind]["end"]
                sa_ind += 1

        output += para.output_and_flush()
        return output

    def _execute(self, items: List[dict], init_code: str, iter_code: str) -> None:
        """Build Lua code from classified items and execute it.

        This generates a Lua function that processes text and expressions,
        using the same approach as the original eval() method.
        """
        strings = [item.get("string", "") for item in items]

        # Build Lua function
        code = """
      function (page, lib, strings)
    """
        # Define include function
        if self.language == PageLanguage.RS and self.cyrillic:
            lua_lang_t = PageLanguage.RSC.value
            code += self._include_function_cyrillic(lua_lang_t)
        else:
            code += self._include_function()

        # Math wrappers (same as original)
        code += """
            local _lib_math = lib.math

            function sh_random(m, n)
              local r = _lib_math.random(m,n)
              if m~=nil or n~=nil then
                return math.tointeger(r)
              end
              return r
            end

            function sh_round(n)
              return math.tointeger(_lib_math._round(n))
            end
        """

        # Init code
        code += init_code + "\n"

        # Process items (generate Lua statements)
        ind = 0
        start_repeat = None
        no_iter = None
        loop = 1

        while ind < len(items):
            item = items[ind]

            if item["type"] == "text":
                code += "page.add_lines(strings[{}])\n".format(ind)

            elif item["type"] == "code":
                # Handle include() directives
                if (len(strings[ind]) > len("include()") and
                        strings[ind][:len("include(")] == "include(" and
                        strings[ind][-1] == ")"):
                    inc_file = strings[ind][len("include("):-1]
                    q = self.repository.get_question(self.question.q_id)
                    inc_name = inc_file + "." + PageLanguage.toStr(self.language) + ".lua"
                    include_code = ""
                    if q is not None and inc_name in q.keys():
                        include_code = q[inc_name]
                    else:
                        g = self.repository.get_globals()
                        if g is not None and inc_name in g.keys():
                            include_code = g[inc_name]
                    code += include_code

                # Ignore alignment keywords (already handled in formatting)
                elif strings[ind].lower() in ALIGNMENT_KEYWORDS:
                    pass

                else:
                    code += "output = {}\n".format(strings[ind])
                    code += "if (output ~= nil) then page.add_lines(output) end\n"

            elif item["type"] == "repeat":
                no_iter = item["no_iter"]
                start_repeat = ind
                loop = 1
                code += "ITEM = {}\n".format(loop)
                code += iter_code + "\n"

            elif item["type"] == "repeat_end":
                loop += 1
                if loop == no_iter + 1:
                    loop = 1
                    start_repeat = None
                else:
                    code += "ITEM = {}\n".format(loop)
                    code += iter_code + "\n"
                    ind = start_repeat

            elif item["type"] == "if":
                param = item.get("param", "")
                if not param:
                    code += "if true then\n"
                else:
                    code += "if {} then\n".format(param)

            elif item["type"] == "elif":
                param = item.get("param", "")
                if not param:
                    code += "elseif true then\n"
                else:
                    code += "elseif {} then\n".format(param)

            elif item["type"] == "else":
                code += "else\n"

            elif item["type"] == "if_end":
                code += "end\n"

            ind += 1

        code += """
      end
    """

        # Apply string replacements (same as original)
        code = code.replace("\\", "\\\\")
        code = code.replace("lib.math.", "_lib_math.")
        code = re.sub(r'(?<![._\w])math\.random\s*\(', 'sh_random(', code)
        code = code.replace("_lib_math.round(", "sh_round(")

        # Execute
        lua_fun = self.lua.eval(code)
        try:
            lua_fun(self.page, self.lib, strings)
        except Exception as e:
            logging.error(
                "Exception in question %s: %s\nCODE: %s\nSTRINGS: %s",
                self.question.q_id, e, code, strings
            )
            raise

    def _include_function(self) -> str:
        """Generate Lua include function definition."""
        return """
            function require_if_exists(name)
                local f=io.open(name,"r")
                if f~=nil then io.close(f); dofile(name) end
            end
            function include(name)
                local root_path = '""" + self.question.questions_root_path + """';
                local question_path = '""" + self.question.q_id + """';
                local language = '""" + PageLanguage.toStr(self.language) + """';

                require_if_exists(root_path.."/"..question_path.."/"..name.."."..language..".lua");
                require_if_exists(root_path.."/global/"..name.."."..language..".lua");
                require_if_exists(root_path.."/global/"..name..".lua");
            end
        """

    def _include_function_cyrillic(self, lua_lang_t: str) -> str:
        """Generate Lua include function with cyrillic fallback."""
        return """
            function require_if_exists(name)
                local f=io.open(name,"r")
                if f~=nil then io.close(f); dofile(name) end
            end
            function require_if_exists_t(name, name_t)
                local f_t=io.open(name_t,"r")
                if f_t~=nil then io.close(f_t); dofile(name_t)
                else
                    local f=io.open(name,"r")
                    if f~=nil then io.close(f); dofile(name) end
                end
            end
            function include(name)
                local root_path = '""" + self.question.questions_root_path + """';
                local question_path = '""" + self.question.q_id + """';
                local language = '""" + PageLanguage.toStr(self.language) + """';
                local language_t = '""" + lua_lang_t + """';

                require_if_exists_t(root_path.."/"..question_path.."/"..name.."."..language..".lua", root_path.."/"..question_path.."/"..name.."."..language_t..".lua");
                require_if_exists_t(root_path.."/global/"..name.."."..language..".lua", root_path.."/global/"..name.."."..language_t..".lua");
                require_if_exists(root_path.."/global/"..name..".lua");
            end
        """


class _Paragraph:
    """Helper class for paragraph div wrapping (replicates original logic)."""

    def __init__(self):
        self.style = "style='display:content;border:6px;padding:6px'"
        self.text = ""
        self.alignment = ""
        self.last_div_id = 0

    def update_alignment(self, string):
        if "@left@" in string:
            self.alignment = "align='left'"
        elif "@right@" in string:
            self.alignment = "align='left'"
        elif "@center@" in string:
            self.alignment = "align='center'"
        else:
            self.alignment = "align='left'"

    def output_and_flush(self):
        text = ""
        if self.text:
            text = "\n<div {} {} id='qline_{}'>\n".format(
                self.alignment, self.style, self.last_div_id
            ) + self.text + "\n</div>\n"
            self.text = ""
            self.last_div_id += 1
        return text

    def append(self, text):
        self.update_alignment(text)
        self.text += text

    def append_special(self, text):
        self.text += text
