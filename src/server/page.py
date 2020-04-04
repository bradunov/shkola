import os
import json

from server.types import *

from server.question import question
from server.qlist import qlist
from server.storage import get_storage
from server.helpers import *
from server.test import Test
from server.repository import Repository
from server.user_db import UserDB
from server.design import Design

from lupa import LuaRuntime
import logging




class page(object):
    q_id = ""
    l_id = ""
    language = ""
    init_code = ""
    iter_code = ""
    text = ""
    question = None
    page_name = ""
    user_id = ""
    user_agent = None
    user_language = None

    storage = None
    userdb = None
    mobile = False

    messages = {}                   # GUI messages in different languages

    menu = None                     # Page design

    object_id = 0
    lines = []
    script_lines = []
    on_loaded_script = ""
    title = ""

    rel_path = os.getenv('SHKOLA_REL_PATH')


    # use_azure_blob = True: use blob for question storage rather than the local disk
    # preload = True: fetch all questions in memory at start time (may be slow for a blob)
    def __init__(self, title="Shkola", rel_path=None, use_azure_blob=False, preload=True, mobile=False):
        if rel_path is not None:
            self.rel_path = rel_path

        if not self.rel_path:
            logging.exception("Please define SHKOLA_REL_PATH")
            exit(1)

        self.repository = Repository(self.rel_path, use_azure_blob, preload)
        self.storage = get_storage()
        self.title = title
        self.userdb = UserDB()
        self.mobile = mobile
        self.load_languages()

        
        
    def clear(self):
        self.q_id = ""
        self.language = ""
        self.init_code = ""
        self.iter_code = ""
        self.text = ""
        self.question = None
        self.lines = []
        self.script_lines = []



        
    def add_code(self, init_code = "", iter_code = "", text = ""):
        self.init_code = init_code
        self.iter_code = iter_code
        self.text = text
            

        
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
        



    def load_languages(self):
        local_path = self.rel_path + "/messages/"
        self.messages = dict()

        for (dirpath, dirnames, filenames) in os.walk(local_path):
            for f in filenames:
                if f[len(f)-5:len(f)] == ".json":
                    lang = json.load(open(dirpath + f, 'r'))
                    if lang["key"] in self.messages.keys():
                        logging.error("Language with key {} defined twice!".format(lang["key"]))
                    self.messages[lang["key"].lower()] = lang

    def get_language_list(self):
        return self.messages.keys()

    def get_messages(self, language=None):
        if language is None:
            language = self.language
        if language in self.messages.keys():
            return self.messages[language]
        return self.messages["uk"]




    def header(self, menu):
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
             <script src='""" + base_url(menu) + """?op=item&url=js/raphaeljs-infobox.js'></script>
             <!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script> -->

             <style type="text/css">
                div.space {
                    display:inline-block;
                    padding-left:6px;
                    padding-right:6px;
                }
            </style>
        """

        if menu == "mobile":
            head = head + """
             <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
             <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
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
    

    def footer(self, menu):
        return "</body>\n</html>\n"
        

    def scripts(self, menu):
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
    
    def render(self, menu):
        ret = ""
        ret = ret + self.header(menu)
        ret = ret + self.scripts(menu)
        for l in self.lines:
            #ret = ret + u''.join(l).encode('utf-8')
            ret = ret + str(l)
            
        ret = ret + "\n" + self.footer(menu)
        return ret





    def on_click(self, operation:Operation=None, url_next=None):
        ret_str = "cond = "
        if url_next is not None:
            # Only send results to server if next_url specified (i.e. we are in the test mode)
            ret_str = ret_str + "checkAll(\"{}\", \"{}\", \"{}\", \"{}\", \"{}\");".format(
                Operation.toStr(operation), base_url(self.menu), self.q_id, self.l_id, self.user_id)
            ret_str = ret_str + "if (cond) {window.location.replace(\"" + url_next + "\")}"
        else:
            ret_str = ret_str + "checkAll();"

        return ret_str




    def render_menu(self, menu_type = "full"):

        Design.render_menu(self)

        '''
        if menu_type == "mobile":
            self.render_menu_mobile()
        elif menu_type == "simple":
            self.render_menu_simple()
        else:
            self.render_menu_full()
        '''



            



    def parse_parameters(self, page_name, q_id=None, l_id=None, 
            language=None, user_id=None, user_agent=None, user_language=None):

        self.page_name = page_name

        if language is not None:
            self.language = language
        else:
            self.language = ""

        # If no question supplied, get the first one for the language
        if q_id is None or not q_id:
            if page_name == "test":
                self.q_id = ""
            else:
                self.q_id = self.get_all_questions(language)[0]
        else:
            self.q_id = q_id

        if l_id is None or not l_id:
            self.l_id = self.get_all_lists(language)[0]
        else:
            self.l_id = l_id
            
        if user_id is not None:
            self.user_id = user_id
        else:
            self.user_id = ""

        self.user_agent = user_agent
        self.user_language = user_language


        


        
    def main(self, op="view", q_id=None, l_id=None, language="rs", menu="full",
             user_id=None, init_code="", iter_code="", text="", 
             user_agent="", user_language=""):

        self.clear()
        self.parse_parameters(op, q_id, l_id, language, user_id)

        self.menu = menu

        if op == "view":
            q = question(self, self.user_id, self.rel_path)
            q.set_from_file_with_exception()
            self.add_question(q)
            self.render_simple_page(menu)
            return self.render(menu)
            
        elif op == "edit":
            q = question(self, self.user_id, self.rel_path)
            q.set_from_file_with_exception()
            self.add_question(q)
            self.add_code(q.get_init_code(), q.get_iter_code(), q.get_text())
            self.render_page(menu)
            return self.render(menu)
            
        elif op == "generate":
            self.add_code(init_code, iter_code, text)
            q = question(self, self.user_id, self.rel_path, 
                         init_code=init_code, iter_code=iter_code, text=text)
            self.add_question(q)
            self.render_page(menu)
            return self.render(menu)

        elif op == "list":
            self.render_menu(menu)
            ql = qlist(self, self.user_id, self.rel_path)
            ql.render_all_questions()
            return self.render(menu)

        elif op == "test":
            self.render_menu(menu)
            test = Test(self, self.user_id, self.rel_path, self.mobile)
            next_question_url = test.render_next_questions()
            Design_test.add_buttons(page, next_question_url)
            return self.render(menu)

        else:
            return "ERROR - operation {} not known".format(op)



    # args is in format returned by urllib.parse.parse_qs
    def register(self, args):
        correct = 0
        incorrect = 0
        questions = ""

        user_id = None

        if "user_id" in args.keys() and args["user_id"][0]:
            user_id = args["user_id"][0]
        else:
            # DEBUG: we log everything for stats, as unknown
            user_id = "UNKNOWN"

        if "q_id" in args.keys() and "now" in args.keys() and user_id is not None:
            if "l_id" not in args.keys() or not args["l_id"][0] or args["l_id"][0] is None:
                l_id = ""
            else:
                l_id = args["l_id"][0]
                

            for key, v in args.items():
                value = v[0]
                if key[0:5] == "q_res":
                    questions = questions + key + "=" + value + ","
                    if value == "true":
                        correct = correct + 1
                    else:
                        incorrect = incorrect + 1
                        
            response = {"user_id" : user_id,
                        "question_id": args["q_id"][0],
                        "list_id": l_id,
                        "response_type": args["response_type"][0],
                        "attempt": args["attempt"][0],
                        "time": args["start"][0],
                        "duration": int(args["now"][0]) - int(args["start"][0]),
                        "correct": correct,
                        "incorrect": incorrect,
                        "questions": questions}

            logging.debug("Register results: user_id=%s, q_id=%s, l_id=%s, response_type=%s, " +
                        "attempt=%s, start=%s, duration=%s, correct=%s, incorrect=%s, questions=\"%s\"", 
                        str(user_id), str(args["q_id"][0]), 
                        str(l_id), str(args["response_type"][0]), str(args["attempt"][0]),
                        str(args["start"][0]), str(int(args["now"][0]) - int(args["start"][0])),
                        str(correct), str(incorrect), str(questions))

            try:
                self.storage.record_response(response)
            except Exception as err:
                logging.error("Error submitting record response: {}".format(str(err)))




    



    def logout(self, login_return=None):
        return self.main(login_return["page_name"], login_return["q_id"], login_return["l_id"], 
                         login_return["lang"], login_return["menu"])




    def login_test(self, user_id=None, login_return=None, remote_ip="", user_agent="", user_language=""):
        login_return = decode_dict(login_return)

        if user_id is None:
            logging.debug("Login test user %s, %s, %s, %s", 'test', 'test', str(remote_ip), str(user_agent))
            self.userdb.session_login_and_update_user('local', 'test',
                                               name='test',
                                               email='test',
                                               remote_ip=remote_ip,
                                               user_agent=user_agent,
                                               user_language=user_language)
        else:
            logging.debug("Login test user %s, %s, %s, %s", user_id, user_id, str(remote_ip), str(user_agent))
            self.userdb.session_login_and_update_user('local', user_id,
                                               name=user_id,
                                               email=user_id,
                                               remote_ip=remote_ip,
                                               user_agent=user_agent,
                                               user_language=user_language)

        full_user_id = "local:" + user_id
        return self.main(login_return["page_name"], login_return["q_id"], login_return["l_id"], 
                         login_return["lang"], login_return["menu"], full_user_id)


