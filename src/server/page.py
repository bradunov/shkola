from server.types import PageParameters
from server.types import ResponseOperation
from server.types import PageOperation
from server.types import PageLanguage
from server.types import PageDesign

import server.context as context

import server.helpers as helpers
from server.user_db import GOOGLE_CLIENT_ID, GOOGLE_SITE_VERIFICATION, GOOGLE_TAG_MANAGER
from server.design import Design

#from server.timers import timer_section

import json
import logging


class Page(object):

    _default_template_params = {
        'title' : 'Shkola',
        'lang' : 'sr',
        'google_signin_client_id' : GOOGLE_CLIENT_ID,
        'google_site_verification' : GOOGLE_SITE_VERIFICATION,
        'google_tag_manager' : GOOGLE_TAG_MANAGER
    }


    # Explicitly called from edit mode
    def clear(self):
        self.page_params = PageParameters()
        self.question = None
        self.lines = []
        self.script_lines = []
        self.template_params = self._default_template_params.copy()
        self.template_params["title"] = self.app_data.title



    def __init__(self, app_data):
        self.app_data = app_data
        self.clear()

        self.userdb = app_data.userdb
        self.sessiondb = app_data.sessiondb

        # compatibility
        self.repository = app_data.repository

    def add_code(self, init_code = "", iter_code = "", text = ""):
        self.page_params.add_code(init_code, iter_code, text)

        
    def add_question(self, question):
        self.question = question


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
        
    # This breaks edit mode
    #@timer_section("page.render")
    def render(self):
        logging.debug("Render: loading template: '{}'".format(self.template_params["template_name"]))
        template = self.app_data.templates.get_template(self.template_params["template_name"])

        self.template_params["item_path"] = self.app_data.items_path

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

    def get_all_questions(self, language):
        l = self.app_data.repository.get_all_question_ids("", language)
        l.sort()
        return l


    def get_all_lists(self, language=None):
        l = self.app_data.repository.get_all_lists_ids("", language)
        l.sort()
        return l


    def get_language_list(self):
        return self.app_data.messages.keys()


    def get_messages(self, language=None):
        if language is None:
            language = PageLanguage.toStr(self.page_params.get_param("language"))
        if language in self.app_data.messages.keys():
            return self.app_data.messages[language]["messages"]
        return self.app_data.messages["rs"]["messages"]


    def get_language_details(self, language=None):
        if language is None:
            language = PageLanguage.toStr(self.page_params.get_param("language"))
        if language in self.app_data.messages.keys():
            return self.app_data.messages[language]
        return self.app_data.messages["rs"]


    def get_file_url(self, file):
        #return "item?url={}".format(file)
        return self.app_data.items_path + file


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
        
        
    def main(self, req, headers, timers, args):
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

            self.page_params.parse_edit(in_args=args)
            # self.page_params.print_params()
            return Design.main(self)


        with context.new_context(req, headers):
            context.c.timers = timers

            with self.sessiondb.init_session(req, headers) as session:
                context.c.session = session
                context.c.user = self.userdb.get_user(session.user_id())

                # Debug
                if False:
                    session.print()


                # Special ops to register results
                if "op" in args.keys() and args["op"] == PageOperation.toStr(PageOperation.REGISTER):
                    return self.register(args)

                # Special ops to register a user reported error
                elif "op" in args.keys() and args["op"] == PageOperation.toStr(PageOperation.FEEDBACK):
                    return self.feedback(args)

                else:
                    self.page_params.set_url(req.get_url())

                    # DEBUG (log.debug level required for the below to work)
                    # print("\n\nPRE PARSING:\n")
                    # #print("\n\nARGS: \n{}\n".format(json.dumps(args, indent=2)))
                    # print("\n\nARGS: \n{}\n".format(args))
                    # session.print()

                    # # Parameters stored in a session,
                    # # only updates passed in URL
                    # self.page_params.load_params()
                    self.page_params.parse(in_args=args, session=session)

                    # DEBUG (log.debug level required for the below to work)
                    # print("\n\nPOST PARSING:\n")
                    # self.page_params.print_params()
                    # session.print()

                    logging.debug("=== New /main request, op = {}".format(self.page_params.get_param('op')))
                    if False:
                        self.page_params.print_params()
                        logging.info("\n\n === New request: op={} - "
                                    "q_id={}, l_id={}, language={}, "
                                    "init_code={}, iter_code={}, text={}.\n\n".format(
                                        PageOperation.toStr(self.page_params.get_param("op")), 
                                        self.page_params.get_param("q_id"), self.page_params.get_param("l_id"), 
                                        PageLanguage.toStr(self.page_params.get_param("language")), 
                                        self.page_params.get_param("init_code"), 
                                        self.page_params.get_param("iter_code"), 
                                        self.page_params.get_param("text"),
                                    ))


                    log_json = {
                        "url": req.get_url()
                    }

                    if context.c.user and context.c.user.user_id:
                        log_json["user"] = context.c.user.user_id

                    if self.page_params.get_param("op"):
                        log_json["op"] = PageOperation.toStr(self.page_params.get_param("op"))

                    if self.page_params.get_param("q_id"):
                        log_json["q_id"] = self.page_params.get_param("q_id")

                    if self.page_params.get_param("l_id"):
                        log_json["l_id"] = self.page_params.get_param("l_id")


                    if self.page_params.get_param("language"):
                        log_json["language"] = PageLanguage.toStr(self.page_params.get_param("language"))
                    if self.page_params.get_param("year"):
                        log_json["year"] = self.page_params.get_param("year")
                    if self.page_params.get_param("theme"):
                        log_json["theme"] = self.page_params.get_param("theme")
                    if self.page_params.get_param("subtheme"):
                        log_json["subtheme"] = self.page_params.get_param("subtheme")
                    if self.page_params.get_param("topic"):
                        log_json["topic"] = self.page_params.get_param("topic")
                    if context.c.session.get("period"):
                        log_json["period"] = context.c.session.get("period")
                    if context.c.session.get("difficulty"):
                        log_json["difficulty"] = context.c.session.get("difficulty")
                    if self.page_params.get_param("skipped"):
                        log_json["skipped"] = self.page_params.get_param("skipped")


                    self.app_data.log_json("Access", log_json)


                    with context.c.timers.new_section("design.main"):
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

                # logging.debug("Register results: user_id={}, q_id={}, l_id={}, lang={}, response_type={}, " +
                #             "attempt={}, start={}, duration={}, correct={}, incorrect={}, questions=\"{}\"".format( 
                #             str(user_id), str(args["q_id"]), str(l_id), 
                #             str(language), str(args["response_type"]), str(args["attempt"]),
                #             str(args["start"]), str(int(args["now"]) - int(args["start"])),
                #             str(correct), str(incorrect), str(questions)))

                try:
                    self.app_data.storage.record_response(response)
                except Exception as err:
                    logging.error("Error submitting record response: {}\n{}".format(
                        err, helpers.get_stack_trace()
                        ))
            else:
                logging.error("Register operation with incomplete parameters: {}\n{}".format(
                    args, helpers.get_stack_trace()
                    ))

        else:
            # This is often hit by crawlers, so ignore
            logging.debug("Unknown register operation: {}".format(args["response_type"]))

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

            print_error = True
            # Do not alert about error "popup_closed_by_user" or "popup_blocked_by_browser" because we cannot do much about it
            try:
                error_msg_json = json.loads(args["comment"])
                if error_msg_json["error"].strip() == "popup_closed_by_user" or \
                   error_msg_json["error"].strip() == "popup_blocked_by_browser":
                    print_error = False
            except:
                pass

            if print_error:
                logging.error("GOOGLE_ERROR feedback: user_id={}, error={}".format(user_id, args["comment"]))

            try:
                self.app_data.storage.record_feedback(response)
            except Exception as err:
                logging.error("Error submitting google error feedback (user_id={}): {}".format(user_id, str(err)))


        elif "q_id" in args.keys():
            if "href" not in args.keys() or not args["href"] or args["href"] is None:
                href = ""
            else:
                href = args["href"]

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

            appVersion = str(args['appVersion']) if 'appVersion' in args.keys() else ""
            userAgent = str(args['userAgent']) if 'userAgent' in args.keys() else ""
            appName = str(args['appName']) if 'appName' in args.keys() else ""
            cpuClass = str(args['cpuClass']) if 'cpuClass' in args.keys() else ""
            platform = str(args['platform']) if 'platform' in args.keys() else ""
            plugins = str(args['plugins']) if 'plugins' in args.keys() else ""
            systemLanguage = str(args['systemLanguage']) if 'systemLanguage' in args.keys() else ""
            userLanguage = str(args['userLanguage']) if 'userLanguage' in args.keys() else ""
            pageHtml = str(args['html']) if 'html' in args.keys() else ""

            if 'type' in args.keys() and args["type"] == "JS_ERROR":
                logging.error("JS_ERROR feedback: user_id={}, href={}, q_id={}, l_id={}, language={}, "
                            "type={}, comment={}, random_vals={}, appVersion={}, userAgent={}, appName={}, "
                            "cpuClass={}, platform={}, plugins={}, systemLanguage={}, userLanguage={}, html={}".format( 
                            str(user_id), str(href), str(args["q_id"]), str(l_id), 
                            str(language), str(args["type"]), str(args["comment"]), random_vals, 
                            appVersion, userAgent, appName, cpuClass, platform, plugins, systemLanguage, userLanguage, pageHtml))
            else:
                logging.debug("Register results: user_id={}, href={}, q_id={}, l_id={}, language={}, type={}, comment={}, random_vals={}".format( 
                            str(user_id), str(href), str(args["q_id"]), str(l_id), 
                            str(language), str(args["type"]), str(args["comment"]), random_vals))

            try:
                self.app_data.storage.record_feedback(response)
            except Exception as err:
                logging.error("Error submitting record response (user_id={}): {}\n{}".format(
                    user_id, str(err), helpers.get_stack_trace()
                    ))
        else:
            # This is often hit by crawlers, so ignore
            logging.debug("Register operation with incomplete parameters (user_id={}): {}".format(user_id, args))

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

        # url = self.page_params.get_param("root") + \
        #     "?op={}".format(PageOperation.toStr(PageOperation.MENU_YEAR))

        url = self.page_params.create_url( \
            op = PageOperation.MENU_YEAR, 
            beta = True if self.page_params.get_param("beta") else None)

        if not ok:
            # If error, pass error message as url (to be printed for debug)
            url = s

        return url, ok


    def logout(self):
        logging.info("logout: closing session")
        context.c.user = None
        context.c.session.close()

        # url = self.page_params.get_param("root") + "?op={}".format(PageOperation.MENU_USER.value)

        url = self.page_params.create_url( \
            op = PageOperation.MENU_USER, 
            beta = True if self.page_params.get_param("beta") else None
        )

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

        # url = self.page_params.get_param("root") + \
        #     "?op={}".format(PageOperation.toStr(PageOperation.CONFIRM_ANON))

        url = self.page_params.create_url( \
            op = PageOperation.CONFIRM_ANON, 
            beta = True if self.page_params.get_param("beta") else None
        )

        return url
