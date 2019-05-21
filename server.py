import json
import sys
import cherrypy
import math
import lupa
from lupa import LuaRuntime


import pprint
pp = pprint.PrettyPrinter(indent=4)



def create_lua(code):
    lua_call = "function (lib) " + code + " return {['result'] = result, ['answer'] = answer} end"
    return lua_call






class Library(object):
    object_id = 0
    lines = []
    qlines = []
    
    # Math
    def gcd(self, a, b):
        return math.gcd(a,b)

    

    def get_lines(self):
        return self.lines
    
    def clear_lines(self):
        self.lines = []
    

    def create_page(self, code):
        code = code.replace("\\\\", "\\")
        ret = """<html>
          <head>
             <script type="text/javascript" async
               src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML" async>
             </script>
             <script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"> </script>
          </head>
          <body> 
            <div class="row">
              <div class="column">
                <form method="post" action="generate">
                  <textarea name="code" rows="10" cols="80">
""" + str(code).strip() + """
                  </textarea>
                  <br>
                  <button type="submit">Test</button>
                </form>
              </div>
              <div class="column">
"""

        for l in self.lines:
            ret = ret + str(l)

        ret = ret + """
              </div>
            </div>"""

        for l in self.qlines:
            ret = ret + str(l)

        ret = ret + """
          </body>
        </html>"""
        return ret



    def render_all_questions(self, questions):
        i = 0
        self.qlines.append("<br><br><div><h1>Standardni primeri:</h1></div>\n")
        self.qlines.append("<div>Klikni na taster pored primera da ti ga prikazem u vrhu ekrana:</div><br>\n")
        self.qlines.append("<table style=\"width:50%\">\n")
        for q in questions:
            self.qlines.append("<tr><th>\n")
            self.qlines.append("<form method=\"post\" action=\"generate\">")
            self.qlines.append("<textarea name=\"code\" rows=\"10\" cols=\"80\">")
            self.qlines.append(q["question"])
            self.qlines.append("</textarea>\n")
            self.qlines.append("<br>\n")
            self.qlines.append("<button type=\"submit\">Test</button>\n")
            self.qlines.append("</form>\n")
            self.qlines.append("</th></tr>\n")
        self.qlines.append("</table>\n")


    def get_object_id(self):
        self.object_id = self.object_id+1
        return self.object_id

    def text(self, text):
        self.lines.append("<p>" + str(text) + "</p>")


    def fraction_circle(self, sizes):
        object_id = str(self.get_object_id())
        size = 105
        r = 50
        xc = (size - 2 * r) / 2 + r
        line = "<div id=\"circle_" + object_id + "\"></div>\n"
        line = line + "<script>\n"
        line = line + "var paper_" + object_id + " = Raphael(\"circle_" + object_id + "\", " + str(size) + "," + str(size) + ");\n"
        line = line + "var dot_" + object_id + " = paper_" + object_id + ".circle(" + str(xc) + ", " + str(xc) + ", " + str(r) + ").attr({fill: \"#fff\", stroke: \"#000\", \"stroke-width\": 2});\n"
        a = 2 * math.pi / sizes
        for i in range(sizes):
            x = str(xc + math.sin(i*a) * r)
            y = str(xc + math.cos(i*a) * r)
            line = line + "var line_" + object_id + "_" + str(i) + " = paper_" + object_id + ".path( [\"M\", " + str(xc) + ", " + str(xc) + \
                   " , \"L\", " + x + ", " + y + " ] ).attr({\"stroke-width\": 2});\n"
        line = line + "</script>\n"
        print(line)
        self.lines.append( line )

        
    def check_number(self, question, condition):
        qid = self.get_object_id()
        n_answer = 'check_number_answer_{}'.format(qid)
        n_correct = 'check_number_correct_{}'.format(qid)
        v_answer = "document.getElementById(\'" + n_answer + "\').value"
        if "answer" not in str(condition):
            str_condition = v_answer + " == \'" + str(condition) + "\'"
        else:
            str_condition = condition.replace("answer", v_answer)

        self.lines.append( str(question) + "<input type='text' id='" + n_answer + "' />" + \
            "<input type=\"button\" onclick=\"document.getElementById(\'" + n_correct + \
            "\').innerHTML = ((" + str_condition + ")?\'OK\':\'NOT OK\')\" value=\"Proveri\" />" + \
            "<p id=\"" + n_correct + "\"></p>")


    def check_fraction(self, question, numerator, denominator, whole = None):
        qid = self.get_object_id()
        n_answer_numerator = 'check_fraction_answer_numerator_{}'.format(qid)
        n_answer_denominator = 'check_fraction_answer_denominator_{}'.format(qid)
        n_answer_whole = 'check_fraction_answer_whole_{}'.format(qid)
        n_correct = 'check_fraction_correct_{}'.format(qid)
        v_answer_numerator = "document.getElementById(\'" + n_answer_numerator + "\').value"
        v_answer_denominator = "document.getElementById(\'" + n_answer_denominator + "\').value"
        v_answer_whole = "document.getElementById(\'" + n_answer_whole + "\').value"

        str_condition = "(" + v_answer_numerator + " == \'" + str(numerator) + "\' && " + \
                              v_answer_denominator + " == \'" + str(denominator) + "\'"
        if whole is not None:
            str_condition = str_condition + " && " + v_answer_whole + " == \'" + str(whole) + "\'"
        str_condition = str_condition + ")"

        input_numerator = "<input type='text' size='1' id='" + n_answer_numerator + "' />" 
        input_denominator = "<input type='text' size='1' id='" + n_answer_denominator + "' />"
        input_whole = "<input type='text' size='1' id='" + n_answer_whole + "' />"
        input_frac = "\n<table>\n<tbody>\n<tr>\n"
        if whole is not None:
            input_frac = input_frac + "<td rowspan=\"2\">" + input_whole + "</td>\n"
        input_frac = input_frac + "<td style=\"border-bottom:solid 1px\">" + input_numerator + "</td>\n"
        input_frac = input_frac + "</tr>\n<tr>\n<td>" + input_denominator + "</td>\n</tr>\n</tbody>\n</table>\n"

        button = "\n<input type=\"button\" onclick=\"document.getElementById(\'" + n_correct + \
            "\').innerHTML = ((" + str_condition + ")?\'OK\':\'NOT OK\')\" value=\"Proveri\" />" + \
            "\n<p id=\"" + n_correct + "\"></p>\n"
        
        line = str(question) + input_frac + button
        
        self.lines.append( line )




lib = Library()




class Server(object):
    def render_str(self, var):
        print(var)
        return str(var)
    
    def render(self, result, error = False):
        print(lupa.lua_type(result))
        if error:
            return result
        elif lupa.lua_type(result) == "table":
            str = ""
            first = True
            for r in result:
                if first:
                    str = self.render_str(r)
                    first = False
                else:
                    str = str + ", " + self.render_str(r)
            return str
        else:
            return self.render_str(result)

        
    @cherrypy.expose
    def index(self):
        lib.clear_lines()
        return lib.create_page ("")

    
    @cherrypy.expose
    def generate(self, code = ""):
        error = False
        lines = []
        if code:
            code = code.replace("\\", "\\\\")
            try:
                lib.clear_lines()
                lua_fun = lua.eval(create_lua(code))
                ret = lua_fun(lib)
                lines = lib.get_lines()
                

            except Exception as e:
                lines = ["Greska u programu: <br> {}".format(str(e))]
        else:
            lines = []

        return lib.create_page(code)




def load_questions(filename):
    started = False
    q = ""
    questions = []
    with open(filename) as questions_file:
        for line in questions_file:
            if line[0] == "#":
                if started:
                    questions.append({"question" : q}) 
                started = True
                q = ""
            elif started:
                q = q + line
                
    if started:
        questions.append({"question" : q})
        
    return questions

                
if __name__ == '__main__':

    questions = load_questions('questions.txt')
    lib.render_all_questions(questions)
        
    cherrypy.config.update({'server.socket_host': '192.168.137.2', 'server.socket_port': 8080})
    lua = LuaRuntime(unpack_returned_tuples=True)
    cherrypy.quickstart(Server())
