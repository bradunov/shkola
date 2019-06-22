import os
import json
import sys
import cherrypy
import math
import lupa
from lupa import LuaRuntime
from page import page
from question import question
from library import library


import pprint
pp = pprint.PrettyPrinter(indent=4)



# B: why this doesn't work if we don't put global?
global page, lua, lib


class editor(object):
    #page = None
    init_code = ""
    iter_code = ""
    text = ""
    question = None

    
    def clear(self):
        self.init_code = ""
        self.iter_code = ""
        self.text = ""
        self.question = None
        
    
    def add_code(self, init_code = "", iter_code = "", text = ""):
        self.init_code = init_code
        self.iter_code = iter_code
        self.text = text

    def add_question(self, question):
        self.question = question


    def render_page(self, page):
        page.add_lines("""
        <table border=1>
          <tr> 
            <td> 
                <form method="post" action="generate">
                  <p>Init code:</p>
                  <textarea name="init_code" rows="10" cols="80">
""" + self.init_code + """
                  </textarea>
                  <br>
                  <p>Iter code:</p>
                  <textarea name="iter_code" rows="10" cols="80">
""" + self.iter_code + """
                  </textarea>
                  <br>
                  <p>Question text:</p>
                  <textarea name="text" rows="10" cols="80">
""" + self.text + """
                  </textarea>
                  <br>
                  <button type="submit">Test</button>
                </form>
             </td>
        """)

        if self.question is not None:
            page.add_lines("<td valign=\"top\">")
            self.question.eval_with_exception(page)
            page.add_lines("</td>")
            
        page.add_lines("""
          </tr>
        </table>
        """)
        
        return page.render()


        
    def render_simple_page(self, page):

        if self.question is not None:
            self.question.eval_with_exception(page)
            
        
        return page.render()


        
    @cherrypy.expose
    def index(self, path = None, language = "rs"):
        self.clear()
        page.clear_lines()
        lib.clear()

        if path is not None:
            q = question(lua, lib)
            q.set_from_file_with_exception(page, path, language)
            self.add_question(q)
            self.add_code(q.get_init_code(), q.get_iter_code(), q.get_text())

        return self.render_page(page)

    
    
    @cherrypy.expose
    def generate(self, init_code = "", iter_code = "", text = ""):
        self.clear()
        page.clear_lines()
        lib.clear()

        self.add_code(init_code, iter_code, text)
        q = question(lua, lib, init_code, iter_code, text)
        self.add_question(q)

        return self.render_page(page)



    @cherrypy.expose
    def simple(self, path = None, language = "rs"):
        self.clear()
        page.clear_lines()
        lib.clear()

        if path is not None:
            q = question(lua, lib)
            q.set_from_file_with_exception(page, path, language)
            self.add_question(q)

        return self.render_simple_page(page)

    
                  
if __name__ == '__main__':
    lua = LuaRuntime(unpack_returned_tuples=True)
    page=page()
    lib=library(page)
    
    test = False
    #test = True
    
    if test:
        editor = editor()
        print(editor.index("fractions/q00006", "rs"))
    else:
        ip_address = os.environ['SHKOLA_IP_ADDR']
        cherrypy.config.update({'server.socket_host': ip_address, 'server.socket_port': 8080})
        cherrypy.quickstart(editor())


