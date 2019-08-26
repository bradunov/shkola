import os
import json
import sys
import cherrypy
import math
import lupa
import json
import re
import pickle
import urllib

import base64

from lupa import LuaRuntime
from page import page
from question import question
from qlist import qlist






class editor(object):
    page = None
    q_id = ""
    l_id = ""
    language = ""
    init_code = ""
    iter_code = ""
    text = ""
    question = None
    page_name = ""
    questions_path = "../../questions"
    lists_path = "../../lists"
    state = {}
    config = {}


    def __init__(self):
        self.page = page()
        self.load_config()
        
    
    def load_config(self):
        try:
            self.config = json.load(open(self.questions_path + "/config.json", 'r'))
        except:
            self.config = {}

        print("Config:", self.config)
        
    
    def clear(self):
        self.q_id = ""
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


    def get_all_questions(self, language):
        root = self.questions_path
        qs = []
        for (dirpath, dirnames, filenames) in os.walk(root):
            # Do not display directory and the content of global folder
            # and only select folders that contain the desired language (i.e. text.<language>)
            if not dirnames and dirpath[len(root):len(root)+len("global")] != "global" and "text." + language in filenames:
                qs.append(dirpath[len(root)+1:])
                if (self.q_id == ""):
                    self.q_id = dirpath[len(root)+1:]
        qs.sort()
        return qs

    def get_all_lists(self):
        root = self.lists_path
        qs = []
        print (root)
        for (dirpath, dirnames, filenames) in os.walk(root):
            for f in filenames:
                if f[len(f)-5:len(f)] == ".json":
                    qs.append(f)
                    if self.l_id == "":
                        self.l_id = f
        qs.sort()
        return qs



        

    
    def encap_str(self, string):
        return "\"" + string + "\""
    
    def create_url(self = None, page_name = None, q_id = None, l_id = None, lang = None, state = None, menu = None, js = False):
        first = True

        # Encode state
        encoded_state = urllib.parse.quote_from_bytes(base64.b64encode(pickle.dumps(self.state)))

        
        if js:
            glue = lambda first: " + \"" + ("?" if first else "&")
            url = page_name
            if q_id is not None:
                url = url + glue(first) + "q_id=\" + " + q_id
                first = False
            if l_id is not None:
                url = url + glue(first) + "l_id=\" + " + l_id
                first = False
            if lang is not None:
                url = url + glue(first) + "language=\" + " + lang
                first = False
            if menu is not None:
                url = url + glue(first) + "menu=\" + " + menu
                first = False
            if self.state is not None:
                url = url + glue(first) + "state=" + encoded_state + "\""
        else:
            glue = lambda first: "?" if first else "@" 
            url = page_name
            if q_id is not None:
                url = url + "?q_id=" + q_id
                first = False
            if l_id is not None:
                url = url + "?l_id=" + q_id
                first = False
            if lang is not None:
                url = url + glue(first) + "language=" + lang
                first = False
            if menu is not None:
                url = url + glue(first) + "menu=" + lang
                first = False
            if self.state is not None:
                url = url + glue(first) + encoded_state + "\""

        return url


    
    
    def render_menu_full(self):
        self.page.add_lines("\n\n<!-- FULL MENU START -->\n")
        # Edit or view question
        if self.page_name == "edit" or self.page_name == "view":
            select="<select id='sel_q_id' name='sel_q_id' onchange='window.location.replace(" + \
                                self.create_url(page_name = self.encap_str(self.page_name), \
                                                q_id = "this.value", \
                                                lang = "sel_lang.value", \
                                                menu = self.encap_str("full"), \
                                                js = True) + ")'>\n"
            qs = self.get_all_questions(self.language)
        
            for q in qs:
                if q == self.q_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(q, selected, q)
            select = select + "</select>\n"

        # View list
        elif self.page_name == "list":
            select="<select id='sel_l_id' name='sel_l_id' onchange='window.location.replace(" + \
                                self.create_url(page_name = self.encap_str(self.page_name), \
                                                l_id = "this.value", \
                                                lang = "sel_lang.value", \
                                                menu = self.encap_str("full"), \
                                                js = True) + ")'>\n"
            ls = self.get_all_lists()
        
            for l in ls:
                if l == self.l_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            select = select + "</select>\n"

        
        # Not sure why I have to put explicit height here, otherwise it is zero!
        self.page.add_lines("<div style='display:block;width=100%;height:25px;background-color:#f0f0f0'>\n")
        self.page.add_lines("<span style='display:block;float:left;'>\n" + select + "\n</span>\n")
        lright = "<span style='display:block;float:right;'>\n"

        if ("languages" in self.config):
            lang_select="Language: <select id='sel_lang' name='sel_lang' onchange='window.location.replace("

            if self.page_name == "edit" or self.page_name == "view":
                lang_select = lang_select + self.create_url(page_name = self.encap_str(self.page_name), \
                                                            q_id = "sel_q_id.value", \
                                                            lang = "this.value", \
                                                            menu = self.encap_str("full"), \
                                                            js = True) + ")'>\n"
            # View list
            elif self.page_name == "list":
                lang_select = lang_select + self.create_url(page_name = self.encap_str(self.page_name), \
                                                            l_id = "sel_l_id.value", \
                                                            lang = "this.value",
                                                            menu = self.encap_str("full"), \
                                                            js = True) + ")'>\n"
            
            for l in self.config["languages"]:
                if l == self.language:
                    selected = "SELECTED"
                else:
                    selected = ""
                lang_select = lang_select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            lang_select = lang_select + "</select>\n"
            lright = lright + lang_select


        op_select = "Operation: <select id='sel_op' name='sel_op' onchange='window.location.replace(" + \
                                            self.create_url(page_name = "sel_op.value", \
                                                            q_id = self.encap_str(self.q_id), \
                                                            l_id = self.encap_str(self.l_id), \
                                                            lang = self.encap_str(self.language), \
                                                            menu = self.encap_str("full"), \
                                                            js = True) + ")'>\n"

        options = ["view", "edit", "list"]

        for o in options:
            if o == self.page_name:
                selected = "SELECTED"
            else:
                selected = ""
            op_select = op_select + "<option value='{}' {}> {} </option>\n".format(o, selected, o)
        op_select = op_select + "</select>"
        lright = lright + op_select
        
        self.page.add_lines(lright)
        self.page.add_lines("</div>")

        self.page.add_lines("\n<!-- MENU END -->\n\n")
        


    def render_menu_simple(self):
        self.page.add_lines("\n\n<!-- SIMPLE MENU START -->\n")
        # Edit or view question
        if self.page_name == "edit" or self.page_name == "view":
            select="<select id='sel_q_id' name='sel_q_id' onchange='window.location.replace(" + \
                                self.create_url(page_name = self.encap_str(self.page_name), \
                                                q_id = "this.value", \
                                                lang = "sel_lang.value", \
                                                menu = self.encap_str("simple"), \
                                                js = True) + ")'>\n"

            qs = self.get_all_questions(self.language)
        
            for q in qs:
                if q == self.q_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(q, selected, q)
            select = select + "</select>\n"

        # View list
        elif self.page_name == "list":
            select="<select id='sel_l_id' name='sel_l_id' onchange='window.location.replace(" + \
                                self.create_url(page_name = self.encap_str(self.page_name), \
                                                l_id = "this.value", \
                                                lang = "sel_lang.value", \
                                                menu = self.encap_str("simple"), \
                                                js = True) + ")'>\n"
            ls = self.get_all_lists()
        
            for l in ls:
                if l == self.l_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            select = select + "</select>\n"

        
        # Not sure why I have to put explicit height here, otherwise it is zero!
        self.page.add_lines("<div style='display:block;width=100%;height:25px;background-color:#f0f0f0'>\n")
        self.page.add_lines("<span style='display:block;float:left;'>\n" + select + "\n</span>\n")
        lright = "<span style='display:block;float:right;'>\n"

        if ("languages" in self.config):
            lang_select="<select id='sel_lang' name='sel_lang' onchange='window.location.replace("

            if self.page_name == "edit" or self.page_name == "view":
                #lang_select = lang_select + "?q_id=\" + sel_q_id.value + \"&"
                lang_select = lang_select + self.create_url(page_name = self.encap_str(self.page_name), \
                                                            q_id = "sel_q_id.value", \
                                                            lang = "this.value", \
                                                            menu = self.encap_str("simple"), \
                                                            js = True) + ")'>\n"
            # View list
            elif self.page_name == "list":
                lang_select = lang_select + self.create_url(page_name = self.encap_str(self.page_name), \
                                                            l_id = "sel_l_id.value", \
                                                            lang = "this.value",
                                                            menu = self.encap_str("simple"), \
                                                            js = True) + ")'>\n"
            
            for l in self.config["languages"]:
                if l == self.language:
                    selected = "SELECTED"
                else:
                    selected = ""
                lang_select = lang_select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            lang_select = lang_select + "</select>\n"
            lright = lright + lang_select

        
        self.page.add_lines(lright)
        self.page.add_lines("</div>")

        self.page.add_lines("\n<!-- MENU END -->\n\n")



        

    def render_menu(self, menu_type = "full"):
        if menu_type == "simple":
            self.render_menu_simple()
        else:
            self.render_menu_full()
        



            
    def render_page(self, menu = "full"):
        self.render_menu(menu)

        style = "border:6px;padding:6px;"
        self.page.add_lines("""
        <div>
          <span style='float:left;display:inline;""" + style + """'>
            <form method="post" action="generate">
              <input type="hidden" id="q_id" name="q_id" value='""" + self.q_id + """'>
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
            self.page.add_lines("<span style='float:left;display:inline'>")
            # Most common mogile web pages are 360 x 640 (https://www.hobo-web.co.uk/best-screen-size/)
            # but I can't seem to enforce a size in this view, so skipping for now
            #self.page.add_lines("<div style='border-style:dotted;display:table;height=360px;width=640px;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            self.page.add_lines("<div style='border-style:dotted;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            self.question.eval_with_exception()
            self.page.add_lines("</div>")
            self.page.add_lines("</span>")
            
        self.page.add_lines("""
        </div>
        """)
        
        return self.page.render()



    def render_simple_page(self, menu = "full"):

        self.render_menu(menu)
        
        if self.question is not None:
            self.page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>")
            self.question.eval_with_exception()
            self.page.add_lines("</div>")
            
        
        return self.page.render()



    def parse_parameters(self, page_name, q_id = None, l_id = None, language = None, state = None):
        self.page_name = page_name

        # If no question supplied, get the first one for the language
        if q_id is None or not q_id:
            self.q_id = self.get_all_questions(language)[0]
        else:
            self.q_id = q_id

        if l_id is None or not l_id:
            self.l_id = self.get_all_lists()[0]
        else:
            self.l_id = l_id
            
        if language is not None:
            self.language = language
        else:
            self.language = ""
            
        if state is not None:
            self.state = pickle.loads(base64.b64decode(urllib.parse.unquote_to_bytes(state)))
            print("State:", self.state)
        else:
            state = {}
            

        print(page_name, q_id, l_id, language)
            
        
    @cherrypy.expose
    def edit(self, q_id = None, l_id = None, language = "rs", menu = "full", state = None):
        self.clear()
        self.page.clear_lines()

        self.parse_parameters("edit", q_id, l_id, language, state)
        
            
        q = question(self.page, self.q_id, self.language, self.questions_path)
        q.set_from_file_with_exception()
        self.add_question(q)
        self.add_code(q.get_init_code(), q.get_iter_code(), q.get_text())

        return self.render_page(menu)

    
    
    @cherrypy.expose
    def generate(self, q_id = "", l_id = None, language = "", menu = "full", init_code = "", iter_code = "", text = ""):
        self.clear()
        self.page.clear_lines()

        self.parse_parameters("edit", q_id, l_id, language, state)

        
        self.add_code(init_code, iter_code, text)
        q = question(self.page, self.q_id, self.language, self.questions_path, init_code, iter_code, text)
        self.add_question(q)

        return self.render_page(menu)



    @cherrypy.expose
    def view(self, q_id = None, l_id = None, language = "rs", menu = "full", state = None):
        self.clear()
        self.page.clear_lines()

        self.parse_parameters("view", q_id, l_id, language, state)

                    
        q = question(self.page, self.q_id, self.language, self.questions_path)
        q.set_from_file_with_exception()
        self.add_question(q)

        return self.render_simple_page(menu)


    
    @cherrypy.expose
    def list(self, q_id = None, l_id = None, language = "rs", menu = "full", state = None):
        self.clear()
        self.page.clear_lines()

        self.parse_parameters("list", q_id, l_id, language, state)

        
        self.render_menu(menu)
        ql = qlist(self.page, self.l_id, self.language, self.questions_path, self.lists_path)
        ql.render_all_questions()
        return self.page.render()


    
    @cherrypy.expose
    def index(self, q_id = None, language = "rs"):
        headers = cherrypy.request.headers
        user_agent = headers['User-Agent'].lower()
        
        MOBILE_AGENT_RE=re.compile(r".*(iphone|mobile|androidtouch)",re.IGNORECASE)

        if MOBILE_AGENT_RE.match(user_agent):
            return self.view(q_id, None, language, menu = "simple")
        else:
            return self.view(q_id, None, language, menu = "full")


        
    @cherrypy.expose
    def mobile(self, q_id = None, language = "rs"):
        return self.view(q_id, None, language, menu = "simple")


    
    @cherrypy.expose
    def nonmobile(self, q_id = None, language = "rs"):
        return self.view(q_id, None, language, menu = "full")
    
                  
if __name__ == '__main__':
    
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


