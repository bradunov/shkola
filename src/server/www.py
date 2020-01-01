import os
import json
import cherrypy
from cherrypy.lib import static

from lupa import LuaRuntime

import sys
sys.path.append("..")

from page import page
from question import question
from qlist import qlist
from user_db import UserDB
from storage import get_storage
from helpers import *
from test import Test
from repository import Repository

import logging

logging.basicConfig(level=logging.DEBUG)



class editor(object):
    page = None

    def __init__(self):
        self.page = page(use_azure_blob=False, preload=True)
        


    @cherrypy.expose
    def main(self, op="view", q_id=None, l_id=None, language="rs", menu="full", state=None, init_code="", iter_code="", text=""):
        return self.page.main(op, q_id, l_id, language, menu, state, init_code, iter_code, text)

    

    @cherrypy.expose
    def edit(self, q_id = None, l_id = None, language = "rs", menu = "full", state=None):
        return self.page.main("edit", q_id, l_id, language, menu, state)

    
    
    @cherrypy.expose
    def generate(self, q_id = "", l_id = None, language = "", menu = "full", state=None, init_code = "", iter_code = "", text = ""):
        return self.page.main("generate", q_id, l_id, language, menu, state, init_code, iter_code, text)



    @cherrypy.expose
    def view(self, q_id = None, l_id = None, language = "rs", menu = "full", state=None):
        return self.page.main("view", q_id, l_id, language, menu, state)


    
    @cherrypy.expose
    def list(self, q_id = None, l_id = None, language = "rs", menu = "full", state=None):
        return self.page.main("list", q_id, l_id, language, menu, state)


    
    @cherrypy.expose
    def test(self, q_id = None, l_id = None, language = "rs", menu = "full", state=None):
        return self.page.main("test", q_id, l_id, language, menu, state)


        

    
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

       
    @cherrypy.expose
    def logout(self, login_return=None):
        return self.page.logout(login_return)


    @cherrypy.expose
    def login_test(self, user_id=None, login_return=None):
        return self.page.login_test(user_id, login_return)


    @cherrypy.expose
    def register(self, **args):
        self.page.register(args)
        return "OK"




if __name__ == '__main__':
    
    ip_address = os.environ['SHKOLA_IP_ADDR']

    cherrypy.config.update({
        'server.socket_host': ip_address,
        'server.socket_port': 8080,
        'tools.sessions.on': True,
        'use_google_auth': False
    })

    cherrypy.tree.mount(editor(), '/', {'/': {'log.screen': False}})

    cherrypy.engine.start()
    cherrypy.engine.block()

