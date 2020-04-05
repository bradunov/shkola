import os
import json
import logging

from server.azure_blob import azure_blob

#DEBUG
from pprint import pprint



# Class that pre-loads the entire read-only repository of
# questions, lists, tests, etc.

class Repository(object):
    path = None

    questions_path = "questions"
    lists_path = "lists"
    
    questions = {}
    lists = {}
    content = {}

    azure_blob = None
    preload = True
    
    def __init__(self, local_path=None, use_azure_blob=False, preload=True):
        self.local_path = local_path
        if local_path is None and use_azure_blob == False:
            raise "Either set root path or use blobs."
        

        if (use_azure_blob):
            self.azure_blob = azure_blob("/home/bozidar/shkola")
            print("Using Azure Blob storage for questions")

        self.preload = preload
        if (preload):
            self.load_all()



    ##############################
    # Disk API

    def get_config_disk(self):
        root = "../../" + self.questions_path
        d = json.load(open(root + "/config.json", 'r'))
        return d

    def get_all_questions_disk(self, language):
        root = "../../" + self.questions_path
        qs = []
        for (dirpath, dirnames, filenames) in os.walk(root):
            # Do not display directory and the content of global folder
            # and only select folders that contain the desired language (i.e. text.<language>)
            if not dirnames and dirpath[len(root):len(root)+len("global")] != "global" and "text." + language in filenames:
                qs.append(dirpath[len(root)+1:])
        return qs

    def get_all_lists_disk(self):
        root = "../../" + self.lists_path
        qs = []
        for (dirpath, dirnames, filenames) in os.walk(root):
            for f in filenames:
                if f[len(f)-5:len(f)] == ".json":
                    qs.append(f)
                    #if self.l_id == "":
                    #    self.l_id = f
        return qs

    def get_question_disk(self, q_id):
        local_path = "../../" + self.questions_path + "/" + q_id
        d = dict()
        for (dirpath, dirnames, filenames) in os.walk(local_path):
            rootkey = dirpath[len(local_path)+1:]

            for file in filenames:
                if file[len(file)-1:] == "~" or self.check_extension(file, ".png"):
                    print("Skipping:", file)
                    continue
                try:
                    with open(dirpath + "/" + file) as f_text:
                        text = f_text.read()
                except IOError:
                    text = ""
                d[file] = text
        return d

    def get_list_disk(self, l_id):
        local_path = "../../" + self.lists_path + "/" + l_id
        d = json.load(open(local_path, 'r'))
        return d


    def get_globals_disk(self):
        local_path = "../../" + self.questions_path + "/globals"
        d = dict()
        for (dirpath, dirnames, filenames) in os.walk(local_path):
            rootkey = dirpath[len(local_path)+1:]

            for file in filenames:
                if file[len(file)-1:] == "~" or self.check_extension(file, ".png"):
                    print("Skipping:", file)
                    continue
                try:
                    with open(dirpath + "/" + file) as f_text:
                        text = f_text.read()
                except IOError:
                    text = ""
                d[file] = text
        return d
        

    
    ##############################
    # Blob API

    def get_config_blob(self):
        file = self.questions_path + "/config.json"
        d = json.loads(self.azure_blob.download_file(file))
        return d

    def get_all_questions_blob(self, language):
        root = self.questions_path
        qs = []
        list_files = self.azure_blob.list_files(root)
        for f in list_files:
            file = f['name']
            # Do not display directory and the content of global folder
            # and only select folders that contain the desired language (i.e. text.<language>)
            if file[len(root):len(root)+len("global")] != "global" and "text." + language in file:
                qs.append(file[len(root)+1:len(file)-len("text." + language)-1])
        return qs

    def get_all_lists_blob(self):
        root = self.lists_path
        qs = []
        list_files = self.azure_blob.list_files(root)
        for fi in list_files:
            f = fi['name']
            if f[len(f)-5:len(f)] == ".json":
                qs.append(f[len(root)+1:])
        return qs

    def get_question_blob(self, q_id):
        path = self.questions_path + "/" + q_id
        d = dict()
        list_files = self.azure_blob.list_files(path)
        for f in list_files:
            file = f['name']
            file = file[len(path)+1:]
            if file[len(file)-1:] == "~" or self.check_extension(file, ".png"):
                print("Skipping:", file)
                continue
            d[file] = self.azure_blob.download_file(f['name'])
        return d

    def get_list_blob(self, l_id):
        path = self.lists_path + "/" + l_id
        d = json.loads(self.azure_blob.download_file(path))
        return d


    def get_globals_blob(self):
        path = self.questions_path + "/globals"
        d = dict()
        list_files = self.azure_blob.list_files(path)
        for f in list_files:
            file = f['name']
            file = file[len(path)+1:]
            if file[len(file)-1:] == "~" or self.check_extension(file, ".png"):
                print("Skipping:", file)
                continue
            d[file] = self.azure_blob.download_file(f['name'])
        return d

    #################

    
    
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
        
    def add_path(self, d, rootkey):
        leaf = d
        if not rootkey:
            return d
        # Remove the first key (e.g. questions)
        keys = rootkey.split("/")[1:]
        parent = None
        for k in keys:
            parent = leaf
            if k not in leaf.keys():
                leaf[k] = {}
            leaf = leaf[k]
            key = k
        return (parent, key)
        
    def load_dir(self, root, path):
        if not self.azure_blob:
            local_path = self.local_path + "/" + path
            
            logging.debug("* File path: " + str(os.path.dirname(os.path.realpath(__file__))))
            logging.debug("* Current path: " + str(os.getcwd()))
            logging.debug("* Local path: " + str(local_path))
            logging.debug("* Load dir: " + str(root) + " - " + str(path))

            for (dirpath, dirnames, filenames) in os.walk(local_path):
                rootkey = dirpath[len(local_path)+1:]
                d = self.find_key(root, rootkey)
                for dir in dirnames:
                    d[dir] = {}                

                for file in filenames:
                    if file[len(file)-1:] == "~":
                        print("Skipping:", file)
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
        else:
            list_files = self.azure_blob.list_files(path)
            for f in list_files:
                file = f['name']
                logging.debug("Loading file from BLOB: %s", file)

                if file[len(file)-1:] == "~":
                    logging.debug("Skipping: %s", file)
                    continue
                
                if self.check_extension(file, ".json"):
                    key = file[:len(file)-len(".json")]
                    (parent, key) = self.add_path(root, key)
                    try:
                        parent[key] = json.loads(self.azure_blob.download_file(file))
                    except:
                        print("\n\n*************************************")
                        print("Errof reading JSON list {}".format(file))
                        print("*************************************\n\n")
                        raise
                elif not self.check_extension(file, ".png"):
                    (parent, key) = self.add_path(root, file)
                    parent[key] = self.azure_blob.download_file(file)
        # DEBUG
        #pprint(root)

        

    # Create separate lists for each theme, subtheme, level, etc.
    def create_content(self, language=None):
        self.content = {}

        for list_name, list_dict in self.lists.items():
            if len(list_name)>=len("notest_") and list_name[0:len("notest_")]=="no_tests":
                logging.debug("Skipping list %s in content - starting with notest_", list_name)
                continue
            if "level" not in list_dict.keys() or \
                "theme" not in list_dict.keys() or \
                "questions" not in list_dict.keys() or \
                "language" not in list_dict.keys():
                logging.debug("Skipping list %s in content - no level or theme or questions or language", list_name)
                continue
            language = list_dict["language"]
            level = list_dict["level"]
            theme = list_dict["theme"]
            questions = list_dict["questions"]
            if language not in self.content.keys():
                self.content[language] = {}
            if level not in self.content[language].keys():
                self.content[language][level] = {}
            if theme not in self.content[language][level].keys():
                self.content[language][level][theme] = {"name" : list_name}
            
            for q in questions:
                if "period" not in q.keys() or \
                    "subtheme" not in q.keys() or \
                    "difficulty" not in q.keys():
                    logging.debug("Skipping question %s list %s in content - no period or subtheme or difficulty", 
                        q["name"], list_name)
                    continue

                if isinstance(q["subtheme"], list): 
                    for st in q["subtheme"]:
                        label = "{}/{}/{}".format(st, q["period"], q["difficulty"])

                        if label not in self.content[language][level][theme].keys():
                            self.content[language][level][theme][label] = {"questions" : []}

                        self.content[language][level][theme][label]["questions"].append(q)
                else:
                    label = "{}/{}/{}".format(q["subtheme"], q["period"], q["difficulty"])

                    if label not in self.content[language][level][theme].keys():
                        self.content[language][level][theme][label] = {"questions" : []}

                    self.content[language][level][theme][label]["questions"].append(q)

        




    def load_all(self):
        self.load_dir(self.questions, self.questions_path)
        self.load_dir(self.lists, self.lists_path)

        #logging.debug("AAA {}".format(self.lists))

        self.create_content()
        #logging.debug("BBB {}".format(self.content))

        
    def get_config(self):
        if self.preload:
            if "config" in self.questions.keys():
                return self.questions["config"]
            else:
                return {}
        else:
            if self.azure_blob is None:
                return self.get_config_disk()
            else:
                return self.get_config_blob()


    def get_question(self, q_id):
        if self.preload:
            return self.find_key(self.questions, q_id)
        else:
            if self.azure_blob is None:
                return self.get_question_disk(q_id)
            else:
                return self.get_question_blob(q_id)

    
    def get_all_question_ids(self, q_path, language):
        if self.preload:
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
        else:
            if self.azure_blob is None:
                return self.get_all_questions_disk(language)
            else:
                return self.get_all_questions_blob(language)

    
    def get_globals(self):
        if self.preload:
            if "globals" in self.questions.keys():
                return self.questions["globals"]
            else:
                return None
        else:
            if self.azure_blob is None:
                self.get_globals_disk()
            else:
                self.get_globals_blob()
                

        
    def get_list(self, l_id):
        if self.preload:
            if l_id is None or not l_id:
                for l_id in self.lists.keys():
                    break
            return self.find_key(self.lists, l_id)
        else:
            if self.azure_blob is None:
                return self.get_list_disk(l_id)
            else:
                return self.get_list_blob(l_id)


    def get_all_lists_ids(self, l_path, language=None):
        if self.preload:
            l_ids = []
            l = self.find_key(self.lists, l_path)
            for k in l.keys():
                if language is None or ("language" in l[k].keys() and l[k]["language"] == language):
                    l_ids.append(k)
            return l_ids
        else:
            if self.azure_blob is None:
                return self.get_all_lists_disk()
            else:
                return self.get_all_lists_blob()


    def get_content(self, language):
        return self.content[language]
