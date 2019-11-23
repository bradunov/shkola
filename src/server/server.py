import os
import json
import cherrypy
from cherrypy.lib import static

from lupa import LuaRuntime

from page import page
from question import question
from qlist import qlist
from user_db import UserDB
from storage import get_storage
from results import Results
from helpers import create_url, encap_str, is_user_on_mobile
from test import Test
from repository import Repository


userdb = UserDB()
results = Results()


class editor(object):
    page = None


    def __init__(self):
        self.page = page()

    
    
    def get_user_id(self):
        s = cherrypy.session
        if "user_id" not in s:
            return ""
        else:
            return s["user_id"]
    
    
    def get_login_header(self):
        login_str = ""
        s = cherrypy.session
            
        # self.page.add_lines("<div>{}</div>", cherrypy.request.path_info)
        if is_user_on_mobile():
            menu = "simple"
        else:
            menu = "full"
            
        s['login_return'] = "../" + create_url(page_name = self.page_name, \
                                       q_id = self.q_id, \
                                       l_id = self.l_id, \
                                       lang = self.language, \
                                       menu = menu, \
                                       js = False)

        if cherrypy.config.get("use_google_auth"):
            if 'user_id' not in s:
                login_str = '<div class="g-signin2" style="margin-bottom:0px" data-onsuccess="onSignIn"></div>\n'
                url = cherrypy.url('/users/login_google')
                login_str = login_str + """
                <script>
                function onSignIn(googleUser) {
                    console.log('Google sign in');
                    var profile = googleUser.getBasicProfile();
                    var id_token = googleUser.getAuthResponse().id_token;
                    console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
                    console.log('Name: ' + profile.getName());
                    console.log('Image URL: ' + profile.getImageUrl());
                    console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.

                    var xhr = new XMLHttpRequest();
                    xhr.open('POST', '""" + url + """');
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xhr.onload = function() {
                      console.log('Sign in response: ' + xhr.responseText);
                      if (xhr.responseText == 'OK') {
                          location.reload();
                      }
                    };
                    xhr.send('id_token=' + id_token);
                }
                </script>
                """
        else:
            # self.page.add_lines("\n\n<!-- LOGIN START -->\n")
            # self.page.add_lines("<div style='display:block;width=100%'>")
            # if 'user_id' in s:
            #     s['login_return'] = '/'
            #     self.page.add_lines("Korisnik: {} {} (<a href='users/login_test'>Promeni korisnika</a>)", s['user_id'], userdb.get_user_data()["name"])
            # else:
            #     s['login_return'] = '/'
            #     self.page.add_lines("Niste izabrali korisnika: <a href='users/login_test'>Udjite kao test korisnik</a>")

            login_str = "<select id='sel_user_id' name='sel_user_id' onchange='window.location.replace(\"users/login_test?user_id=\" + this.value)'>n"
            

            if 'user_id' not in s:
                login_str = login_str + "<option value='NONE' SELECTED></option>"

            for i in range(1,4):
                sel_user = format("Korisnik{}").format(i)
                selected = ""
                if 'user_id' in s and s['user_id'] == "local:"+sel_user:
                    selected = "SELECTED"

                login_str = login_str + "<option value='{}' {}>{}</option>".format(sel_user, selected, sel_user)

            login_str = login_str + "</select>\n"


        #self.page.add_lines("\n\n<!-- LOGIN END -->\n")
        #self.page.add_lines(login_str)
        return login_str



    @cherrypy.expose
    def edit(self, q_id = None, l_id = None, language = "rs", menu = "full"):
        self.page.clear()
        self.page.clear_lines()

        self.page.parse_parameters("edit", q_id, l_id, language)
        
            
        q = question(self.page, self.get_user_id())
        q.set_from_file_with_exception()
        self.page.add_question(q)
        self.page.add_code(q.get_init_code(), q.get_iter_code(), q.get_text())

        return self.page.render_page(menu)

    
    
    @cherrypy.expose
    def generate(self, q_id = "", l_id = None, language = "", menu = "full", init_code = "", iter_code = "", text = ""):
        self.page.clear()
        self.page.clear_lines()

        self.page.parse_parameters("edit", q_id, l_id, language)

        
        self.page.add_code(init_code, iter_code, text)
        q = question(self.page, self.get_user_id(), 
                     init_code=init_code, iter_code=iter_code, text=text)
        self.page.add_question(q)

        return self.page.render_page(menu)



    @cherrypy.expose
    def view(self, q_id = None, l_id = None, language = "rs", menu = "full"):
        self.page.clear()
        self.page.clear_lines()

        self.page.parse_parameters("view", q_id, l_id, language)

                    
        q = question(self.page, self.get_user_id())
        q.set_from_file_with_exception()
        self.page.add_question(q)

        return self.page.render_simple_page(menu)


    
    @cherrypy.expose
    def list(self, q_id = None, l_id = None, language = "rs", menu = "full"):
        self.page.clear()
        self.page.clear_lines()

        self.page.parse_parameters("list", q_id, l_id, language)

        
        self.page.render_menu(menu)
        ql = qlist(self.page, self.get_user_id())
        ql.render_all_questions()
        return self.page.render()


    
    @cherrypy.expose
    def test(self, q_id = None, l_id = None, language = "rs", menu = "full"):
        self.page.clear()
        self.page.clear_lines()

        self.page.parse_parameters("test", q_id, l_id, language)


        self.page.render_menu(menu)
        test = Test(self.page, self.get_user_id())
        test.render_next_questions()
        return self.page.render()


        

    
    @cherrypy.expose
    def index(self, q_id = None, language = "rs"):
        if is_user_on_mobile():
            return self.view(q_id, None, language, menu = "simple")
        else:
            return self.view(q_id, None, language, menu = "full")


        
    @cherrypy.expose
    def mobile(self, q_id = None, language = "rs"):
        return self.view(q_id, None, language, menu = "simple")


    
    @cherrypy.expose
    def nonmobile(self, q_id = None, language = "rs"):
        return self.view(q_id, None, language, menu = "full")

    

    @cherrypy.expose
    def testiranje(self, l_id = None, language = "rs"):
        if is_user_on_mobile():
            return self.test(None, l_id, language, menu = "simple")
        else:
            return self.test(None, l_id, language, menu = "full")


    @cherrypy.expose
    def item(self, url):
        # Serve a binary file (e.g. picture)
        # TBD: Make this safe (e.g. cannot fetch random file from the system)
        srv_abs_path = os.path.dirname(os.path.abspath(__file__))
        abs_url = srv_abs_path + "/../../" + url
        return static.serve_file(abs_url, 'application/x-download',
                                 'attachment', os.path.basename(abs_url))

        
    @cherrypy.expose
    def reload(self):
        # Reload all questions
        print("Reloading questions...")
        self.repository = Repository("../..")

       
    
if __name__ == '__main__':
    
    ip_address = os.environ['SHKOLA_IP_ADDR']

    cherrypy.config.update({
        'server.socket_host': ip_address,
        'server.socket_port': 8080,
        'tools.sessions.on': True,
        'use_google_auth': False
    })

    cherrypy.tree.mount(editor(), '/', {'/': {'log.screen': False}})
    cherrypy.tree.mount(userdb, '/users', {'/' : {'log.screen': True}})
    cherrypy.tree.mount(results, '/results', {'/' : {'log.screen': True}})

    cherrypy.engine.start()
    cherrypy.engine.block()

