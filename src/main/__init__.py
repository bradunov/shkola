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

def main(req: func.HttpRequest) -> func.HttpResponse:
    global PAGE
    if PAGE is None:
        logging.info("Reloading page (%s, %s)", str(use_azure_blob), str(preload))
        PAGE = page.page(use_azure_blob=use_azure_blob, preload=preload)
        #PAGE = page.page(use_azure_blob=True, preload=False)

    headers = dict(req.headers)
    user_agent = headers["user-agent"]

    # logging.info("METHOD: " + str(req.method))
    # logging.info("URL: " + str(req.url))
    # logging.info("HEADERS: " + str(dict(req.headers)))
    # logging.info("PARAMS: " + str(dict(req.params)))
    # logging.info("ROUTE PARAMS: " + str(dict(req.route_params)))
    # logging.info("GET BODY: " + str(req.get_body().decode()))


    try:
        req_body = req.get_json()
    except ValueError:
        pass
    else:
        logging.warning("Request body:", req_body)

    # Q: How do we do POST???
    
    if req.method == "POST":
        op = req.params.post('op')
        q_id = req.params.post('q_id')
        l_id = req.params.post('l_id')
        language = req.params.post('language')
        menu = req.params.post('menu')
        init_code = req.params.post('init_code')
        iter_code = req.params.post('iter_code')
        text = req.params.post('text')
    else:
        op = req.params.get('op')
        q_id = req.params.get('q_id')
        l_id = req.params.get('l_id')
        language = req.params.get('language')
        menu = req.params.get('menu')
        init_code = req.params.get('init_code')
        iter_code = req.params.get('iter_code')
        text = req.params.get('text')

    if not op:
        op = "view"
    if not language:
        language = "rs"
    if not menu:
        if is_user_on_mobile(user_agent):
            menu = "simple"
        else:
            menu = "full"
    if not init_code:
        init_code = ""
    if not iter_code:
        iter_code = ""
    if not text:
        text = ""

    logging.info("Python HTTP trigger function processed a request <{}>: "
                 "q_id={}, l_id={}, language={}, menu={}, init_code={}, iter_code={}, text={}, "
                 "user_agent={}, language={}.".
                 format(op, q_id, l_id, language, menu, init_code, iter_code, text,
                 user_agent, headers["accept-language"]))


    return func.HttpResponse(
        PAGE.main(op, q_id, l_id, language, menu, init_code, iter_code, text), mimetype="text/html")

    
