from server.repository import Repository
import server.storage

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
                 use_azure_blob=False,
                 preload=True,
                 external_log_handler=None):

        #formatter    = logging.Formatter('%(pathname)s:%(funcName)s(%(lineno)d) : %(message)s\n')
        formatter    = logging.Formatter('%(levelname)s %(filename)s:%(funcName)s(%(lineno)d) : %(message)s\n')
        rootLogger = logging.getLogger()

        for hdlr in rootLogger.handlers:
            hdlr.setFormatter(formatter)

        # Any additional handler (e.g. to Azure Log Analytics)
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

        self.repository = Repository(self.rel_path, use_azure_blob, preload)
        self.storage = server.storage.get_storage()
        self.title = title
        self.load_languages()

        file_loader = jinja2.FileSystemLoader(self.template_path)
        self.templates = jinja2.Environment(loader=file_loader)

        logging.info("App data loaded")


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



