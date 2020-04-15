import logging

import os
import sys

# This is the web root dir that has to be defined in Dockerfile 
sys.path.append(os.environ['AzureWebJobsScriptRoot']) 

#sys.path.append(os.path.dirname(os.path.realpath(__file__)) + "/..")

#logging.warning("System path: " + str(sys.path))
#logging.warning("File path: " + str(os.path.dirname(os.path.realpath(__file__))))
#logging.warning("Current path: " + str(os.getcwd()))


from server.helpers import extract_dict_from_post
from server.page import Page
from server.headers import Headers
from server.request import Request

#DEBUG
#from pprint import pprint


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





def main(req: func.HttpRequest) -> func.HttpResponse:
    global PAGE
    if PAGE is None:
        logging.info("Reloading page (%s, %s)", str(use_azure_blob), str(preload))
        PAGE = Page(use_azure_blob=use_azure_blob, preload=preload)


    if False:
        logging.debug("METHOD: " + str(req.method))
        logging.debug("URL: " + str(req.url))
        logging.debug("HEADERS: " + str(dict(req.headers)))
        logging.debug("PARAMS: " + str(dict(req.params)))
        logging.debug("ROUTE PARAMS: " + str(dict(req.route_params)))
        logging.debug("GET BODY: " + str(req.get_body().decode()))
 
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


    if req.method == "POST":
        args = extract_dict_from_post(req.get_body())
    else:
        # req.method == "GET":
        args = dict(req.params)

    args["root"] = "main"

    # For now we default to UK on Azure, for our test
    if "language" not in args.keys():
        args["language"] = "uk"

    headers = Headers()
    request = Request(req)

    page_body = PAGE.main(request, headers, args)

    return func.HttpResponse(
        page_body,
        status_code = headers.status_code(),
        headers = headers.get_headers(),
        mimetype = "text/html"
    )

