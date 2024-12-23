import os
import json
import logging
import glob

import server.helpers as helpers
from server.types import PageLanguage
from server.azure_blob import Azure_blob




# Class that pre-loads the entire read-only repository of
# questions, lists, tests, etc.

class Repository(object):
    path = None

    questions_path = "questions"
    lists_path = "lists"
    icons_path = "images/themes"
    
    questions = {}
    lists = {}
    content = {}
    icons = {}
    icon_svgs = {}

    azure_blob = None
    preload = True
    
    def __init__(self, local_path=None, use_azure_blob=False, preload=True):
        self.local_path = local_path
        if local_path is None and use_azure_blob == False:
            raise "Either set root path or use blobs."
        

        if (use_azure_blob):
            self.azure_blob = Azure_blob("/home/bozidar/shkola")
            print("Using Azure Blob storage for questions")
        else:
            print("Using disk storage for questions")

        self.preload = preload
        if (preload):
            self.load_all()



    ##############################
    # Disk API

    # def get_config_disk(self):
    #     root = "../../" + self.questions_path
    #     d = json.load(open(root + "/config.json", 'r'))
    #     return d

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
            #rootkey = dirpath[len(local_path)+1:]

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


    def get_icons_disk(self, file_names, is_json=False):
        full_path_names = glob.glob(self.icons_path + "/" + file_names)
        d = {}
        for full_path_name in full_path_names:
            name = full_path_name.split("/")[-1].split("\\")[-1].strip().lower()
            logging.debug("PATH: {}, {}, {}".format(full_path_name, os.getcwd(), name))
            if is_json:
                d[name] = json.load(open(full_path_name, 'r', encoding="utf8"))
            else:
                d[name] = open(full_path_name, 'r', encoding="utf8").read()
        return d


    def get_globals_disk(self):
        local_path = "../../" + self.questions_path + "/globals"
        d = dict()
        for (dirpath, dirnames, filenames) in os.walk(local_path):
            #rootkey = dirpath[len(local_path)+1:]

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

    # def get_config_blob(self):
    #     file = self.questions_path + "/config.json"
    #     d = json.loads(self.azure_blob.download_file(file))
    #     return d

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
        if (os.sep == '\\'):
            if os.sep in rootkey:
                keys = rootkey.split(os.sep)
            else:
                keys = rootkey.split('/')
        else:
            keys = rootkey.split(os.sep)
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
        keys = rootkey.split(os.sep)[1:]
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
            #logging.debug("* Load dir: " + str(root) + " - " + str(path))

            for (dirpath, dirnames, filenames) in os.walk(local_path):
                rootkey = dirpath[len(local_path)+1:]
                d = self.find_key(root, rootkey)                
                for dir in dirnames:
                    d[dir] = {}                

                for file in filenames:
                    if file[len(file)-1:] == "~" or file == "requirements.txt":
                        print("Skipping:", file)
                        continue
                    #if len(file) > len(".json") and file[len(file)-len(".json"):] == ".json":
                    if self.check_extension(file, ".json"):
                        try:
                            key = file[:len(file)-len(".json")]
                            d[key] = json.load(open(dirpath + "/" + file, 'r', encoding='utf-8'))
                        except Exception as e:
                            logging.error( \
                                "\n\n**********************************************\n" + \
                                "Error parsing JSON file {}: {}\n".format(file, e) + \
                                "**********************************************\n"\
                                )
                            pass
                    elif not self.check_extension(file, ".png") and \
                         not self.check_extension(file, ".xls") and \
                         not self.check_extension(file, ".xlsx") and \
                         not self.check_extension(file, ".docx") and \
                         not self.check_extension(file, ".sh") and \
                         not self.check_extension(file, ".py"):
                        try:
                            with open(dirpath + "/" + file, encoding='utf-8') as f_text:
                                text = f_text.read()
                        except Exception as e:
                            logging.error( \
                                "\n\n**********************************************\n" + \
                                "Error parsing file {}: {}\n".format(file, e) + \
                                "**********************************************\n"\
                                )
                            text = ""
                            pass
                            

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
        #print(json.dumps(root, indent=4))

        

    def _check_exists(self, qlist, qcheck):
        for q in qlist:
            if q["name"] == qcheck["name"] and q["subtheme"] == qcheck["subtheme"]:
                return True
        return False


    # Create separate lists for each theme, subtheme, level, etc.
    def create_content(self, language=None):
        self.content = {}

        for list_name, list_dict in self.lists.items():
            if len(list_name)>=len("notest_") and list_name[0:len("notest_")]=="no_tests":
                logging.debug("Skipping list %s in content - starting with notest_", list_name)
                continue
            if type(list_dict) is not dict:
                logging.debug("Skipping list %s in content - not a dictionary", list_name)
                continue
            if "level" not in list_dict.keys() or \
                "theme" not in list_dict.keys() or \
                "questions" not in list_dict.keys() or \
                "language" not in list_dict.keys():
                logging.debug("Skipping list %s in content - no level or theme or questions or language", list_name)
                continue
            language = list_dict["language"].lower().strip()
            level = list_dict["level"].lower().strip()
            level_short = list_dict["level_short"].lower().strip()
            theme = list_dict["theme"].lower().strip()
            rank_theme = list_dict["rank_theme"]
            questions = list_dict["questions"]
            if language not in self.content.keys():
                self.content[language] = {}
            if level not in self.content[language].keys():
                self.content[language][level] = {"level_short" : level_short}
            if theme not in self.content[language][level].keys():
                self.content[language][level][theme] = {
                    "name" : list_name,
                    "rank" : rank_theme
                }
            
            for q in questions:
                if "period" not in q.keys() or \
                    "subtheme" not in q.keys() or \
                    "topic" not in q.keys() or \
                    "difficulty" not in q.keys():
                    logging.debug("Skipping question %s list %s in content - no period or subtheme or difficulty", 
                        q["name"], list_name)
                    continue

                # One question can belong to multiple subthemes
                if isinstance(q["subtheme"], list): 

                    for st in q["subtheme"]:
                        label = "{}|{}|{}|{}".format(st.lower().strip(), q["topic"].lower().strip(), \
                            q["period"].lower().strip(), q["difficulty"].lower().strip())

                        if label not in self.content[language][level][theme].keys():
                            self.content[language][level][theme][label] = {
                                "subtheme" : st.lower().strip(),
                                "topic" : q["topic"].lower().strip(),
                                "period" : q["period"].lower().strip(),
                                "rank_subtheme" : q["rank_subtheme"].lower().strip() if "rank_subtheme" in q.keys() else "100",
                                "rank_topic" : q["rank_topic"].lower().strip() if "rank_topic" in q.keys() else "100",
                                "difficulty" : q["difficulty"].lower().strip(),
                                "questions" : []
                            }

                        next_q = {
                            "name" : q["name"].strip(),
                            "subtheme" : st.lower().strip(),
                            "topic" : q["topic"].strip() if "topic" in q.keys() else "",
                            "period" : q["period"].strip() if "period" in q.keys() else "", 
                            "rank_subtheme" : q["rank_subtheme"].lower().strip() if "rank_subtheme" in q.keys() else "100",
                            "rank_topic" : q["rank_topic"].lower().strip() if "rank_topic" in q.keys() else "100",
                            "difficulty" : q["difficulty"].strip() if "difficulty" in q.keys() else "",
                            "random" : int(q["random"]) if "random" in q.keys() else 0
                        }

                        if self._check_exists(self.content[language][level][theme][label]["questions"], next_q):
                            logging.error("Question {} appears multiple times in list {}/{}/{}/{}/{}".format(
                                next_q["name"], language, level, theme, label, st
                            ))
                        else:
                            self.content[language][level][theme][label]["questions"].append(next_q)
                else:
                    label = "{}|{}|{}|{}".format(q["subtheme"].lower().strip(), q["topic"].lower().strip(), \
                        q["period"].lower().strip(), q["difficulty"].lower().strip())

                    if label not in self.content[language][level][theme].keys():
                        self.content[language][level][theme][label] = {
                            "subtheme" : q["subtheme"].lower().strip(),
                            "topic" : q["topic"].lower().strip(),
                            "period" : q["period"].lower().strip(),
                            "rank_subtheme" : q["rank_subtheme"].lower().strip() if "rank_subtheme" in q.keys() else "100",
                            "rank_topic" : q["rank_topic"].lower().strip() if "rank_topic" in q.keys() else "100",
                            "difficulty" : q["difficulty"].lower().strip(),
                            "questions" : []
                        }

                    next_q = {
                        "name" : q["name"].strip(),
                        "subtheme" : q["subtheme"].strip() if "subtheme" in q.keys() else "",
                        "topic" : q["topic"].strip() if "topic" in q.keys() else "",
                        "period" : q["period"].strip() if "period" in q.keys() else "", 
                        "rank_subtheme" : q["rank_subtheme"].lower().strip() if "rank_subtheme" in q.keys() else "100",
                        "rank_topic" : q["rank_topic"].lower().strip() if "rank_topic" in q.keys() else "100",
                        "difficulty" : q["difficulty"].strip() if "difficulty" in q.keys() else "",
                        "random" : int(q["random"]) if "random" in q.keys() else 0
                    }

                    if self._check_exists(self.content[language][level][theme][label]["questions"], next_q):
                        logging.error("Question {} appears multiple times in list {}/{}/{}/{}".format(
                            next_q["name"], language, level, theme, label
                        ))
                    else:
                        self.content[language][level][theme][label]["questions"].append(next_q)



    def get_content(self, language):
        # Special provisioning for Serbian cyrillic
        if language == PageLanguage.RSC.value:
            return self.content[PageLanguage.RS.value]
        else:
            return self.content[language]



    # Find the details (like topic, difficulty) for q_id within level and theme. 
    # In the results we log the topic, difficulty, etc for the test, not for the question itself.
    # So we may record topic = "*", difficulty = "*", etc. Here, we recover the corresponding value.
    # TBD: we should be fixed, and we should record the actual values in the response
    def get_content_question_detail(self, language, level, theme, subtheme, q_id):
        # Special provisioning for Serbian cyrillic
        if language == PageLanguage.RSC:
            language = PageLanguage.RS.value
        else:
            language = language.value

        level = level.lower().strip()
        theme = theme.lower().strip()
        subtheme = subtheme.lower().strip()

        if language not in self.content.keys() or \
            level not in self.content[language].keys() or \
            theme not in self.content[language][level].keys():
            return []

        q_info = None

        for k,v in self.content[language][level][theme].items():
            if k == "name" or k == "rank":
                continue

            if not v["questions"]:
                continue

            if v["questions"][0]["subtheme"].lower().strip() != subtheme:
                continue

            for q in v["questions"]:
                if q["name"] == q_id:
                    q_info = q
                    break

            if q_info: 
                break

        return q_info




    def get_content_questions(self, language, level, theme, subtheme=None, topic=None, period=None, difficulty=None):
        #language = language.lower().strip()

        # Special provisioning for Serbian cyrillic
        if language.lower().strip() == PageLanguage.RSC.value:
            language = PageLanguage.RS.value
        else:
            language = language.lower().strip()

        level = level.lower().strip()
        theme = theme.lower().strip()

        if language not in self.content.keys() or \
            level not in self.content[language].keys() or \
            theme not in self.content[language][level].keys():
            return {}

        questions = {}

        for k,v in self.content[language][level][theme].items():
            if k == "name" or k == "rank":
                continue

            if (not subtheme or subtheme == v["subtheme"]) and \
                (not topic or topic == v["topic"]) and \
                (not period or period == v["period"]) and \
                (not difficulty or difficulty == v["difficulty"]):

                # Add once questions that appear in multiple subthemes/topics/etc
                for q in v["questions"]:
                    if q["name"] not in questions.keys():
                        questions[q["name"]] = q

        return questions




    # Load SVG illustrations for all themes
    def load_icons(self):
        icons_dir = self.get_icons_disk("icons.*.json", is_json=True)
        icon_svgs = self.get_icons_disk("*.svg")
        self.icon_svgs = {}
        self.icons = {}

        for k,v in icon_svgs.items():
            self.icon_svgs[k.strip().lower()] = v 

        for k,v in icons_dir.items():
            lang = k.split(".")[-2]
            self.icons[lang] = {}
            for k1,v1 in v.items():
                v1 = v1.strip().lower()
                if v1 not in self.icon_svgs.keys():
                    self.icons[lang][k1.strip().lower()] = None
                    logging.error("Missing topic SVG in {}: {}".format(k, v1))
                else:
                    self.icons[lang][k1.strip().lower()] = v1

        try:
            icon_list = self.get_icons_disk("icons.json", is_json=True)
            for icon in icon_list.keys():
                try:
                    svg = self.get_icons_disk(icon_list[icon])
                    self.icons[icon.strip().lower()] = svg
                except:
                    self.icons[icon.strip().lower()] = ""
        except:
            self.icons = {}
            self.icon_svgs = {}


    def get_icon_svg(self, lang, subtheme):
        lang = lang.strip().lower()

        # Special provisioning for Serbian cyrillic
        if lang == PageLanguage.RSC.value:
            lang = PageLanguage.RS.value

        subtheme = subtheme.strip().lower()
        if lang not in self.icons.keys():
            return ""
        if subtheme not in self.icons[lang].keys():
            return ""
        svg_name = self.icons[lang][subtheme]
        if svg_name not in self.icon_svgs.keys():
            return ""
        return self.icon_svgs[svg_name]



    def load_all(self):
        self.load_dir(self.questions, self.questions_path)
        if not self.questions:
            logging.error("No questions found - did you set SHKOLA_REL_PATH correctly?")
            raise Exception("No questions found")

        self.load_dir(self.lists, self.lists_path)
        if not self.lists:
            logging.error("No lists found - did you set SHKOLA_REL_PATH correctly?")
            raise Exception("No lists found")

        #print("self.lists: {}".format(json.dumps(self.lists, indent=2)))
        #logging.debug("self.lists: {}".format(self.lists))

        self.create_content()
        #logging.debug("self.content: {}".format(json.dumps(self.content, indent=2)))

        self.load_icons()
        #logging.debug("self.icons: {}".format(json.dumps(self.icons, indent=2)))


        
    # def get_config(self):
    #     if self.preload:
    #         if "config" in self.questions.keys():
    #             return self.questions["config"]
    #         else:
    #             return {}
    #     else:
    #         if self.azure_blob is None:
    #             return self.get_config_disk()
    #         else:
    #             return self.get_config_blob()


    def get_question(self, q_id):
        if self.preload:
            return self.find_key(self.questions, q_id)
        else:
            if self.azure_blob is None:
                return self.get_question_disk(q_id)
            else:
                return self.get_question_blob(q_id)

    
    def get_all_question_ids(self, q_path, language):
        # Special provisioning for Serbian cyrillic
        if language == PageLanguage.RSC.value:
            language = PageLanguage.RS.value

        if self.preload:
            q_ids = []
            q = self.find_key(self.questions, q_path)
            all_keys = [q]
            paths = [""]
            while all_keys:
                l = all_keys.pop()
                p = paths.pop()
                try:
                    for k in l.keys():
                        if (k[0] == "q" and ("text."+language) in l[k].keys()):
                            q_ids.append(p + "/" + k)
                        if (k != "config" and k != "global" and k[0] != "q"):
                            all_keys.append(l[k])
                            paths.append(((p + "/") if p else "") + k)
                except:
                    logging.error("Error processing a question in path {}\n{}".format(
                        p, helpers.get_stack_trace()
                        ))
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
        # Special provisioning for Serbian cyrillic
        if language == PageLanguage.RSC.value:
            language = PageLanguage.RS.value

        if self.preload:
            l_ids = []
            l = self.find_key(self.lists, l_path)
            for k in l.keys():
                if language is None or (type(l[k]) is dict and "language" in l[k].keys() and l[k]["language"] == language):
                    l_ids.append(k)
            return l_ids
        else:
            if self.azure_blob is None:
                return self.get_all_lists_disk()
            else:
                return self.get_all_lists_blob()


