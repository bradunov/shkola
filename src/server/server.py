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

from storage import sqltest


import pprint
pp = pprint.PrettyPrinter(indent=4)



# B: why this doesn't work if we don't put global?
global page, lua, lib



class editor(object):
    #page = None
    q_path = ""
    language = ""
    init_code = ""
    iter_code = ""
    text = ""
    question = None
    page_name = ""

    
    def clear(self):
        self.q_path = ""
        self.language = ""
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


    def get_all_questions(self):
        root = "../../questions/"
        qs = []
        for (dirpath, dirnames, filenames) in os.walk(root):
            if not dirnames:
                print(dirpath)
                qs.append(dirpath[len(root):])
        qs.sort()
        return qs

    def render_menu(self):                       
        select="<select onchange='window.location.replace(\"" + self.page_name + "?q_path=\" + this.value)'>\n"
        qs = self.get_all_questions()
        
        for q in qs:
            if q == self.q_path:
                selected = "SELECTED"
            else:
                selected = ""
            select = select + "<option value='{}' {}> {} </option>\n".format(q, selected, q)
        select = select + "</select>\n"
        #print(select)

        
        # Not sure why I have to put explicit height here, otherwise it is zero!
        page.add_lines("<div style='display:block;width=100%;height:25px;background-color:#f0f0f0'>")
        page.add_lines("<span style='display:block;float:left;'>" + select + "</span>")
        lright = "<span style='display:block;float:right;'>"
        if (self.page_name != "index"):
            lright = lright + "<a href='index?q_path={}'>View</a>".format(self.q_path)
        if (self.page_name != "edit"):
            lright = lright + "<a href='edit?q_path={}'>Edit</a>".format(self.q_path)
        lright = lright + "</span>"
        #print(lright)
        page.add_lines(lright)
        page.add_lines("</div>")
        

    def render_page(self, page):
        self.render_menu()

        style = "border:6px;padding:6px;"
        page.add_lines("""
        <div>
          <span style='float:left;display:inline;""" + style + """'>
            <form method="post" action="generate">
              <input type="hidden" id="q_path" name="q_path" value='""" + self.q_path + """'>
              <input type="hidden" id="language" name="language" value='""" + self.language + """'>
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

        self.render_menu()
        
        if self.question is not None:
            page.add_lines("<span style='float:left'>")
            self.question.eval_with_exception(page)
            page.add_lines("</span>")
            
        
        return page.render()


        
    @cherrypy.expose
    def edit(self, q_path = None, language = "rs"):
        self.clear()
        page.clear_lines()
        lib.clear()
        self.page_name = "edit"
        self.q_path = q_path
        self.language = language

        if q_path is not None:
            self.q_path = q_path
            q = question(lua, lib, q_path, language)
            q.set_from_file_with_exception()
            self.add_question(q)
            self.add_code(q.get_init_code(), q.get_iter_code(), q.get_text())

        return self.render_page(page)

    
    
    @cherrypy.expose
    def generate(self, q_path = "", language = "", init_code = "", iter_code = "", text = ""):
        self.clear()
        page.clear_lines()
        lib.clear()
        self.page_name = "edit"
        self.q_path = q_path
        self.language = language
        
        self.add_code(init_code, iter_code, text)
        q = question(lua, lib, q_path, language, init_code, iter_code, text)
        self.add_question(q)

        return self.render_page(page)



    @cherrypy.expose
    def index(self, q_path = None, language = "rs"):
        self.clear()
        page.clear_lines()
        lib.clear()
        self.page_name = "index"
        self.q_path = q_path
        self.language = language

        if q_path is not None:
            self.q_path = q_path
            q = question(lua, lib, q_path, language)
            q.set_from_file_with_exception()
            self.add_question(q)

        return self.render_simple_page(page)

    
                  
if __name__ == '__main__':
    lua = LuaRuntime(unpack_returned_tuples=True)
    page=page()
    lib=library(lua, page)
    
    #sqltest()

    test = False
    #test = True

    if test:
        editor = editor()
        output = editor.index("fractions/q00020", "rs")
        print("\n\n\n================================================\n\n\n")
        print(output)
    else:
        ip_address = os.environ['SHKOLA_IP_ADDR']
        cherrypy.config.update({'server.socket_host': ip_address, 'server.socket_port': 8080})
        cherrypy.quickstart(editor())


