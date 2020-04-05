import os
import json
import cherrypy
from cherrypy.lib import static

from lupa import LuaRuntime

import sys
sys.path.append("..")

from page import Page
from question import Question
from qlist import Qlist
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
        self.page = Page(use_azure_blob=False, preload=True)
        

    def get_user_agent(self):
        headers = cherrypy.request.headers
        return headers['User-Agent']


    @cherrypy.expose
    def main(self, **args):
        print(args)
        args["root"] = "main"
        return self.page.main(args)

    

    @cherrypy.expose
    def edit(self, args):
        args["root"] = "main"
        return self.page.main(args)

    
    
    @cherrypy.expose
    def generate(self, q_id = "", l_id = None, language = "", menu = "full", user_id=None, init_code="", iter_code="", text="", url=""):
        if op=="item":
            return self.item(url)
        return self.page.main("generate", q_id, l_id, language, menu, user_id, init_code, iter_code, text)



    @cherrypy.expose
    def view(self, op="view", q_id = None, l_id = None, language = "rs", menu = "full", user_id=None, url=""):
        if op=="item":
            return self.item(url)
        return self.page.main(op, q_id, l_id, language, menu, user_id)


    
    @cherrypy.expose
    def list(self, op="list", q_id = None, l_id = None, language = "rs", menu = "full", user_id=None, url=""):
        if op=="item":
            return self.item(url)
        return self.page.main(op, q_id, l_id, language, menu, user_id)


    
    @cherrypy.expose
    def test(self, op="test", q_id = None, l_id = None, language = "rs", menu = "full", user_id=None, url=""):
        if op=="item":
            return self.item(url)
        return self.page.main(op, q_id, l_id, language, menu, user_id)





    
    @cherrypy.expose
    def index(self, q_id = None, language = "rs"):
        if is_user_on_mobile(self.get_user_agent()):
            return self.view("view", q_id, None, language, menu = "simple")
        else:
            return self.view("view", q_id, None, language, menu = "full")


        
    @cherrypy.expose
    def mobile(self, q_id = None, language = "rs"):
        return self.view("view", q_id, None, language, menu = "simple")


    
    @cherrypy.expose
    def nonmobile(self, q_id = None, language = "rs"):
        return self.view("view", q_id, None, language, menu = "full")

    

    @cherrypy.expose
    def testiranje(self, l_id = None, language = "rs"):
        if is_user_on_mobile(self.get_user_agent()):
            return self.test("test", None, l_id, language, menu = "simple")
        else:
            return self.test("test", None, l_id, language, menu = "full")


    @cherrypy.expose
    def item(self, url):
        # Serve a binary file (e.g. picture)

        # TBD: Make this safe (e.g. cannot fetch random file from the system)
        if ".." in url or url[0] == "/":
            logging.error("Url {} contains forbidden characters.".format(url))
            raise cherrypy.HTTPError(status=400)

        srv_abs_path = os.path.dirname(os.path.abspath(__file__))
        if url[:2] == "js":
            abs_url = srv_abs_path + "/../" + url
        elif url[:len("questions")] == "questions" or url[:len("lists")] == "lists":
            abs_url = srv_abs_path + "/../../" + url

        print("Serving file: {}".format(abs_url))

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

