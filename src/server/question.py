import traceback
import lupa
import math
from lupa import LuaRuntime

class question(object):
    # Lua interpreter
    lua = None

    # Libraries
    lib = None
    
    text = ""
    init_code = None
    iter_code = None

    main_script_begin = """
      function (page, lib, strings)
    """
    main_script_end = """
      end
    """

    
    def __init__(self, lua, lib, init_code = None, iter_code = None, text = None):
        self.lua = lua
        self.lib = lib
        self.init_code = init_code
        self.iter_code = iter_code
        self.text = text

    def set_from_file(self, path, language):
        try:
            with open("../../questions/{}/init.lua".format(path)) as f_init_code:
                self.init_code = f_init_code.read()
        except IOError:
            self.init_code = ""
            
        try:
            with open("../../questions/{}/iter.lua".format(path)) as f_iter_code:
                self.iter_code = f_iter_code.read()
        except IOError:
            self.iter_code = ""

        # No exception handling here, question text has to exist
        with open("../../questions/{}/text.{}".format(path, language)) as f_text:
            self.text = f_text.read()
            
    def set_from_file_with_exception(self, page, path, language):
        try:
            self.set_from_file(path, language)
        except Exception as err:
            err_str = "\n\n<br> Error reading from a question list: \n {} <br>\n".format(str(err))
            page.add_lines(err_str)
            for l in traceback.format_tb(err.__traceback__):
                page.add_lines("<br> {}".format(l))

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

    def get_alignment(self, string):
        if string.find("@left@") > -1:
            return "align='left'"
        elif string.find("@right@") > -1:
            return "align='left'"
        elif string.find("@center@") > -1:
            return "align='center'"
        else:
            return ""
        
    def make_pretty(self, page, text):
        b = text
        # Beutify b like markdown, but we cannot use MD here as it would destroyed inlined HTML (e.g. MathJS)
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


        max_div_id = 0
            
        old_ind = -1
        ind = b.find("\n")
        output = ""
        while ind > -1:
            output = output + "<div {} id='qline_{}'>\n  ".format(self.get_alignment(b[old_ind+1:ind+1]), max_div_id)
            output = output + b[old_ind+1:ind+1] + "</div>\n"
            old_ind = ind
            ind = b.find("\n", ind + 1)
            max_div_id = max_div_id + 1

        output = output + "<div {} id='qline_{}'>\n  ".format(self.get_alignment(b[old_ind+1:]), max_div_id)
        output = output + b[old_ind+1:] + "</div>\n"
        max_div_id = max_div_id + 1

        output = output + "</div>\n"



        # Failed attempt to adjust question width to the width of the longest string
        '''
        init_width_code = """
          max_width = 0
          for(i = 0; i < """ + str(max_div_id) + """; i++) {
            console.log("qline_" + i.toString());
            console.log(document.getElementById("qline_" + i.toString()).offsetWidth);
            console.log(max_width);
            max_width = Math.max(document.getElementById("qline_" + i.toString()).offsetWidth, max_width);
          }
          document.getElementById("question").offsetWidth = max_width;
          console.log(document.getElementById("question").offsetWidth);
        """
        page.add_on_loaded_script_lines(init_width_code)
        '''
        
        return output

    
    def eval(self, page):

        # Parse text
        indices = [{"start" : -1, "type" : "text"}]
        cend = -1

        
        page.add_lines("\n\n<!-- QUESTIONS START -->\n\n")
        page.add_lines("<div id='question' style='width:100%'>\n")


        
        btext = self.make_pretty(page, self.text)

        
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
                if (indices[ind+1]["start"] - indices[ind]["start"] - 1 > 8 and
                    btext[indices[ind]["start"]+1 : indices[ind]["start"]+7] == "repeat" and
                    btext[indices[ind]["start"]+7] == "(" and
                    btext[indices[ind+1]["start"]-1] == ")"):
                    if not start_index is None:
                        raise Exception("Nested repeat in text: {}".
                                        format(btext[indices[ind]["start"]+1 :
                                                         indices[ind]["start"]+7]))
                    no_iter = int(btext[indices[ind]["start"]+8 : indices[ind+1]["start"]-1])
                    items.append({"type" : "repeat", "no_iter" : no_iter})
                    strings.append("")
                    start_index = ind

                elif (indices[ind+1]["start"] - indices[ind]["start"] - 1 == 3 and
                    btext[indices[ind]["start"]+1 : indices[ind]["start"]+4] == "end"):
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
        code = code + self.init_code + "\n"

        ind = 0
        start_repeat = None
        no_iter = None
        loop = 0
        while ind < len(items):
            item = items[ind]
            if item["type"] == "text":
                code = code + "page.add_lines(strings[{}])\n".format(ind)
            elif item["type"] == "code":
                # Ignore alignment tags
                if (strings[ind] != "left" and strings[ind] != "right" and strings[ind] != "center"):
                    code = code + "page.add_lines({})\n".format(strings[ind])
            elif item["type"] == "repeat":
                no_iter = item["no_iter"]
                start_repeat = ind
                loop = 0
                code = code + "ITEM = {}\n".format(loop)
                code = code + self.iter_code + "\n"

            elif item["type"] == "end":
                loop = loop + 1
                if loop == no_iter:
                    loop = 0
                    start_repeat = None
                else:
                    code = code + "ITEM = {}\n".format(loop)
                    code = code + self.iter_code + "\n"
                    ind = start_repeat
            ind = ind + 1


        code = code + self.main_script_end

        code = code.replace("\\", "\\\\")
        
        #print(strings)
        #print(code)
        
        lua_fun = self.lua.eval(code)
        ret = lua_fun(page, self.lib, strings)
            
        if self.lib is not None:
            self.lib.add_buttons()
            
        page.add_lines("</div>\n")
        page.add_lines("\n\n<!-- QUESTIONS END -->\n\n")


        
        
    def eval_with_exception(self, page):
        try:
            self.eval(page)
        except Exception as err:
            err_str = "\n\n<br> Error in program:\n {} <br>\n".format(str(err))
            page.add_lines(err_str)
            for l in traceback.format_tb(err.__traceback__):
                page.add_lines("<br> {}".format(l))
    
