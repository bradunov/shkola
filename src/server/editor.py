import json
import sys
import cherrypy
import math
import lupa
from lupa import LuaRuntime
from page import page
from question import question

import pprint
pp = pprint.PrettyPrinter(indent=4)



# B: why this doesn't work if we don't put global?
global page, lua


class editor(object):
    #page = None

    def render_start(self, page):
        page.add_lines("""
            <div class="row">
        """)
        
    def render_end(self, page):
        page.add_lines("""
            </div>
        """)
        
    def render_editor(self, page, init_code = "", iter_code = "", text = ""):
        page.add_lines("""
              <div class="column">
                <form method="post" action="generate">
                  <p>Init code:</p>
                  <textarea name="init_code" rows="10" cols="80">
""" + init_code + """
                  </textarea>
                  <br>
                  <p>Iter code:</p>
                  <textarea name="iter_code" rows="10" cols="80">
""" + iter_code + """
                  </textarea>
                  <br>
                  <p>Question text:</p>
                  <textarea name="text" rows="10" cols="80">
""" + text + """
                  </textarea>
                  <br>
                  <button type="submit">Test</button>
                </form>
              </div>
    """)

        
        
    def render_question(self, page, question):
        page.add_lines("""
              <div class="column">
        """)
        
        question.eval_with_exception(page)
        
        page.add_lines("""
              </div>
        """)


        
    @cherrypy.expose
    def index(self, path = None, language = "rs"):
        page.clear_lines()


        self.render_start(page)

        if path is not None:
            q = question(lua)
            q.set_from_file_with_exception(page, "fractions/q00001", "rs")
            self.render_editor(page, q.get_init_code(), q.get_iter_code(), q.get_text())
            self.render_question(page, q)
        else:
            self.render_editor(page)
            
        self.render_end(page)

        return page.render()

    
    
    @cherrypy.expose
    def generate(self, init_code = "", iter_code = "", text = ""):
        page.clear_lines()

        q = question(lua, init_code, iter_code, text)
        
        self.render_start(page)
        self.render_editor(page, init_code, iter_code, text)
        self.render_question(page, q)
        self.render_end(page)
        
        return page.render()



                
if __name__ == '__main__':
    lua = LuaRuntime(unpack_returned_tuples=True)

    page=page()

    cherrypy.config.update({'server.socket_host': '192.168.137.2', 'server.socket_port': 8080})
    cherrypy.quickstart(editor())

    #editor = editor()
    #print(editor.index("fractions/q00001", "rs"))

