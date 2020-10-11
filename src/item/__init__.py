import logging

import os

import azure.functions as func


from server.helpers import set_log_level
set_log_level()






# Serve a static file

def main(req: func.HttpRequest) -> func.HttpResponse:
    # Serve a binary file (e.g. picture)
    if 'url' not in req.params.keys():
        logging.error("No URL parameter in the request {}.".format(req.url))
        return func.HttpResponse("ERROR", status_code="400", mimetype="text/html")

    url = req.params['url']

    srv_abs_path = os.path.dirname(os.path.abspath(__file__))
    abs_url = srv_abs_path + "/../" + url

    # TBD: Make this safe (e.g. cannot fetch random file from the system)
    if ".." in url or url[0] == "/":
        logging.error("Url {} contains forbidden characters.".format(url))
        return func.HttpResponse("ERROR", status_code="400", mimetype="text/html")

    try:
        with open(abs_url, mode='rb') as file: 
            fileContent = file.read()
    except IOError:
        logging.error("File {} cannot be read.".format(abs_url))
        return func.HttpResponse("ERROR", status_code="400", mimetype="text/html")


    filename, file_extension = os.path.splitext(url)
    if file_extension == ".svg":
        # SVG has to be served with this content type, otherwise won't be displayed! 
        # https://css-tricks.com/snippets/htaccess/serve-svg-correct-content-type/
        content_type = "image/svg+xml"
    else:
        # Other types seem fine with the generic one
        content_type = "application/octet-stream"


    logging.debug("Serving file: {}".format(abs_url))
    return func.HttpResponse(fileContent, mimetype=content_type)




