import logging

import os
import sys
from urllib.parse import urlparse
from urllib.parse import parse_qs

# This is the web root dir that has to be defined in Dockerfile 
sys.path.append(os.environ['AzureWebJobsScriptRoot']) 

#sys.path.append(os.path.dirname(os.path.realpath(__file__)) + "/..")

#logging.warning("System path: " + str(sys.path))
#logging.warning("File path: " + str(os.path.dirname(os.path.realpath(__file__))))
#logging.warning("Current path: " + str(os.getcwd()))


from server.helpers import *
from server import page
from server import question

#DEBUG
from pprint import pprint


# Cached page object, to speed up load time
# as advised by: https://docs.microsoft.com/en-us/azure/azure-functions/functions-reference-python
PAGE = None


import azure.functions as func


#logging.basicConfig(level=logging.INFO)
logging.basicConfig(level=logging.DEBUG)

# https://stackoverflow.com/a/57896847
logging.Logger.root.level = logging.DEBUG


use_azure_blob = False
preload = True



def parse_req(req): 

    if False:
        #logging.debug("REQ1: {}".format(req.__dict__))
        #logging.debug("REQ2: {}".format(vars(req)))
        logging.debug("METHOD: " + str(req.method))
        logging.debug("URL: " + str(req.url))
        logging.debug("HEADERS: " + str(dict(req.headers)))
        logging.debug("PARAMS: " + str(dict(req.params)))
        logging.debug("ROUTE PARAMS: " + str(dict(req.route_params)))
        logging.debug("GET BODY: " + str(req.get_body().decode()))
        #logging.debug("REQ3: {}".format(req.__dict__["_HttpRequest__headers"].__dict__))
 

    # Header example from Azure:
    # HEADERS: {'x-client-port': '51166', 'sec-fetch-site': 'same-origin', 'disguised-host': 'testshkoladocker.azurewebsites.net', 
    #           'x-forwarded-for': '82.69.90.27:51166', 'x-appservice-proto': 'https', 'sec-fetch-dest': 'document', 
    #           'referer': 'https://testshkoladocker.azurewebsites.net/main', 'sec-fetch-mode': 'navigate', 
    #           'accept-language': 'en-US, en; q=0.9, hr; q=0.8, bs; q=0.7, sr; q=0.6, sl; q=0.5', 
    #           'host': 'testshkoladocker.azurewebsites.net', 'upgrade-insecure-requests': '1', 
    #           'x-arr-ssl': '2048|256|C=US, S=Washington, L=Redmond, O=Microsoft Corporation, OU=Microsoft IT, CN=Microsoft IT TLS CA 5|CN=*.azurewebsites.net', 
    #           'was-default-hostname': 'testshkoladocker.azurewebsites.net', 
    #           'x-waws-unencoded-url': '/main?op=login_test&login_return=gASVaQAAAAAAAAB9lCiMCXBhZ2VfbmFtZZSMBHRlc3SUjARxX2lklIwAlIwEbF9pZJSMD3k1X2ZyYWN0aW9ucy51a5SMBGxhbmeUjAJ1a5SMB3VzZXJfaWSUaASMBG1lbnWUjAZtb2JpbGWUjAJqc5SJdS4%3D&user_id=Zomebody', 
    #           'x-original-url': '/main?op=login_test&login_return=gASVaQAAAAAAAAB9lCiMCXBhZ2VfbmFtZZSMBHRlc3SUjARxX2lklIwAlIwEbF9pZJSMD3k1X2ZyYWN0aW9ucy51a5SMBGxhbmeUjAJ1a5SMB3VzZXJfaWSUaASMBG1lbnWUjAZtb2JpbGWUjAJqc5SJdS4%3D&user_id=Zomebody', 
    #           'request-id': '|9fe76d08-44458cf4688911f9.1.', 
    #           'accept': 'text/html, application/xhtml+xml, application/xml; q=0.9, image/webp, image/apng, */*; q=0.8, application/signed-exchange; v=b3; q=0.9', 
    #           'x-site-deployment-id': 'testshkoladocker', 'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36', 
    #           'x-client-ip': '82.69.90.27', 'content-length': '0', 'connection': 'close', 'accept-encoding': 'gzip, deflate, br', 'client-ip': '82.69.90.27:51166', 'sec-fetch-user': '?1', 
    #           'x-arr-log-id': 'd69d498a-19fe-4673-9809-d2aa180c87c5', 'x-forwarded-proto': 'https', 'max-forwards': '10'}

    params = {}
    if req.method == "POST":
        params["op"] = req.params.post('op')
        params["q_id"] = req.params.post('q_id')
        params["l_id"] = req.params.post('l_id')
        params["language"] = req.params.post('language')
        params["menu"] = req.params.post('menu')
        params["init_code"] = req.params.post('init_code')
        params["iter_code"] = req.params.post('iter_code')
        params["text"] = req.params.post('text')
        params["user_id"] = req.params.post('user_id')
        params["login_return"] = req.params.post('login_return')
    else:
        params["op"] = req.params.get('op')
        params["q_id"] = req.params.get('q_id')
        params["l_id"] = req.params.get('l_id')
        params["language"] = req.params.get('language')
        params["menu"] = req.params.get('menu')
        params["init_code"] = req.params.get('init_code')
        params["iter_code"] = req.params.get('iter_code')
        params["text"] = req.params.get('text')
        params["user_id"] = req.params.get('user_id')
        params["login_return"] = req.params.get('login_return')

    if not params["language"]:
        params["language"] = "uk"

    if not params["init_code"]:
        params["init_code"] = ""
    if not params["iter_code"]:
        params["iter_code"] = ""
    if not params["text"]:
        params["text"] = ""

    headers = dict(req.headers)
    if "user-agent" in headers.keys():
        params["user_agent"] = headers["user-agent"]
    else:
        params["user_agent"] = ""

    if "accept-language" in headers.keys():
        params["user_language"] = headers["accept-language"]
    else:
        params["user_language"] = ""

    if "x-client-ip" in headers.keys():
        # NB: This exists only on Azure, not on a local deployment
        params["remote_ip"] = headers["x-client-ip"]
    else:
        params["remote_ip"] = "0.0.0.0"


    if is_user_on_mobile(params["user_agent"]):
        params["mobile"] = True
    else:
        params["mobile"] = False


    return params



def exec_req(name, params, req):

    logging.info("Python HTTP trigger function processed a request {} <{}>: "
                 "q_id={}, l_id={}, language={}, menu={}, init_code={}, iter_code={}, text={}, "
                 "user_agent={}, language={}, user_id={}.".
                 format(name, params["op"], params["q_id"], params["l_id"], params["language"], 
                 params["menu"], params["init_code"], params["iter_code"], params["text"],
                 params["user_agent"], params["user_language"], 
                 params["user_id"]))

    if params["op"] == "login_test":
        return func.HttpResponse(
            PAGE.login_test(params["user_id"], params["login_return"], params["remote_ip"], params["user_agent"], params["user_language"]),
            mimetype="text/html")

    return func.HttpResponse(
        PAGE.main(params["op"], params["q_id"], params["l_id"], params["language"], 
        params["menu"], params["user_id"], params["init_code"], params["iter_code"], params["text"],
        params["user_agent"], params["user_language"]), 
        mimetype="text/html")





def main(req: func.HttpRequest) -> func.HttpResponse:
    global PAGE
    if PAGE is None:
        logging.info("Reloading page (%s, %s)", str(use_azure_blob), str(preload))
        PAGE = page.page(use_azure_blob=use_azure_blob, preload=preload)


    # POST for registering results
    if req.method == "POST" and req.params['op'] == "register":
        return register(req)


    params = parse_req(req) 

    # For now always run test (as in kids testing knowledge)
    # mode in production
    if params["op"] != "login_test":
        params["op"] = "test"
        
    #if params["mobile"]:
    #params["menu"] = "simple"
    params["menu"] = "mobile"

    return exec_req("MAIN", params, req)

    





def edit(req: func.HttpRequest) -> func.HttpResponse:
    global PAGE
    if PAGE is None:
        logging.info("Reloading page (%s, %s)", str(use_azure_blob), str(preload))
        PAGE = page.page(use_azure_blob=use_azure_blob, preload=preload)


    params = parse_req(req) 

    if not params["op"]:
        params["op"] = "edit"
    #if params["mobile"]:
    params["menu"] = "full"

    return exec_req("EDIT", params, req)




# Callback to register response
def register(req: func.HttpRequest) -> func.HttpResponse:
    global PAGE
    if PAGE is None:
        logging.info("Reloading page (%s, %s)", str(use_azure_blob), str(preload))
        PAGE = page.page(use_azure_blob=use_azure_blob, preload=preload)

    PAGE.register(parse_qs(req.get_body().decode()))

    return "OK"