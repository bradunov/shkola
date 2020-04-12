import os
import cherrypy
from cherrypy.lib import static

import sys
sys.path.append("..")

from page import Page
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
        args["root"] = "main"
        args["design"] = "default"
        args["user_agent"] = self.get_user_agent()
        return self.page.main(args)

    

    @cherrypy.expose
    def edit(self, **args):
        args["root"] = "edit"
        args["design"] = "dev"
        args["user_agent"] = self.get_user_agent()
        return self.page.main(args)

    
    
    @cherrypy.expose
    def index(self, **args):
        args["root"] = "edit"
        args["design"] = "dev"
        args["user_agent"] = self.get_user_agent()
        return self.page.main(args)


        
    @cherrypy.expose
    def mobile(self, **args):
        args["mobile"] = True
        args["root"] = "main"
        args["op"] = "view"
        args["user_agent"] = self.get_user_agent()
        return self.page.main(args)


    
    @cherrypy.expose
    def nonmobile(self, **args):
        args["mobile"] = False
        args["root"] = "main"
        args["op"] = "view"
        args["user_agent"] = self.get_user_agent()
        return self.page.main(args)

    


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
        self.page.repository = Repository("../..")

       





if __name__ == '__main__':
    
    try:
        ip_address = os.environ['SHKOLA_IP_ADDR']
    except:
        ip_address = "127.0.0.1"
        pass

    cherrypy.config.update({
        'server.socket_host': ip_address,
        'server.socket_port': 8080,
        'tools.sessions.on': True,
        'use_google_auth': False
    })

    cherrypy.tree.mount(editor(), '/', {'/': {'log.screen': False}})

    cherrypy.engine.start()
    cherrypy.engine.block()

