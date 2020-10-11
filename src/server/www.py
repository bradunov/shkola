import os
import cherrypy
from cherrypy.lib import static

import sys
sys.path.append("..")

from page import Page
from repository import Repository
from timers import TimerControl

import logging

from server.helpers import set_log_level
set_log_level()



class editor(object):
    page = None

    def __init__(self):
        self.page = Page(use_azure_blob=False, preload=True, template_path="../templates")
        

    def get_user_agent(self):
        headers = cherrypy.request.headers
        return headers['User-Agent']



    @cherrypy.expose
    def main(self, **args):
        args["root"] = "main"
        args["design"] = "default"
        args["user_agent"] = self.get_user_agent()
        tc = TimerControl()
        with tc.new_section("main"):
            ret = self.page.main(None, None, tc, args)

        d = tc.dump()
        logging.debug("TIMERS:\n%s", d)
        return ret

    

    @cherrypy.expose
    def edit(self, **args):
        args["root"] = "edit"
        args["design"] = "dev"
        args["user_agent"] = self.get_user_agent()
        tc = TimerControl()
        with tc.new_section("edit"):
            ret = self.page.main(None, None, tc, args)

        d = tc.dump()
        logging.debug("TIMERS:\n%s", d)
        return ret


    
    @cherrypy.expose
    def index(self, **args):
        args["root"] = "edit"
        args["design"] = "dev"
        args["user_agent"] = self.get_user_agent()
        tc = TimerControl()
        with tc.new_section("index"):
            ret = self.page.main(None, None, tc, args)

        d = tc.dump()
        logging.debug("TIMERS:\n%s", d)
        return ret


        
    @cherrypy.expose
    def mobile(self, **args):
        args["mobile"] = True
        args["root"] = "main"
        args["op"] = "view"
        args["user_agent"] = self.get_user_agent()
        tc = TimerControl()
        with tc.new_section("mobile"):
            ret = self.page.main(None, None, tc, args)

        d = tc.dump()
        logging.debug("TIMERS:\n%s", d)
        return ret


    
    @cherrypy.expose
    def nonmobile(self, **args):
        args["mobile"] = False
        args["root"] = "main"
        args["op"] = "view"
        args["user_agent"] = self.get_user_agent()
        tc = TimerControl()
        with tc.new_section("nonmobile"):
            ret = self.page.main(None, None, tc, args)

        d = tc.dump()
        logging.debug("TIMERS:\n%s", d)
        return ret
    


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
        elif url[:6] == "images":
            abs_url = srv_abs_path + "/../" + url
        elif url[:5] == "fonts":
            abs_url = srv_abs_path + "/../" + url
        elif url[:len("questions")] == "questions" or url[:len("lists")] == "lists":
            abs_url = srv_abs_path + "/../../" + url

        filename, file_extension = os.path.splitext(url)
        if file_extension == ".svg":
            # SVG has to be served with this content type, otherwise won't be displayed! 
            # https://css-tricks.com/snippets/htaccess/serve-svg-correct-content-type/
            content_type = "image/svg+xml"
        else:
            # Other types seem fine with the generic one
            content_type = "application/x-download"

        print("Serving file: {}".format(abs_url))

        return static.serve_file(abs_url, content_type,
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

