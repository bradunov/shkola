import os
import json

from server.types import PageParameters
from server.types import ResponseOperation
from server.types import PageUserID
from server.types import PageOperation
from server.types import PageLanguage
from server.types import PageDesign
from server.types import PageParameterParsingError

import server.storage
from server.repository import Repository
from server.user_db import UserDB
from server.design import Design

import logging




class Page(object):
    page_params = PageParameters()

    question = None
    storage = None
    userdb = None

    messages = {}                   # GUI messages in different languages


    object_id = 0                   # Unique ID counter for all HTML objects on the page
    lines = []                      # HTML body lines
    script_lines = []               # HTML header lines
    on_loaded_script = ""           # JS code to be run on page load
    title = ""                      # Web site title in the HTML header


    # use_azure_blob = True: use blob for question storage rather than the local disk
    # preload = True: fetch all questions in memory at start time (may be slow for a blob)
    def __init__(self, title="Shkola", rel_path=None, use_azure_blob=False, preload=True):
        if not rel_path is None:
            self.rel_path = rel_path
        else:
            try:
                self.rel_path = os.getenv('SHKOLA_REL_PATH')                    
            except:
                pass
            if self.rel_path is None:
                self.rel_path = "../.."

        if not self.rel_path:
            logging.exception("Please define SHKOLA_REL_PATH")
            exit(1)

        self.repository = Repository(self.rel_path, use_azure_blob, preload)
        self.storage = server.storage.get_storage()
        self.title = title
        self.userdb = UserDB()
        self.load_languages()

        
        
    def clear(self):
        self.page_params = PageParameters()
        self.question = None
        self.lines = []
        self.script_lines = []


        
    def add_code(self, init_code = "", iter_code = "", text = ""):
        self.page_params.add_code(init_code, iter_code, text)
            

        
    def add_question(self, question):
        self.question = question



    def get_all_questions(self, language):
        l = self.repository.get_all_question_ids("", language)
        l.sort()
        return l

    def get_all_lists(self, language=None):
        l = self.repository.get_all_lists_ids("", language)
        l.sort()
        return l




    #################################################
    # HTML generation methods

    def add_script_lines(self, lines, *params):
        if lines is not None:
            self.script_lines.append(lines.format(*params) if params else lines)
        

    def add_lines(self, lines, *params):
        # For some reason Lua passes None after every call to library
        if lines is not None:
            self.lines.append(lines.format(*params) if params else lines)

    def get_lines(self):
        return self.lines
        
    def add_on_loaded_script_lines(self, code):
        self.on_loaded_script = self.on_loaded_script + code
        
    def on_click(self, operation:ResponseOperation=None, url_next=None, record=False, quoted=True):
        if record:
            # Only send results to server if next_url specified (i.e. we are in the test mode)
            ret_str = "cond = checkAll(\"{}\", \"{}\", \"{}\", \"{}\", \"{}\");".format(
                ResponseOperation.toStr(operation), self.page_params.root, self.page_params.q_id, 
                self.page_params.l_id, PageUserID.toStr(self.page_params.user_id))
        else:
            ret_str = "cond = checkAll();"

        if url_next is not None:
            if operation == ResponseOperation.SUBMIT:
                ret_str = ret_str + "if (cond) "
            if quoted:
                ret_str = ret_str + " {window.location.replace(\"" + url_next + "\");}"
            else:
                ret_str = ret_str + " {window.location.replace(" + url_next + ");}"

        return ret_str

    def render(self):
        ret = ""
        ret = ret + self.header()
        ret = ret + self.scripts()
        for l in self.lines:
            #ret = ret + u''.join(l).encode('utf-8')
            ret = ret + str(l)
            
        ret = ret + "\n" + self.footer()
        return ret







    #################################################
    # Language support

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

    def get_language_list(self):
        return self.messages.keys()

    def get_messages(self, language=None):
        if language is None:
            language = PageLanguage.toStr(self.page_params.language)
        if language in self.messages.keys():
            return self.messages[language]
        return self.messages["uk"]

    def get_file_url(self, file):
        return "item?url={}".format(file)

    def get_default_question(self):
        return self.get_all_questions(PageLanguage.toStr(self.page_params.language))[0]

    def get_default_list(self):
        return self.get_all_lists(PageLanguage.toStr(self.page_params.language))[0]





    #################################################
    # Standard page elements

    def header(self):
        head = "<!DOCTYPE html>"
        head = head + "<html>\n"
        head = head + "  <head>\n"
        head = head + "    <title>{}</title>\n".format(self.title)
        head = head + "    <meta name='viewport' content='width=device-width, initial-scale=1'>\n"
        head = head + '    <meta name="google-signin-client_id" content="221670444651-i7ock63nksbnqeag7l3s2u0nf6jdb2bk.apps.googleusercontent.com">'
        head = head + """
             <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css"> -->
             <script type="text/javascript" async
               src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML" async>
             </script>
             <script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"> </script>
             <script src="https://apis.google.com/js/platform.js" async defer></script>
             <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
             <script src='""" + self.get_file_url("js/raphaeljs-infobox.js") + """'></script>
             <!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script> -->

             <style type="text/css">
                div.space {
                    display:inline-block;
                    padding-left:6px;
                    padding-right:6px;
                }
            </style>
        """
            

        if self.on_loaded_script:
            head = head + """
              <script type="text/javascript">
                function page_init() {
                  """ + self.on_loaded_script + """
                }
                window.onload = page_init;
              </script>
            """

        # Add our small standard library
        head = head + """
              <script type="text/javascript">
              math = {}
              math.eq = function(x, y, precision) { if (typeof(precision)==='undefined') precision = 0.00001; return Math.abs(x-y) < precision; }
              </script>
        """

        head = head + "  </head>\n"
        head = head + "  <body>\n"

        return head
    

    def footer(self):
        return "</body>\n</html>\n"
        

    def scripts(self):
        ret = """
        <script type = "text/javascript">
        function setError(id) {
          document.getElementById(id).style.border = "3px solid red";
        }
        function setOK(id) {
          document.getElementById(id).style.border = "3px solid green";
        }
        function clearAllWBorder(id) {
          document.getElementById(id).style.border = "1px solid #ccc";
        }
        function clearAllNoBorder(id) {
          document.getElementById(id).style.border = "0px solid white";
        }
        </script>  
        """    
        for l in self.script_lines:
            ret = ret + l + "\n"
        return ret
    



        
    def main(self, args):

        # Special ops to register results
        if "op" in args.keys() and args["op"] == PageOperation.toStr(PageOperation.REGISTER):
            return self.register(args)


        self.clear()
        self.page_params.parse(args, self)


        logging.info("New request: op={} <design={}, mobile={}> - "
                    "q_id={}, l_id={}, language={}, user_id={}, "
                    "correct={}, incorrect={}, init_code={}, iter_code={}, text={}, "
                    "remote_ip={}, user_agent={}, user_language={}, menu_state={}.".format(
                        PageOperation.toStr(self.page_params.op), 
                        PageDesign.toStr(self.page_params.design),
                        self.page_params.mobile, 
                        self.page_params.q_id, self.page_params.l_id, 
                        PageLanguage.toStr(self.page_params.language), 
                        PageUserID.toStr(self.page_params.user_id), 
                        self.page_params.correct, self.page_params.incorrect, 
                        self.page_params.init_code, self.page_params.iter_code, self.page_params.text,
                        self.page_params.user_param.remote_ip, 
                        self.page_params.user_param.user_agent, 
                        self.page_params.user_param.user_laguage,
                        self.page_params.menu_state))


        return Design.main(self)





    # args is in format returned by urllib.parse.parse_qs
    def register(self, args):
        correct = 0
        incorrect = 0
        questions = ""

        user_id = None

        if "user_id" in args.keys() and args["user_id"]:
            user_id = args["user_id"]
        else:
            # DEBUG: we log everything for stats, as unknown
            user_id = "UNKNOWN"

        if "q_id" in args.keys() and "now" in args.keys() and user_id is not None:
            if "l_id" not in args.keys() or not args["l_id"] or args["l_id"] is None:
                l_id = ""
            else:
                l_id = args["l_id"]
                

            for key, v in args.items():
                value = v
                if key[0:5] == "q_res":
                    questions = questions + key + "=" + value + ","
                    if value == "true":
                        correct = correct + 1
                    else:
                        incorrect = incorrect + 1
                        
            response = {"user_id" : user_id,
                        "question_id": args["q_id"],
                        "list_id": l_id,
                        "response_type": args["response_type"],
                        "attempt": args["attempt"],
                        "time": args["start"],
                        "duration": int(args["now"]) - int(args["start"]),
                        "correct": correct,
                        "incorrect": incorrect,
                        "questions": questions}

            logging.debug("Register results: user_id=%s, q_id=%s, l_id=%s, response_type=%s, " +
                        "attempt=%s, start=%s, duration=%s, correct=%s, incorrect=%s, questions=\"%s\"", 
                        str(user_id), str(args["q_id"]), 
                        str(l_id), str(args["response_type"]), str(args["attempt"]),
                        str(args["start"]), str(int(args["now"]) - int(args["start"])),
                        str(correct), str(incorrect), str(questions))

            try:
                self.storage.record_response(response)
            except Exception as err:
                logging.error("Error submitting record response: {}".format(str(err)))




    

# Just redirect with an empty user

#    def logout(self, login_return=None):
#        return self.main(login_return["page_name"], login_return["q_id"], login_return["l_id"], 
#                         login_return["lang"], login_return["menu"])




    def login(self) -> PageOperation:

        user_id = PageUserID.toStr(self.page_params.user_id)

        # Logint and register user
        if user_id is None:
            logging.debug("Login test user %s, %s, %s, %s", 'test', 'test', 
                str(self.page_params.user_param.remote_ip), 
                str(self.page_params.user_param.user_agent))
            self.userdb.session_login_and_update_user('local', 'test',
                                               name='test',
                                               email='test',
                                               remote_ip=self.page_params.user_param.remote_ip,
                                               user_agent=self.page_params.user_param.user_agent,
                                               user_language=self.page_params.user_param.user_language)
        else:
            logging.debug("Login test user %s, %s, %s, %s", user_id, user_id, 
                str(self.page_params.user_param.remote_ip), 
                str(self.page_params.user_param.user_agent))
            self.userdb.session_login_and_update_user('local', user_id,
                                               name=self.page_params.user_id.toStr(),
                                               email=self.page_params.user_id.toStr(),
                                               remote_ip=self.page_params.user_param.remote_ip,
                                               user_agent=self.page_params.user_param.user_agent,
                                               user_language=self.page_params.user_param.user_language)

        if "orig_op" not in self.page_params.all_state.keys():
            raise PageParameterParsingError
        
        return PageOperation.fromStr(self.page_params.all_state["orig_op"])

