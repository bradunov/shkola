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
        style = "border:6px;padding:6px;"
        page.add_lines("""
        <div>
          <span style='float:left;display:inline;""" + style + """'>
            <form method="post" action="generate">
              <div style='""" + style + """background-color:#fafaf0;'>
                  <h3>Init code:</h3>
                  <textarea name="init_code" rows="10" cols="80">
""" + self.init_code + """
                  </textarea>
              </div>
              <div style='""" + style + """background-color:#faf0fa;'>
                  <h3>Iter code:</h3>
                  <textarea name="iter_code" rows="10" cols="80">
""" + self.iter_code + """
                  </textarea>
              </div>
              <div style='""" + style + """background-color:#f0fafa;'>
                  <h3>Question text:</h3>
                  <textarea name="text" rows="10" cols="80">
""" + self.text + """
                  </textarea>
              </div>
              <div style='""" + style + """background-color:#f0faf0;'>
                  <button type="submit">Test</button>
              </div>
                </form>
          </span>
        """)

        if self.question is not None:
            page.add_lines("<span style='float:left;display:inline'>")
            # Most common mogile web pages are 360 x 640 (https://www.hobo-web.co.uk/best-screen-size/)
            # but I can't seem to enforce a size in this view, so skipping for now
            #page.add_lines("<div style='border-style:dotted;display:table;height=360px;width=640px;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            page.add_lines("<div style='border-style:dotted;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            self.question.eval_with_exception(page)
            page.add_lines("</div>")
            page.add_lines("</span>")
            
        page.add_lines("""
        </div>
        """)
        
        return page.render()



    def render_simple_page(self, page):

        if self.question is not None:
            page.add_lines("<span style='float:left'>")
            self.question.eval_with_exception(page)
            page.add_lines("</span>")
            
        
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
        print(editor.simple("fractions/q00006", "rs"))
    else:
        ip_address = os.environ['SHKOLA_IP_ADDR']
        cherrypy.config.update({'server.socket_host': ip_address, 'server.socket_port': 8080})
        cherrypy.quickstart(editor())


