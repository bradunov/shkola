import os
import json
import logging

#DEBUG
from pprint import pprint



# Class that pre-loads the entire read-only repository of
# questions, lists, tests, etc.

class Repository(object):
    path = None

    questions_path = None
    lists_path = None
    
    questions = {}
    lists = {}

    
    def __init__(self, path):
        self.path = path

        if path is None:
            raise "Root path cannot be none."
        
        self.questions_path = path + "/questions"
        self.lists_path = path + "/lists"
        
        self.load_all()


    def check_extension(self, filename, extension):
        return len(filename) > len(extension) and filename[len(filename)-len(extension):] == extension
        

    def find_key(self, d, rootkey):
        leaf = d
        if not rootkey:
            return d
        keys = rootkey.split("/")
        for k in keys:
            if k not in leaf.keys():
                return None
            leaf = leaf[k]
        return leaf
        
    def load_dir(self, root, dir_path):
        for (dirpath, dirnames, filenames) in os.walk(dir_path):
            rootkey = dirpath[len(self.questions_path)+1:]
            d = self.find_key(root, rootkey)
            for dir in dirnames:
                d[dir] = {}                

            for file in filenames:
                if file[len(file)-1:] == "~":
                    logging.info("Skipping: %s", file)
                    continue
                #if len(file) > len(".json") and file[len(file)-len(".json"):] == ".json":
                if self.check_extension(file, ".json"):
                    key = file[:len(file)-len(".json")]
                    d[key] = json.load(open(dirpath + "/" + file, 'r'))
                elif not self.check_extension(file, ".png"):
                    try:
                        with open(dirpath + "/" + file) as f_text:
                            text = f_text.read()
                    except IOError:
                        text = ""
                    d[file] = text

        # DEBUG
        #pprint(root)
    
    def load_all(self):
        self.load_dir(self.questions, self.questions_path)
        self.load_dir(self.lists, self.lists_path)


        
    def get_config(self):
        if "config" in self.questions.keys():
            return self.questions["config"]
        else:
            return {}


    def get_question(self, q_id):
        return self.find_key(self.questions, q_id)

    
    def get_all_question_ids(self, q_path, language):
        q_ids = []
        q = self.find_key(self.questions, q_path)
        all_keys = [q]
        paths = [""]
        while all_keys:
            l = all_keys.pop()
            p = paths.pop()
            for k in l.keys():
                if (k[0] == "q" and ("text."+language) in l[k].keys()):
                    q_ids.append(p + "/" + k)
                if (k != "config" and k != "global" and k[0] != "q"):
                    all_keys.append(l[k])
                    paths.append(((p + "/") if p else "") + k)
        return q_ids

    
    def get_globals(self):
        if "globals" in self.questions.keys():
            return self.questions["globals"]
        else:
            return None

        
    def get_list(self, l_id):
        if l_id is None or not l_id:
            for l_id in self.lists.keys():
                break
        return self.find_key(self.lists, l_id)
    

    def get_all_lists_ids(self, l_path):
        l_ids = []
        l = self.find_key(self.lists, l_path)
        for k in l.keys():
            l_ids.append(k)

        return l_ids
