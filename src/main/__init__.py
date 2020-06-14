import logging

import os
import sys
import json

# This is the web root dir that has to be defined in Dockerfile 
webroot = os.environ.get('AzureWebJobsScriptRoot')
if webroot:
    sys.path.append(webroot)

#sys.path.append(os.path.dirname(os.path.realpath(__file__)) + "/..")

#logging.warning("System path: " + str(sys.path))
#logging.warning("File path: " + str(os.path.dirname(os.path.realpath(__file__))))
#logging.warning("Current path: " + str(os.getcwd()))


from server.page import Page
from server.headers import Headers
from server.request import Request
from server.timers import TimerControl

#DEBUG
#from pprint import pprint


# Cached page object, to speed up load time
# as advised by: https://docs.microsoft.com/en-us/azure/azure-functions/functions-reference-python
PAGE = None


import azure.functions as func


# Not needed anymore, all configured through host.json

#logging.basicConfig(level=logging.INFO)
#logging.basicConfig(level=logging.DEBUG, format='AAAA: %(message)s')

# https://stackoverflow.com/a/57896847
#logging.Logger.root.level = logging.INFO




use_azure_blob = False
preload = True


def main(req: func.HttpRequest) -> func.HttpResponse:
    tc = TimerControl()
    with tc.new_section("request"):
        ret = main_work(req, tc)

    d = tc.dump()
    logging.debug("TIMERS:\n%s", d)

    return ret


def main_work(req: func.HttpRequest, tc: TimerControl) -> func.HttpResponse:
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

    headers = Headers()
    request = Request(req)

    args = dict()
    if req.method == "POST":
        # Merge body and request parameters
        # TODO: We cannot assume POST will only send json.
        # We should check content type of the POST request.
        try:
            args = json.loads(req.get_body().decode())
        except json.JSONDecodeError:
            pass

    args.update(request.get_query_data())

    args["root"] = "main"
    if "language" not in args.keys():
        args["language"] = "rs"

    with tc.new_section("page_main"):
        page_body = PAGE.main(request, headers, tc, args)

    return func.HttpResponse(
        page_body,
        status_code = headers.status_code(),
        headers = headers.get_headers(),
        mimetype = headers.content_type()
    )

