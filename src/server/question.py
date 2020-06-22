import sys
import traceback
from lupa import LuaRuntime
import random
import re
from server.types import PageLanguage
from server.library import Library
from server.timers import timer_section
import logging


class Paragraph(object):
    style = "style='display:content;border:6px;padding:6px'"
    text = ""
    alignment = ""
    last_div_id = 0

    def update_alignment(self, string):
        if string.find("@left@") > -1:
            self.alignment = "align='left'"
        elif string.find("@right@") > -1:
            self.alignment = "align='left'"
        elif string.find("@center@") > -1:
            self.alignment = "align='center'"
        else:
            self.alignment = "align='left'"
            
    def output_and_flush(self):
        text = ""
        if self.text:
            text = "\n<div {} {} id='qline_{}'>\n".\
                                     format(self.alignment, self.style, self.last_div_id) + \
                                     self.text + "\n</div>\n"
            self.text = ""
            self.last_div_id = self.last_div_id + 1
        return text

    def append(self, text):
        self.update_alignment(text)
        self.text = self.text + text
    
    def append_special(self, text):
        self.text = self.text + text

        

class Question(object):
    # Lua interpreter
    lua = None

    # Libraries
    lib = None

    page = None

    q_id = None
    language = None

    questions_rel_path = "questions"
    questions_root_path = None
    
    text = ""
    init_code = None
    iter_code = None

    main_script_begin = """
      function (page, lib, strings)
    """
    main_script_end = """
      end
    """

    
    @timer_section("question.init")
    def __init__(self, page, q_id=None, language=None, test_id=None, test_order=None, 
                 init_code=None, iter_code=None, text=None):
                 
        self.lua = LuaRuntime(unpack_returned_tuples=True)
        self.page = page
        self.repository = page.repository

        # If we have more questions on the same page make sure all use pseudo-random thus unique IDs
        self.q_unique_id = str(int(random.random() * 1000000000))

        if q_id:
            self.q_id = q_id
        else:
            self.q_id = page.page_params.get_param("q_id")
        self.page.add_script_lines("<script> global_q_id = \"{}\";</script>".format(self.q_id))

        if language:
            self.language = language
        else:
            self.language = page.page_params.get_param("language")
        self.page.add_script_lines("<script> global_language = \"{}\";</script>".format(PageLanguage.toStr(self.language)))

        # Parameters useful for error reporting
        if self.page.page_params.get_param("l_id"):
            self.page.add_script_lines("<script> global_l_id = \"{}\";</script>".format(self.page.page_params.get_param("l_id")))
        if self.page.page_params.get_param("root"):
            self.page.add_script_lines("<script> global_root = \"{}\";</script>".format(self.page.page_params.get_param("root")))

        self.test_id = test_id if test_id else 0
        self.test_order = test_order if test_order else 0

        if not init_code is None:
            self.init_code = init_code
        else:
            self.init_code = page.page_params.get_param("init_code")

        if not iter_code is None:
            self.iter_code = iter_code
        else:
            self.iter_code = page.page_params.get_param("iter_code")

        if not text is None:
            self.text = text
        else:
            self.text = page.page_params.get_param("text")

        self.lib = Library(self)
        logging.debug("Rendering question %s, language=%s", 
            self.question_url(), PageLanguage.toStr(self.language))
        self.questions_root_path = self.page.rel_path + "/" + self.questions_rel_path


    def question_url(self):
        return self.questions_rel_path + "/" + self.q_id


    def set_from_file(self):
        self.init_code = ""
        self.iter_code = ""
        self.text = "\n\n<h3>ERROR: no code exists for question {} for language {}!</h3>".format(
            self.q_id, PageLanguage.toStr(self.language)
        )
        
        self.page.add_lines("\n<!-- Rendering question {} for language {} -->\n\n".format(
            self.q_id, PageLanguage.toStr(self.language)
        ))

        q = self.repository.get_question(self.q_id)
        if q is None:
            return

        if "init.lua" in q.keys():
            #logging.debug("%s, %s", str(q.keys()), str(q))
            self.init_code = q["init.lua"]

        if "iter.lua" in q.keys():
            self.iter_code = q["iter.lua"]

        text_key = "text." + PageLanguage.toStr(self.language)
        if text_key in q.keys():
            self.text = q[text_key]
            
            
    def set_from_file_with_exception(self):
        self.set_from_file()
        
        # try:
        #     self.set_from_file()
        # except Exception as err:
        #     err_str = "\n\n<br> Error reading from a question list: \n {} <br>\n".format(str(err))
        #     self.page.add_lines(err_str)
        #     for l in traceback.format_tb(err.__traceback__):
        #         self.page.add_lines("<br> {}".format(l))
        
        
    def set_init_code(self, code):
        self.init_code = code

    def set_iter_code(self, code):
        self.iter_code = code

    def set_text(self, text):
        self.text = text

    def get_init_code(self):
        return self.init_code
        
    def get_iter_code(self):
        return self.iter_code

    def get_text(self):
        return self.text

    
    def make_pretty(self, text):
        assert (len(text) > 0)
        b = text
        # Beutify b like markdown, but we cannot use MD here as it would destroyed inlined HTML (e.g. MathJS)
        b = b.replace("\\\n", " ")
        b = b.replace("\\\r\n", " ")
        b = b.replace("\r", "")
        b = b.replace("\t", " ")
        b = b.replace("\n", "$%^&")
        b = " ".join(b.split())
        b = b.replace("$%^&", "\n")
        b = b.replace("\n ", "\n")
        while True:
            b1 = b.replace("\n\n", "\n")
            if (len(b1) == len(b)):
                break
            b = b1

        if (b[0] == "\n"):
            b = b[1:]


        # This seems to work fine for the text. However, it does not 
        # transliterate string variables. We need to instrument the questions.
        # b = Transliterate.transliterate(b, Transliterate.rs)

            
        # Skip prettyfication between special tags that embbed HTML, such as start_table and end_table
        # otherwise extra HTML tags (</div>...</div>) will mess up formatting

        special_tags = [{"start": "@lib.start_table", "end": "@lib.end_table"}]

        special_areas = []
        ind = 0
        while True:
            min_ind = sys.maxsize
            tag = None
            for t in special_tags:
                i = b.find(t["start"], ind)
                if (i < min_ind and i > -1):
                    min_ind = i
                    tag = t
            if tag:
                i = b.find(tag["end"], min_ind)
                if (i > -1):
                    ind = b.find("@", i+1)+1
                else:
                    ind = -1
                if (ind == -1):
                    raise Exception("Code block {} started in text at position {} not finished".format(tag["start"], min_ind))
                special_areas.append({"start" : min_ind, "end" : ind})
            else:
                break


            
        
        output = ""
        start_ind = 0
        sa_ind = 0

        
        # Insert <div> </div> around every line starting and ending with "\n"
        # to maintain the same visual design as edited file

        para = Paragraph()
        
        while True:
            if (sa_ind < len(special_areas)):
                end_ind = special_areas[sa_ind]["start"]
            else:
                end_ind = len(b)


            # Process each part of code between special areas
            
            if(start_ind < end_ind):
                # Modify and copy non-protected part
                if b[start_ind] == '\n' and b[end_ind-1] == '\n':
                    st_nl = True
                    end_nl = True
                    bfrac = b[start_ind+1:end_ind-1]
                elif b[start_ind] == '\n':
                    st_nl = True
                    end_nl = False
                    bfrac = b[start_ind+1:end_ind]
                elif b[end_ind-1] == '\n':
                    st_nl = False
                    end_nl = True
                    bfrac = b[start_ind:end_ind-1]
                else:
                    st_nl = False
                    end_nl = False
                    bfrac = b[start_ind:end_ind]
                
                old_ind = -1
                ind = bfrac.find("\n")
                while ind > -1:
                    if st_nl:
                        output = output + para.output_and_flush()
                    st_nl = True
                    para.append(bfrac[old_ind+1:ind+1])
                    old_ind = ind
                    ind = bfrac.find("\n", ind + 1)
                    
                if st_nl:
                    output = output + para.output_and_flush()
                st_nl = True
                para.append(bfrac[old_ind+1:])

                if end_nl:
                    output = output + para.output_and_flush()


            # Just copy protected part (if exists)
            if sa_ind == len(special_areas):
                break
            else:
                #output = output + b[special_areas[sa_ind]["start"]:special_areas[sa_ind]["end"]]
                para.append_special(b[special_areas[sa_ind]["start"]:special_areas[sa_ind]["end"]])
                start_ind = special_areas[sa_ind]["end"]
                sa_ind = sa_ind + 1

                
        output = output + para.output_and_flush()
                
                
        # Replace headers
        output = output.replace("@h1@", "<div style='display:inline-block;font-weight:bold;font-size:18px;padding-top:8px;padding-bottom:6px;'>")
        output = output.replace("@/h1@", "</div>")
        output = output.replace("@h2@", "<div style='display:inline-block;font-weight:bold;font-size:18px;padding-top:6px;padding-bottom:4px;'>")
        output = output.replace("@/h2@", "</div>")
        output = output.replace("@h3@", "<div style='display:inline-block;font-weight:bold;font-size:18px;padding-top:4px;padding-bottom:2px;'>")
        output = output.replace("@/h3@", "</div>")

        # Replace spaces
        output = output.replace("@hspace@", "<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
        output = output.replace("@vspace@", "<div style='display:table;padding-top:0px;padding-bottom:0px;float:center'> </div>")

        output = re.sub(r"@hspacept\((.*?)\)@", r"<div style='display:inline-block;padding-left:0px;padding-right:\1px;'> </div>", output)
        output = re.sub(r"@vspacept\((.*?)\)@", r"<div style='display:table;padding-top:0px;padding-bottom:\1px;float:center'> </div>", output)

        
        # DEBUG
        #logging.debug("**************\nMAKE PRETTY: \n", output, "\n*****************")
        
        return output


    def eval(self, page):

        # Parse text
        indices = [{"start" : -1, "type" : "text"}]
        cend = -1


        self.page.add_lines("\n\n<!-- QUESTIONS START -->\n\n")
        self.page.add_lines("<div id='question' style='display:table; margin:0 auto;'>\n")

        self.page.add_lines("<script>var test_id = {}; var test_order = {};</script>\n".format(
            self.test_id, self.test_order))


        btext = self.make_pretty(self.text)

        
        # Identify commands and strings
        while True:
            cstart = btext.find("@", cend + 1)
            if cstart == -1:
                indices.append({"start" : len(btext), "type" : "end"})
                break
            cend = btext.find("@", cstart + 1)
            if cend == -1:
                raise Exception("Code block started in text at position {} not finished".format(cstart))
            indices.append({"start" : cstart, "type" :  "code"})
            indices.append({"start" : cend, "type" : "text"})

            
        # Find repeates
        items = []
        strings = []
        start_index = None
        for ind in range(0, len(indices)-1):
            if (indices[ind]["type"] == "code"):
                if (indices[ind+1]["start"] - indices[ind]["start"] - 1 > len("repeat()") and
                    btext[indices[ind]["start"]+1 : indices[ind]["start"]+1+len("repeat")] == "repeat" and
                    btext[indices[ind]["start"]+1+len("repeat")] == "(" and
                    btext[indices[ind+1]["start"]-1] == ")"):
                    if not start_index is None:
                        raise Exception("Nested repeat in text: {}".
                                        format(btext[indices[ind]["start"]+1 :
                                                         indices[ind]["start"]+1+len("repeat")]))
                    no_iter = int(btext[indices[ind]["start"]+1+len("repeat(") : indices[ind+1]["start"]-1])
                    items.append({"type" : "repeat", "no_iter" : no_iter})
                    strings.append("")
                    start_index = ind

                elif (indices[ind+1]["start"] - indices[ind]["start"] - 1 == len("/repeat") and
                    btext[indices[ind]["start"]+1 : indices[ind]["start"]+1+len("/repeat")] == "/repeat"):
                    if start_index is None:
                        raise Exception("Repeat ended without starting")
                    items.append({"type" : "end", "start" : start_index})
                    strings.append("")
                    start_index = None

                else:
                    items.append({"type" : "code",
                                  "string" : btext[indices[ind]["start"]+1 :
                                                       indices[ind+1]["start"]]})
                    strings.append(btext[indices[ind]["start"]+1 :
                                             indices[ind+1]["start"]])
            elif (indices[ind]["type"] == "text"):
                items.append({"type" : "text",
                              "string" : btext[indices[ind]["start"]+1 :
                                                   indices[ind+1]["start"]]})
                strings.append(btext[indices[ind]["start"]+1 :
                                         indices[ind+1]["start"]])
                
            


        # Eval code
        code = self.main_script_begin

        # Define Lua include function with proper paths
        # TBD TODO: This is still reading from a file. Rewrite to use repository
        code = code + """
           function require_if_exists(name)
             local f=io.open(name,"r")
             if f~=nil then io.close(f); dofile(name) end
           end
           function include(name)
              local root_path = '""" + self.questions_root_path + """';
              local question_path = '""" + self.q_id + """';
              local language = '""" + PageLanguage.toStr(self.language) + """';

              require_if_exists(root_path.."/"..question_path.."/"..name.."."..language..".lua");
              require_if_exists(root_path.."/global/"..name.."."..language..".lua");
              require_if_exists(root_path.."/global/"..name..".lua");
           end
        """
        
        # It seems that Lupa doesn't know about integer type that was new in Lua 5.3
        # Everything Lupa returns is treated as a float, causing bad printout format
        # We use these Lua wrapper functions to convert to int within Lua
        # Note that this is a dangerous trick as search and replace calls! 
        code = code + """
            function sh_random(m, n)
              rnd = lib.math.random
              r = rnd(m,n)
              if m~=nil or n~=nil then
                return math.tointeger(r)
              end
              return r
            end

            function sh_round(n)
              return math.tointeger(lib.math._round(n))
            end
        """


        code = code + self.init_code + "\n"

        ind = 0
        start_repeat = None
        no_iter = None
        loop = 1
        while ind < len(items):
            item = items[ind]
            if item["type"] == "text":
                code = code + "page.add_lines(strings[{}])\n".format(ind)
            elif item["type"] == "code":
                # Look for include() directives
                if (len(strings[ind]) > len("include()") and
                    strings[ind][0 : len("include(")] == "include(" and
                    strings[ind][len(strings[ind])-1] == ")"):
                    inc_file = strings[ind][len("include("):len(strings[ind])-1]

                    q = self.repository.get_question(self.q_id)
                    inc_name = inc_file + "." + PageLanguage.toStr(self.language) + ".lua"
                    include_code = ""
                    if q is not None and inc_name in q.keys():
                        include_code = q[inc_name]
                    else:
                        g = self.repository.get_globals()
                        if g is not None and inc_name in g.keys():
                            include_code = g[inc_name]
                                                    
                    code = code + include_code

                # Ignore alignment tags
                elif (strings[ind] != "left" and strings[ind] != "right" and strings[ind] != "center" and \
                    strings[ind] != "H1" and strings[ind] != "H2" and strings[ind] != "H3" and \
                    strings[ind] != "/H1" and strings[ind] != "/H2" and strings[ind] != "/H3"):
                    code = code + "output = {}\n".format(strings[ind])
                    code = code + "if (output ~= nil) then page.add_lines(output) end\n"
            elif item["type"] == "repeat":
                no_iter = item["no_iter"]
                start_repeat = ind
                loop = 1
                code = code + "ITEM = {}\n".format(loop)
                code = code + self.iter_code + "\n"

            elif item["type"] == "end":
                loop = loop + 1
                if loop == no_iter + 1:
                    loop = 1
                    start_repeat = None
                else:
                    code = code + "ITEM = {}\n".format(loop)
                    code = code + self.iter_code + "\n"
                    ind = start_repeat
            ind = ind + 1


        code = code + self.main_script_end

        code = code.replace("\\", "\\\\")

        # Replace math.random with lib.math.random so we can log all random values
        code = code.replace("math.random(", "sh_random(")
        # Replace round with a local wrapper to force it to become int (Lupa doesn't know about int types)
        code = code.replace("lib.math.round(", "sh_round(")



        # DEBUG
        if False:
            logging.debug("\n\n********************\nSTRINGS: \n")
            for i in range(0, len(strings)):
                logging.debug("string[{}]: {}".format(i, strings[i]))

            logging.debug("\n\n********************\nCODE: {}".format(code))

        

        lua_fun = self.lua.eval(code)
        lua_fun(self.page, self.lib, strings)
                        
        if self.lib is not None:
            self.lib.add_check_button_code()
            self.lib.add_clear_button_code()
            self.lib.add_solution_button_code()
            self.lib.add_error_report_button_code()
            
        self.page.add_lines("</div>\n")
        self.page.add_lines("\n\n<!-- QUESTIONS END -->\n\n")


        
        
    @timer_section("question.eval_with_exception")
    def eval_with_exception(self, catch=False):

        if not catch:
            # Don't catch the exception here
            # Pass the exception to the server for unit testing
            self.eval(self.page)

        else:
            # In edit mode we want to catch so a user can make mistakes
            try:
                self.eval(self.page)
            except Exception as err:
                err_str = "\n\n<br> Error in program:\n {} <br>\n".format(str(err))
                self.page.add_lines(err_str)
                for l in traceback.format_tb(err.__traceback__):
                    self.page.add_lines("<br> {}".format(l))
    
