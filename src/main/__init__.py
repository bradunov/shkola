import logging

import os
import sys


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



use_azure_blob = False
preload = True



def parse_req(req): 

    # logging.info("METHOD: " + str(req.method))
    # logging.info("URL: " + str(req.url))
    # logging.info("HEADERS: " + str(dict(req.headers)))
    # logging.info("PARAMS: " + str(dict(req.params)))
    # logging.info("ROUTE PARAMS: " + str(dict(req.route_params)))
    # logging.info("GET BODY: " + str(req.get_body().decode()))

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
    else:
        params["op"] = req.params.get('op')
        params["q_id"] = req.params.get('q_id')
        params["l_id"] = req.params.get('l_id')
        params["language"] = req.params.get('language')
        params["menu"] = req.params.get('menu')
        params["init_code"] = req.params.get('init_code')
        params["iter_code"] = req.params.get('iter_code')
        params["text"] = req.params.get('text')

    if not params["language"]:
        params["language"] = "rs"

    if not params["init_code"]:
        params["init_code"] = ""
    if not params["iter_code"]:
        params["iter_code"] = ""
    if not params["text"]:
        params["text"] = ""

    headers = dict(req.headers)
    params["user_agent"] = headers["user-agent"]
    params["accept-language"] = headers["accept-language"]

    if is_user_on_mobile(params["user_agent"]):
        params["mobile"] = True
    else:
        params["mobile"] = False


    return params



def exec_req(name, params, req):

    logging.info("Python HTTP trigger function processed a request {} <{}>: "
                 "q_id={}, l_id={}, language={}, menu={}, init_code={}, iter_code={}, text={}, "
                 "user_agent={}, language={}.".
                 format(name, params["op"], params["q_id"], params["l_id"], params["language"], 
                 params["menu"], params["init_code"], params["iter_code"], params["text"],
                 params["user_agent"], params["accept-language"]))


    return func.HttpResponse(
        PAGE.main(params["op"], params["q_id"], params["l_id"], params["language"], 
        params["menu"], params["init_code"], params["iter_code"], params["text"]), 
        mimetype="text/html")





def main(req: func.HttpRequest) -> func.HttpResponse:
    global PAGE
    if PAGE is None:
        logging.info("Reloading page (%s, %s)", str(use_azure_blob), str(preload))
        PAGE = page.page(use_azure_blob=use_azure_blob, preload=preload)


    params = parse_req(req) 

    params["op"] = "test"
    #if params["mobile"]:
    params["menu"] = "simple"

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
