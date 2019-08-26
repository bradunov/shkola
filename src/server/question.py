import sys
import traceback
import lupa
import math
from lupa import LuaRuntime
from library import library



class paragraph(object):
    # TBD: Center
    style = "style='display:content;border:6px;padding:6px'"
    #style = "style='border:6px;padding:6px'"
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

        

class question(object):
    # Lua interpreter
    lua = None

    # Libraries
    lib = None

    page = None
    
    text = ""
    init_code = None
    iter_code = None

    questions_root_path = ""
    
    main_script_begin = """
      function (page, lib, strings)
    """
    main_script_end = """
      end
    """

    
    def __init__(self, page, path, language, questions_root_path, init_code = "", iter_code = "", text = ""):
        self.lua = LuaRuntime(unpack_returned_tuples=True)
        self.lib = library(self.lua, page)
        self.page = page
        self.init_code = init_code
        self.iter_code = iter_code
        self.text = text
        self.language = language
        self.path = path
        self.questions_root_path = questions_root_path


    def set_from_file(self):
        try:
            with open("{}/{}/init.lua".format(self.questions_root_path, self.path)) as f_init_code:
                self.init_code = f_init_code.read()
        except IOError:
            self.init_code = ""
            
        try:
            with open("{}/{}/iter.lua".format(self.questions_root_path, self.path)) as f_iter_code:
                self.iter_code = f_iter_code.read()
        except IOError:
            self.iter_code = ""

        # No exception handling here, question text has to exist
        try:
            with open("{}/{}/text.{}".format(self.questions_root_path, self.path, self.language)) as f_text:
                self.text = f_text.read()
        except IOError:
            self.text = "\n\n<h3>ERROR: no code exists for question {} for language {}!</h3>".format(self.path, self.language)
            
    def set_from_file_with_exception(self):
        try:
            self.set_from_file()
        except Exception as err:
            err_str = "\n\n<br> Error reading from a question list: \n {} <br>\n".format(str(err))
            self.page.add_lines(err_str)
            for l in traceback.format_tb(err.__traceback__):
                self.page.add_lines("<br> {}".format(l))

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

        para = paragraph()
        
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
        
        # DEBUG
        #print("**************\nMAKE PRETTY: \n", output, "\n*****************")
        
        return output


    def eval(self, page):

        # Parse text
        indices = [{"start" : -1, "type" : "text"}]
        cend = -1

        
        self.page.add_lines("\n\n<!-- QUESTIONS START -->\n\n")
        # TBD: Center
        self.page.add_lines("<div id='question' style='display:table; margin:0 auto;'>\n")
        #self.page.add_lines("<div id='question' style='width:100%'>\n")

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
        code = code + """
           function require_if_exists(name)
             local f=io.open(name,"r")
             if f~=nil then io.close(f); dofile(name) end
           end
           function include(name)
              local root_path = '""" + self.questions_root_path + """';
              local question_path = '""" + self.path + """';
              local language = '""" + self.language + """';

              require_if_exists(root_path.."/"..question_path.."/"..name.."."..language..".lua");
              require_if_exists(root_path.."/global/"..name.."."..language..".lua");
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

                    try:
                        with open("{}/{}/{}.{}.lua".format(self.questions_root_path, self.path, inc_file, self.language)) as f_include_code:
                            include_code = f_include_code.read()
                            print("Included {}/{}/{}.{}.lua".format(self.questions_root_path, self.path, inc_file, self.language))
                    except IOError:
                        try:
                            with open("{}/global/{}.{}.lua".format(self.questions_root_path, inc_file, self.language)) as f_include_code:
                                include_code = f_include_code.read()
                                print("Included {}/global/{}.{}.lua".format(self.questions_root_path, inc_file, self.language))
                        except IOError:
                            include_code = ""
                            
                    code = code + include_code

                # Ignore alignment tags
                elif (strings[ind] != "left" and strings[ind] != "right" and strings[ind] != "center" and \
                    strings[ind] != "H1" and strings[ind] != "H2" and strings[ind] != "H3" and \
                    strings[ind] != "/H1" and strings[ind] != "/H2" and strings[ind] != "/H3"):
                    code = code + "page.add_lines({})\n".format(strings[ind])
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

        # DEBUG
        if False:
            print("\n\n********************\nSTRINGS: \n")
            for i in range(0, len(strings)):
                print("string[{}]: {}".format(i, strings[i]))

                print("\n\n********************\nCODE: ", code)

        
        lua_fun = self.lua.eval(code)
        ret = lua_fun(self.page, self.lib, strings)
            
        if self.lib is not None:
            self.lib.add_buttons()
            
        self.page.add_lines("</div>\n")
        self.page.add_lines("\n\n<!-- QUESTIONS END -->\n\n")


        
        
    def eval_with_exception(self):
        try:
            self.eval(self.page)
        except Exception as err:
            err_str = "\n\n<br> Error in program:\n {} <br>\n".format(str(err))
            self.page.add_lines(err_str)
            for l in traceback.format_tb(err.__traceback__):
                self.page.add_lines("<br> {}".format(l))
    
