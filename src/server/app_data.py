from server.repository import Repository
import server.storage
from server.user_db import UserDB
from server.session import SessionDB
from server.helpers import Transliterate
from copy import deepcopy

import jinja2

import os
import json
import logging


class AppData:

    # use_azure_blob = True: use blob for question storage rather than the local disk
    # preload = True: fetch all questions in memory at start time (may be slow for a blob)
    def __init__(self,
                 title="tatamata.org",
                 rel_path=None,
                 template_path=None,
                 items_path=None,
                 use_azure_blob=False,
                 preload=True,
                 external_log_handler=None):

        #formatter    = logging.Formatter('%(pathname)s:%(funcName)s(%(lineno)d) : %(message)s\n')
        formatter    = logging.Formatter('%(levelname)s %(filename)s:%(funcName)s(%(lineno)d) : %(message)s\n')
        rootLogger = logging.getLogger()

        for hdlr in rootLogger.handlers:
            hdlr.setFormatter(formatter)

        # Any additional handler (e.g. to Azure Log Analytics)
        self.external_log_handler = external_log_handler
        if external_log_handler:
            rootLogger.addHandler(external_log_handler)

        if rel_path:
            self.rel_path = rel_path
        else:
            self.rel_path = os.getenv('SHKOLA_REL_PATH')                    

            if not self.rel_path:
                self.rel_path = "../.."

        assert self.rel_path

        logging.info("Paths: initial rel_path: {}".format(self.rel_path))

        self.rel_path = os.path.abspath(self.rel_path)
        logging.info("Paths: rel_path: {}".format(self.rel_path))

        if template_path is None:
            template_path = os.getenv("SHKOLA_TEMPLATES")

        if template_path is None:
            template_path = os.path.join(self.rel_path, 'src/templates')

        self.template_path = os.path.abspath(template_path)

        logging.info("Paths: template_path: {}".format(self.template_path))
        logging.info("Paths: working dir: {}".format(os.getcwd()))


        if items_path is None:
            items_path = os.getenv("SHKOLA_ITEMS")

            if items_path is None:
                items_path = "/item?url="

        self.items_path = items_path

        self.use_azure_blob = use_azure_blob
        self.preload = preload

        self.repository = Repository(self.rel_path, use_azure_blob, preload)

        self.storage = server.storage.get_storage()
        self.userdb = UserDB(self.storage)
        self.sessiondb = SessionDB(self.storage)

        self.title = title
        self.load_languages()

        file_loader = jinja2.FileSystemLoader(self.template_path)
        self.templates = jinja2.Environment(loader=file_loader)

        logging.info("App data loaded")



    def reload_repository(self):
        self.repository = Repository(self.rel_path, self.use_azure_blob, self.preload)



    def load_languages(self):
        local_path = self.rel_path + "/messages/"
        self.messages = dict()

        for (dirpath, dirnames, filenames) in os.walk(local_path):
            for f in filenames:
                if f[len(f)-5:len(f)] == ".json":
                    lang = json.load(open(dirpath + f, 'r', encoding='utf-8'))
                    if lang["key"] in self.messages.keys():
                        logging.error("Language with key {} defined twice!".format(lang["key"]))
                    self.messages[lang["key"].lower()] = lang

                    # Add cyrillic for Serbian
                    if lang["key"].lower() == "rs":
                        lang_c = deepcopy(lang)
                        lang_c["key"] = "rsc"
                        lang_c["language"] = Transliterate.rs(lang_c["language"])
                        lang_c["country"] = Transliterate.rs(lang_c["country"])
                        for k,v in lang_c["messages"].items():
                            lang_c["messages"][k] = Transliterate.rs(v)
                        self.messages["rsc"] = lang_c




    def log_json(self, mode, json_body):
        if self.external_log_handler:
            self.external_log_handler.log_json(mode, json_body)
