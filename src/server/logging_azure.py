import logging
from pythonjsonlogger import jsonlogger
import json
import requests
import datetime
import hashlib
import hmac
import base64
import os

# Built from the following examples:
# https://dzone.com/articles/python-custom-logging-handler-example
# https://operatingops.org/2019/09/30/python-json-structured-logging/
# https://docs.microsoft.com/en-us/azure/azure-monitor/platform/data-collector-api

class Logging_handler_azure(logging.StreamHandler):


    # Build the API signature
    def _build_signature(self, workspace_id, primary_key, date, content_length, method, content_type, resource):
        x_headers = 'x-ms-date:' + date
        string_to_hash = method + "\n" + str(content_length) + "\n" + content_type + "\n" + x_headers + "\n" + resource
        bytes_to_hash = bytes(string_to_hash, encoding="utf-8")  
        decoded_key = base64.b64decode(primary_key)
        encoded_hash = base64.b64encode(hmac.new(decoded_key, bytes_to_hash, digestmod=hashlib.sha256).digest()).decode()
        authorization = "SharedKey {}:{}".format(workspace_id,encoded_hash)
        return authorization



    # Build and send a request to the POST API
    def _post_data(self, workspace_id, primary_key, body, log_type):
        method = 'POST'
        content_type = 'application/json'
        resource = '/api/logs'
        rfc1123date = datetime.datetime.utcnow().strftime('%a, %d %b %Y %H:%M:%S GMT')
        content_length = len(body)
        signature = self._build_signature(workspace_id, primary_key, rfc1123date, content_length, method, content_type, resource)
        uri = 'https://' + workspace_id + '.ods.opinsights.azure.com' + resource + '?api-version=2016-04-01'

        headers = {
            'content-type': content_type,
            'Authorization': signature,
            'Log-Type': log_type,
            'x-ms-date': rfc1123date
        }

        response = requests.post(uri,data=body, headers=headers)
        if not (response.status_code >= 200 and response.status_code <= 299):
            print("\n\n****** Log Analytics error, response code: {}\n\n".format(response.status_code))



    def __init__(self, workspace_id, primary_key, log_type="Logger", log_level=logging.INFO):
        logging.StreamHandler.__init__(self)

        self.workspace_id = workspace_id
        self.primary_key = primary_key
        self.log_type = log_type

        formatter    = logging.Formatter( \
            '{"level", "%(levelname)s", '\
            '"filename", "%(filename)s", '\
            '"function", "%(funcName)s", '\
            '"line", "%(lineno)d", '\
            '"msg", "%(message)s"}')

        formatter = jsonlogger.JsonFormatter(
                fmt='%(levelname)s %(filename)s %(funcName)s %(lineno)d %(message)s'
            )

        self.setFormatter(formatter)
        self.setLevel(log_level)



    def emit(self, record):
        json_body = self.format(record)
        self._post_data(self.workspace_id, self.primary_key, json_body, self.log_type)
        print("\n\n{}\n\n".format(json_body))




