import os
import json

import sys
sys.path.append(".")

import cherrypy

from server.page import Page
from server.headers import Headers
from server.request import Request, RequestType
from server.timers import TimerControl

import logging

logging.basicConfig(level=logging.DEBUG)


class Site:

    use_azure_blob = False
    preload = True

    def __init__(self):
        self.page = Page(use_azure_blob=self.use_azure_blob, preload=self.preload)


    @cherrypy.expose
    def main(self, **args_p):
        req = cherrypy.request
        args = req.params

        tc = TimerControl()
        with tc.new_section("request cherrpy"):
            ret = self._main(req, tc, args)

        d = tc.dump()
        logging.debug("TIMERS (%s):\n%s", str(cherrypy.url()), d)

        return ret
    

    def _main(self, req, tc, args):
        headers = Headers()
        request = Request(req, RequestType.CHERRY_PY)

        logging.debug(f"ZARGS: {args}")

        if req.method == "POST":
            # Merge body and request parameters
            # TODO: We cannot assume POST will only send json.
            # We should check content type of the POST request.
            try:
                json_args = json.loads(req.body.read())
                args.update(**json_args)
            except json.JSONDecodeError:
                pass

        args["root"] = "main"
        if "language" not in args.keys():
            args["language"] = "rs"

        with tc.new_section("page_main"):
            page_body = self.page.main(request, headers, tc, args)

        response = cherrypy.response

        for k, v in headers.get_cookies().items():
            response.cookie[k] = v

        for k, v in headers.get_headers(False).items():
            response.headers[k] = v

        response.headers['Content-Type'] = headers.content_type()
        response.status = headers.status_code()

        return page_body


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

        logging.info("Serving file: {}".format(abs_url))

        return cherrypy.lib.static.serve_file(abs_url, content_type,
                                 'attachment', os.path.basename(abs_url))

        

# -------------------------------------------------------------------------------------------------


if __name__ == '__main__':
    
    cherrypy.config.update({
        'server.socket_host': os.environ.get('SHKOLA_IP_ADDR', '127.0.0.1'),
        'server.socket_port': int(os.environ.get('SHKOLA_PORT', 8080))
    })

    # siteconfig = {
    #     '/images': {
    #         'tools.staticdir.on': True,
    #         'tools.staticdir.dir': "images"
    #     }
    # }
    cherrypy.tree.mount(Site(), '/')

    cherrypy.engine.start()
    cherrypy.engine.block()
