import os
import os.path
import json
import jinja2

from server.types import PageParameters
from server.types import ResponseOperation
from server.types import PageOperation
from server.types import PageLanguage
from server.types import PageDesign

import server.context as context

import server.storage
from server.repository import Repository
from server.user_db import UserDB, GOOGLE_CLIENT_ID, GOOGLE_SITE_VERIFICATION
from server.design import Design
from server.session import SessionDB

import logging


class Page(object):
    page_params = None

    question = None
    storage = None
    userdb = None

    messages = {}                   # GUI messages in different languages


    object_id = 0                   # Unique ID counter for all HTML objects on the page
    lines = []                      # HTML body lines
    script_lines = []               # HTML header lines
    on_loaded_script = ""           # JS code to be run on page load
    title = ""                      # Web site title in the HTML header


    _default_template_params = {
        'title' : 'Shkola',
        'google_signin_client_id' : GOOGLE_CLIENT_ID,
        'google_site_verification' : GOOGLE_SITE_VERIFICATION
    }



    # use_azure_blob = True: use blob for question storage rather than the local disk
    # preload = True: fetch all questions in memory at start time (may be slow for a blob)
    def __init__(self, title="tatamata.org", rel_path=None, template_path=None, use_azure_blob=False, preload=True):

        # Set logging formater
        # See this for attributes: https://docs.python.org/3/library/logging.html#logrecord-attributes
        # Note: the usual python way through basicConfig won't work as Azure Functions mess up with it
        # This is a possible way. See: https://stackoverflow.com/a/57896847
        # The loop is taken from Logger.callHandlers() implementation
        # Note: logging.Logger.root should be the root (no parent) but I leave the loop just in case AF change
        #formatter    = logging.Formatter('%(pathname)s:%(funcName)s(%(lineno)d) : %(message)s\n')
        formatter    = logging.Formatter('%(filename)s:%(funcName)s(%(lineno)d) : %(message)s\n')
        logger = logging.Logger.root
        while logger:
            for hdlr in logger.handlers:
                hdlr.setFormatter(formatter)
            if not logger.propagate:
                logger = None    #break out
            else:
                logger = logger.parent


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
            template_path = os.path.join(self.rel_path, 'templates')

        self.template_path = os.path.abspath(template_path)

        logging.info("Paths: template_path: {}".format(self.template_path))
        logging.info("Paths: working dir: {}".format(os.getcwd()))

        self.page_params = PageParameters()
        self.repository = Repository(self.rel_path, use_azure_blob, preload)
        self.storage = server.storage.get_storage()
        self.title = title
        self.userdb = UserDB(self.storage)
        self.sessiondb = SessionDB(self.storage)
        self.load_languages()

        file_loader = jinja2.FileSystemLoader(self.template_path)
        self.templates = jinja2.Environment(loader=file_loader)
        self.template_params = self._default_template_params
        self.template_params["title"] = self.title



    def clear(self):
        self.page_params = PageParameters()
        self.question = None
        self.lines = []
        self.script_lines = []
        self.clear_template_params()


    def clear_template_params(self):
        self.template_params = self._default_template_params
        self.template_params["title"] = self.title


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

    # def get_lines(self):
    #     return self.lines
        
    # def add_on_loaded_script_lines(self, code):
    #     self.on_loaded_script = self.on_loaded_script + code
        
    def render(self):
        logging.debug("Render: loading template: '{}'".format(self.template_params["template_name"]))
        template = self.templates.get_template(self.template_params["template_name"])

        # Add question as a form parameter
        self.template_params["question"] = ""

        for l in self.script_lines:
            self.template_params["question"] = self.template_params["question"] + l + "\n"

        for l in self.lines:
            self.template_params["question"] = self.template_params["question"] + str(l)

        return template.render(template_params=self.template_params)

        # #ret = ret + self.header()
        # ret = ret + self.scripts()
        # for l in self.lines:
        #     #ret = ret + u''.join(l).encode('utf-8')
        #     ret = ret + str(l)
            
        # #ret = ret + "\n" + self.footer()
        # return ret







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
            language = PageLanguage.toStr(self.page_params.get_param("language"))
        if language in self.messages.keys():
            return self.messages[language]["messages"]
        return self.messages["rs"]["messages"]

    def get_language_details(self, language=None):
        if language is None:
            language = PageLanguage.toStr(self.page_params.get_param("language"))
        if language in self.messages.keys():
            return self.messages[language]
        return self.messages["rs"]

    def get_file_url(self, file):
        return "item?url={}".format(file)

    def get_default_question(self):
        return self.get_all_questions(PageLanguage.toStr(self.page_params.get_param("language")))[0]

    def get_default_list(self):
        return self.get_all_lists(PageLanguage.toStr(self.page_params.get_param("language")))[0]





    #################################################
    # Standard page elements

    # def header(self):
    #     head = "<!DOCTYPE html>"
    #     head = head + "<html>\n"
    #     head = head + "  <head>\n"
    #     head = head + "    <title>{}</title>\n".format(self.title)
    #     head = head + "    <meta name='viewport' content='width=device-width, initial-scale=1'>\n"
    #     head = head + '    <meta name="google-signin-client_id" content="{}">\n'.format(GOOGLE_CLIENT_ID)
    #     head = head + '    <meta name="google-site-verification" content="{}" />\n'.format(GOOGLE_SITE_VERIFICATION)
    #     head = head + """
    #          <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css"> -->
    #          <script type="text/javascript" async
    #            src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML" async>
    #          </script>
    #          <script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"> </script>
    #          <script src="https://apis.google.com/js/platform.js" async defer></script>
    #          <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    #          <script src='""" + self.get_file_url("js/raphaeljs-infobox.js") + """'></script>
    #          <!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script> -->

    #          <style type="text/css">
    #             div.space {
    #                 display:inline-block;
    #                 padding-left:6px;
    #                 padding-right:6px;
    #             }
    #         </style>
    #     """
            

    #     if self.on_loaded_script:
    #         head = head + """
    #           <script type="text/javascript">
    #             function page_init() {
    #               """ + self.on_loaded_script + """
    #             }
    #             window.onload = page_init;
    #           </script>
    #         """

    #     # Add our small standard library
    #     head = head + """
    #           <script type="text/javascript">
    #           math = {}
    #           math.eq = function(x, y, precision) { if (typeof(precision)==='undefined') precision = 0.00001; return Math.abs(x-y) < precision; }
    #           </script>
    #     """

    #     head = head + "  </head>\n"
    #     head = head + "  <body>\n"

    #     return head
    

    # def footer(self):
    #     return "</body>\n</html>\n"
        
    



        
    def main(self, req, headers, args):
        self.clear()

        logging.debug("\n\nMAIN ARGS: {}\n\n".format(args))        

        if headers is None or req is None:
            # Cherrypy - ignore cookies

            # Special ops to register a user reported error
            # DEBUG: This is only for testing and may not implement the full feedback functionality
            if "op" in args.keys() and args["op"] == PageOperation.toStr(PageOperation.FEEDBACK):
                return self.feedback(args)

            self.page_params.parse(args, legacy=True)
            return Design.main(self)

        # No caching
        headers.set_no_store()

        if args["root"] == "edit":
            # Old style EDIT page with parameter passing in GET URL

            # DEBUG: these two special ops are for testing and are not fully functional in edit mode
            # Special ops to register results
            if "op" in args.keys() and args["op"] == PageOperation.toStr(PageOperation.REGISTER):
                return self.register(args)

            # Special ops to register a user reported error
            elif "op" in args.keys() and args["op"] == PageOperation.toStr(PageOperation.FEEDBACK):
                return self.feedback(args)

            self.page_params.parse(in_args=args, legacy=True)
            # self.page_params.print_params()
            return Design.main(self)


        with context.new_context(req, headers):
            with self.sessiondb.init_session(req, headers) as session:
                context.c.session = session
                context.c.user = self.userdb.get_user(session.user_id())

                # Debug
                if True:
                    session.print()

                # Page counter (for testing)
                session.set('page_counter', session.get('page_counter', 0) + 1)

                # Special ops to register results
                if "op" in args.keys() and args["op"] == PageOperation.toStr(PageOperation.REGISTER):
                    return self.register(args)

                # Special ops to register a user reported error
                elif "op" in args.keys() and args["op"] == PageOperation.toStr(PageOperation.FEEDBACK):
                    return self.feedback(args)

                else:
                    self.page_params.set_url(req.get_url())

                    # Parameters stored in a session,
                    # only updates passed in URL
                    self.page_params.load_params()
                    self.page_params.parse(in_args=args)

                    logging.debug("=== New /main request, op = {}".format(self.page_params.get_param('op')))
                    if False:
                        self.page_params.print_params()
                        logging.info("\n\n === New request: op={} <design={}, mobile={}> - "
                                    "q_id={}, l_id={}, language={}, "
                                    "init_code={}, iter_code={}, text={}.\n\n".format(
                                        PageOperation.toStr(self.page_params.get_param("op")), 
                                        PageDesign.toStr(self.page_params.get_param("design")),
                                        self.page_params.get_param("mobile"), 
                                        self.page_params.get_param("q_id"), self.page_params.get_param("l_id"), 
                                        PageLanguage.toStr(self.page_params.get_param("language")), 
                                        self.page_params.get_param("init_code"), 
                                        self.page_params.get_param("iter_code"), 
                                        self.page_params.get_param("text"),
                                    ))


                    return Design.main(self)


    # args is in format returned by urllib.parse.parse_qs
    def register(self, args):

        # TBD: we record UNKNOWN for testing only. 
        # In deployment we should ignore registering requests from UNKNOWN
        # (and not even send them from the page)
        try:
            user_id = context.c.user.user_id if context.c.user else "UNKNOWN"
        except:
            user_id = "UNKNOWN"
            pass


        if args["response_type"] == ResponseOperation.toStr(ResponseOperation.SUBMIT) or \
           args["response_type"] == ResponseOperation.toStr(ResponseOperation.SKIP):

            # Record answer to the database

            correct = 0
            incorrect = 0
            questions = ""


            if "q_id" in args.keys() and "now" in args.keys():
                if "l_id" not in args.keys() or not args["l_id"] or args["l_id"] is None:
                    l_id = ""
                else:
                    l_id = args["l_id"]
                    
                if "language" not in args.keys() or not args["language"] or args["language"] is None:
                    language = ""
                else:
                    language = args["language"]

                # for key, v in args.items():
                #     value = v
                #     if key[0:5] == "q_res":
                #         questions = questions + key + "=" + value + ","
                #         if value == "true":
                #             correct = correct + 1
                #         else:
                #             incorrect = incorrect + 1

                if 'detailed' in args.keys():
                    for k, v in args['detailed'].items():
                        if v == "true":
                            correct = correct + 1
                        else:
                            incorrect = incorrect + 1
                questions = str(args['detailed'])

                shown_solution = False
                if "shown_solutions" in args.keys() and type(args["shown_solutions"]) == bool:
                    shown_solution = args["shown_solutions"]

                hist = context.c.session.get("history")
                if (len(hist) > 0 and (hist[-1]["correct"] == 0 or correct > hist[-1]["correct"])) and not shown_solution:
                    hist[-1]["correct"] = correct
                    hist[-1]["incorrect"] = incorrect
                context.c.session.set("history", hist)


                response = {"user_id" : user_id,
                            "question_id": args["q_id"],
                            "list_id": l_id,
                            "language" : language,
                            "test_id": args["test_id"],
                            "test_order": args["test_order"],
                            "response_type": args["response_type"],
                            "attempt": args["attempt"],
                            "shown_solutions": args["shown_solutions"],
                            "time": args["start"],
                            "duration": int(args["now"]) - int(args["start"]),
                            "correct": correct,
                            "incorrect": incorrect,
                            "questions": questions}

                logging.debug("Register results: user_id=%s, q_id=%s, l_id=%s, lang=%s, response_type=%s, " +
                            "attempt=%s, start=%s, duration=%s, correct=%s, incorrect=%s, questions=\"%s\"", 
                            str(user_id), str(args["q_id"]), str(l_id), 
                            str(language), str(args["response_type"]), str(args["attempt"]),
                            str(args["start"]), str(int(args["now"]) - int(args["start"])),
                            str(correct), str(incorrect), str(questions))

                try:
                    self.storage.record_response(response)
                except Exception as err:
                    logging.error("Error submitting record response: {}".format(err))
            else:
                logging.error("Register operation with incomplete parameters: {}".format(args))

        else:
            logging.error("Unknown register operation: {}".format(args["response_type"]))

        return "ABC"






    # args is in format returned by urllib.parse.parse_qs
    def feedback(self, args):

        # Record feedback to the database
        try:
            user_id = context.c.user.user_id if context.c.user else "UNKNOWN"
        except:
            user_id = "UNKNOWN"
            pass

        if 'type' in args.keys() and args["type"] == "GOOGLE_ERROR":
            response = {"user_id" : user_id,
                        "question_id": "GOOGLE_ERROR",
                        "list_id": "",
                        "test_id": "",
                        "test_order": "",
                        "type": "GOOGLE_ERROR",
                        "comment": args['comment'] if 'comment' in args.keys() else '',
                        "shown_solutions": "",
                        "random_vals": ""}

            logging.error("GOOGLE_ERROR feedback: user_id=%s, error=%s", str(user_id), str(args["comment"]))

            try:
                self.storage.record_feedback(response)
            except Exception as err:
                logging.error("Error submitting google error feedback: {}".format(str(err)))


        elif "q_id" in args.keys():
            if "l_id" not in args.keys() or not args["l_id"] or args["l_id"] is None:
                l_id = ""
            else:
                l_id = args["l_id"]
                
            if "language" not in args.keys() or not args["language"] or args["language"] is None:
                language = ""
            else:
                language = args["language"]

            if "rand_val" in args.keys():
                random_vals = str(args['rand_val'])
            else:
                random_vals = ""

            response = {"user_id" : user_id,
                        "question_id": args["q_id"],
                        "list_id": l_id,
                        "language": language,
                        "test_id": args["test_id"] if "test_id" in args.keys() else "",
                        "test_order": args["test_order"] if "test_order" in args.keys() else "",
                        "type": args["type"] if "type" in args.keys() else "",
                        "comment": args["comment"] if "comment" in args.keys() else "",
                        "shown_solutions": args["shown_solutions"] if "shown_solutions" in args.keys() else "",
                        "random_vals": random_vals}

            if 'type' in args.keys() and args["type"] == "JS_ERROR":
                logging.error("JS_ERROR feedback: user_id=%s, q_id=%s, l_id=%s, language=%s, type=%s, comment=%s, random_vals=%s", 
                            str(user_id), str(args["q_id"]), str(l_id), 
                            str(language), str(args["type"]), str(args["comment"]), random_vals)
            else:
                logging.debug("Register results: user_id=%s, q_id=%s, l_id=%s, language=%s, type=%s, comment=%s, random_vals=%s", 
                            str(user_id), str(args["q_id"]), str(l_id), 
                            str(language), str(args["type"]), str(args["comment"]), random_vals)

            try:
                self.storage.record_feedback(response)
            except Exception as err:
                logging.error("Error submitting record response: {}".format(str(err)))
        else:
            logging.error("Register operation with incomplete parameters: {}".format(args))

        return "ABC"





    def login_google(self):
        id_token = None
        ok = False

        logging.info("*** login google called")

        if not context.c.user:
            pdict = context.c.request.get_post_data()

            id_token = pdict.get('id_token', None)
            if id_token:
                ok, s = self.userdb.login_google(id_token)
            else:
                logging.info("login_google(): no id_token")

        else:
            ok = True
            logging.info("login_google(): User already logged in")

        url = self.page_params.get_param("root") + \
            "?op={}".format(PageOperation.toStr(PageOperation.MENU_YEAR))

        if not ok:
            # If error, pass error message as url (to be printed for debug)
            url = s

        return url, ok


    def logout(self):
        context.c.user = None
        context.c.session.close()

        url = self.page_params.get_param("root") + "?op={}".format(PageOperation.MENU_USER.value)
        return url

    # Debug function, not used
    # def login_test(self) -> str:
    #     if not context.c.user:
    #         user_id = context.c.request.param_get("user_id")

    #         email = None
    #         user_language = "rs"

    #         if not user_id:
    #             user_id = 'UNKNOWN'
    #             name = 'UNKNOWN'
    #         else:
    #             name = user_id

    #         logging.debug("Login test user %s", user_id)
    #         self.userdb.login_test(user_id, name, email, user_language)
    #     else:
    #         logging.info("login(): User already logged in")

    #     url = self.page_params.get_param("root") + \
    #         "?op={}".format(PageOperation.toStr(PageOperation.MENU_YEAR))

    #     return url




    def login_anon(self) -> str:
        if not context.c.user:
            user_id = 'UNKNOWN'
            name = 'UNKNOWN'
            email = None
            user_language = "rs"

            logging.debug("Login anonymous user UNKNOWN")
            self.userdb.login_test(user_id, name, email, user_language)
        else:
            logging.info("login(): User already logged in")

        url = self.page_params.get_param("root") + \
            "?op={}".format(PageOperation.toStr(PageOperation.CONFIRM_ANON))

        return url
