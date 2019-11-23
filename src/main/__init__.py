import logging

import sys
sys.path.append(".")
from server import page
from server import question

#DEBUG
from pprint import pprint


# Cached page object, to speed up load time
# as advised by: https://docs.microsoft.com/en-us/azure/azure-functions/functions-reference-python
PAGE = None


import azure.functions as func



# TBD:
def get_user_id():
    return ""



def main(req: func.HttpRequest) -> func.HttpResponse:

    global PAGE
    if PAGE is None:
        PAGE = page.page(rel_path="..")
    
    print("DEB:", req.method, dict(req.params))
    # pprint({
    #         'method': req.method,
    #         'url': req.url,
    #         'headers': dict(req.headers),
    #         'params': dict(req.params),
    #         'get_body': req.get_body().decode()
    #     })

    try:
        req_body = req.get_json()
    except ValueError:
        pass
    else:
        print("D:", req_body)
        print("DD:", req_body.get('op'))

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
        menu = "full"
    if not init_code:
        init_code = ""
    if not iter_code:
        iter_code = ""
    if not text:
        text = ""

    logging.info("Python HTTP trigger function processed a request <{}>: "
                 "q_id={}, l_id={}, language={}, menu={}, init_code={}, iter_code={}, text={}.".
                 format(op, q_id, l_id, language, menu, init_code, iter_code, text))


    return func.HttpResponse(
        PAGE.main(op, q_id, l_id, language, menu, init_code, iter_code, text), mimetype="text/html")

    
