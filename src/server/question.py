import traceback
import lupa
from lupa import LuaRuntime

class question(object):
    # Lua interpreter
    lua = None
    
    text = ""
    init_code = None
    iter_code = None

    main_script_begin = """
      function (page, strings)
    """
    main_script_end = """
      end
    """

    
    def __init__(self, lua, init_code = None, iter_code = None, text = None):
        self.lua = lua
        self.init_code = init_code
        self.iter_code = iter_code
        self.text = text

    def set_from_file(self, path, language):
        with open("../../questions/{}/init.lua".format(path)) as f_init_code:
            self.init_code = f_init_code.read()
        with open("../../questions/{}/iter.lua".format(path)) as f_iter_code:
            self.iter_code = f_iter_code.read()
        with open("../../questions/{}/text.{}".format(path, language)) as f_text:
            self.text = f_text.read()
            
    def set_from_file_with_exception(self, page, path, language):
        try:
            self.set_from_file(path, language)
        except Exception as err:
            err_str = "Error reading from a question list: <br>\n {}<br>\n".format(str(err))
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

    
    def eval(self, page):

        # Parse text
        indices = [{"start" : 0, "type" : "text"}]
        cend = -1

        # Identify commands and strings
        while True:
            cstart = self.text.find("@", cend + 1)
            if cstart == -1:
                indices.append({"start" : len(self.text), "type" : "end"})
                break
            cend = self.text.find("@", cstart + 1)
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
                    self.text[indices[ind]["start"]+1 : indices[ind]["start"]+7] == "repeat" and
                    self.text[indices[ind]["start"]+7] == "(" and
                    self.text[indices[ind+1]["start"]-1] == ")"):
                    if not start_index is None:
                        raise Exception("Nested repeat in text: {}".
                                        format(self.text[indices[ind]["start"]+1 :
                                                         indices[ind]["start"]+7]))
                    no_iter = int(self.text[indices[ind]["start"]+8 : indices[ind+1]["start"]-1])
                    items.append({"type" : "repeat", "no_iter" : no_iter})
                    strings.append("")
                    start_index = ind

                elif (indices[ind+1]["start"] - indices[ind]["start"] - 1 == 3 and
                    self.text[indices[ind]["start"]+1 : indices[ind]["start"]+4] == "end"):
                    if start_index is None:
                        raise Exception("Repeat ended without starting")
                    items.append({"type" : "end", "start" : start_index})
                    strings.append("")
                    start_index = None

                else:
                    items.append({"type" : "code",
                                  "string" : self.text[indices[ind]["start"]+1 :
                                                       indices[ind+1]["start"]]})
                    strings.append(self.text[indices[ind]["start"]+1 :
                                             indices[ind+1]["start"]])
            elif (indices[ind]["type"] == "text"):
                items.append({"type" : "text",
                              "string" : self.text[indices[ind]["start"]+1 :
                                                   indices[ind+1]["start"]]})
                strings.append(self.text[indices[ind]["start"]+1 :
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

        lua_fun = self.lua.eval(code)
        ret = lua_fun(page, strings)
        

    def eval_with_exception(self, page):
        try:
            self.eval(page)
        except Exception as err:
            err_str = "Error in program: <br>\n {}<br>\n".format(str(err))
            page.add_lines(err_str)
            for l in traceback.format_tb(err.__traceback__):
                page.add_lines("<br> {}".format(l))
            
