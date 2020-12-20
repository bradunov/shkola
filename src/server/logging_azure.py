import logging
import json
#from pythonjsonlogger import jsonlogger
import requests
import datetime
import hashlib
import hmac
import base64
import os
import threading

import server.helpers as helpers
import server.context as context


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


    # log_level: which log level messages to store
    # For performance reason we do not upload all logs immediately, but store them until:
    # - log_level_trigger: message of this level triggers immediate report to the server
    # - log_buffer_size: max number of messages buffered at the logger
    # - log_stale: max delay before reporting the logs
    # 
    # For extra elements in log use:
    # logging.info("msg", extra={'shk_type': 'runtime'})
    # where keys in extra have to start with shk_
    def __init__(self, workspace_id, primary_key, log_type="Logger", log_level=logging.INFO, \
                log_level_trigger=logging.ERROR, log_buffer_size=20, log_stale=datetime.timedelta(seconds=60)):
        logging.StreamHandler.__init__(self)

        self.log_msgs = []
        self.last_log_update = datetime.datetime.now()

        self.workspace_id = workspace_id
        self.primary_key = primary_key
        self.log_type = log_type
        if os.getenv("SHKOLA_NODE_NAME"):
            self.node_name = os.getenv("SHKOLA_NODE_NAME")
        else:
            self.node_name = "Not defined"

        self.log_level_trigger=log_level_trigger
        self.log_buffer_size=log_buffer_size
        self.log_stale=log_stale

        self._lock = threading.Lock()

        self.setLevel(log_level)



    def _upload(self, upload_immediately=False):
        now = datetime.datetime.now()
        if now > self.last_log_update + self.log_stale or \
                len(self.log_msgs) > self.log_buffer_size or upload_immediately:
          json_msg = json.dumps(self.log_msgs)
          #print("\n\n********************\nALL: {}\n\n".format(json_msg))
          self._post_data(self.workspace_id, self.primary_key, json_msg, self.log_type)
          self.log_msgs = []
          self.last_log_update = now


    def _get_user_info(self):
        user = ""
        session_id = ""
        session_data = ""

        try:
            user = context.c.user
        except:
            pass

        try:
            session_id = context.c.session.session_id()
        except:
            pass

        try:
            session_data = str(context.c.session.data())
        except:
            pass

        return user, session_id, session_data


    def log_json(self, type, json_body, upload_immediately=False):
        if not isinstance(json_body, list):
            json_body = [json_body]
        
        now = datetime.datetime.utcnow().isoformat()
        user, session_id, session_data = self._get_user_info()

        for i in json_body:
            i["type"] = type        
            i["node_name"] = self.node_name
            i["time"] = now 
            i["user"] = user
            i["session_id"] = session_id
            i["session_data"] = session_data

        with self._lock:
            self.log_msgs += json_body
            #print("\n\nONE: {}\n\n".format(json.dumps(json_body)))

            self._upload(upload_immediately)



    def emit(self, record):
        now = datetime.datetime.utcnow().isoformat()
        user, session_id, session_data = self._get_user_info()

        json_body = {
          "type" : "Logger", 
          "node_name" : self.node_name,
          "level" : record.levelname, 
          "filename" : record.filename,
          "function" : record.funcName,
          "line" : record.lineno,
          "time" : now, 
          "user" : user,
          "session_id" : session_id,
          "session_data" : session_data,
          "message" : record.msg
        }


        if record.levelno >= logging.ERROR:
            json_body["trace"] = helpers.get_stack_trace()


        # Support for logging(..., extra)
        # Removed as not needed for now and slows things down
        # for k, v in record.__dict__.items():
        #     if k[0:len("shk_")] == "shk_":
        #         json_body[k] = v


        with self._lock:
            self.log_msgs.append(json_body)
            #print("\n\nONE: {}\n\n".format(json.dumps(json_body, indent=2)))

            self._upload(record.levelno >= self.log_level_trigger)




if __name__ == '__main__':
    # Simple log tests

    workspace_id = os.getenv('SHKOLA_LA_WORKSPACE_ID')                    
    primary_key = os.getenv('SHKOLA_LA_PRIMARY_KEY')
    if workspace_id or primary_key:
        log_handler = Logging_handler_azure(workspace_id, primary_key)
    else:
        log_handler = None



    #formatter    = logging.Formatter('%(pathname)s:%(funcName)s(%(lineno)d) : %(message)s\n')
    formatter    = logging.Formatter('%(levelname)s %(filename)s:%(funcName)s(%(lineno)d) : %(message)s\n')
    rootLogger = logging.getLogger()

    for hdlr in rootLogger.handlers:
        hdlr.setFormatter(formatter)

    # Any additional handler (e.g. to Azure Log Analytics)
    if log_handler:
        rootLogger.addHandler(log_handler)
    
    logging.basicConfig(level=logging.DEBUG)
    # https://stackoverflow.com/a/57896847
    logging.Logger.root.level = logging.DEBUG

    logging.error("TEST", extra={"shk_a":"a", "shk_b":"b"})


    log_handler.log_json("Timing", [{"a": "a1"}, {"a": "a2"}])
