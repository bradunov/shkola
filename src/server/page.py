import os
import json


from server.question import question
from server.qlist import qlist
from server.storage import get_storage
from server.helpers import *
from server.test import Test
from server.content import Content
from server.repository import Repository
from server.user_db import UserDB

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
    storage = None
    userdb = None
    mobile = False

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

    def get_all_lists(self):
        l = self.repository.get_all_lists_ids("")
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
             <script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"> </script>
             <script src="https://apis.google.com/js/platform.js" async defer></script>
             <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
             <script src="item?url=src/js/raphaeljs-infobox.js"></script>
             <!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script> -->
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
    
    def render(self):
        ret = ""
        ret = ret + self.header()
        ret = ret + self.scripts()
        for l in self.lines:
            #ret = ret + u''.join(l).encode('utf-8')
            ret = ret + str(l)
            
        ret = ret + "\n" + self.footer()
        return ret





    

    ########
    # Temporary version, doesn't work with Google Auth (yet)
    ########
    # Temporary version, doesn't work with Google Auth (yet)
    
    def get_login_header(self):
        login_str = ""

        # self.page.add_lines("<div>{}</div>", cherrypy.request.path_info)
        if self.mobile:
            menu = "simple"
        else:
            menu = "full"
            
        login_return = {}
        login_return["page_name"] = self.page_name
        login_return["q_id"] = self.q_id
        login_return["l_id"] = self.l_id
        login_return["lang"] = self.language
        login_return["user_id"] = self.user_id
        login_return["menu"] = menu
        login_return["js"] = False
        login_return = encode_dict(login_return)

        if False: #cherrypy.config.get("use_google_auth"):
            # Currently doesn't work
            if 'user_id' not in s:
                login_str = '<div class="g-signin2" style="margin-bottom:0px" data-onsuccess="onSignIn"></div>\n'
                url = cherrypy.url('/login_google')
                login_str = login_str + """
                <script>
                function onSignIn(googleUser) {
                    console.log('Google sign in');
                    var profile = googleUser.getBasicProfile();
                    var id_token = googleUser.getAuthResponse().id_token;
                    console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
                    console.log('Name: ' + profile.getName());
                    console.log('Image URL: ' + profile.getImageUrl());
                    console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.

                    var xhr = new XMLHttpRequest();
                    xhr.open('POST', '""" + url + """');
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xhr.onload = function() {
                      console.log('Sign in response: ' + xhr.responseText);
                      if (xhr.responseText == 'OK') {
                          location.reload();
                      }
                    };
                    xhr.send('id_token=' + id_token);
                }
                </script>
                """
        else:
            # login_str = "<select id='sel_user_id' name='sel_user_id' " + \
            #             "onchange='window.location.replace(\"login_test?" + "login_return=" + \
            #             login_return + "&user_id=\" + this.value)'>n"
           
            login_str = "<select id='sel_user_id' name='sel_user_id' " + \
                        "onchange='window.location.replace(\"main?op=login_test&" + "login_return=" + \
                        login_return + "&user_id=\" + this.value)'>n"


            if self.user_id is None or not self.user_id:
                login_str = login_str + "<option value='NONE' SELECTED></option>"

            for i in range(1,4):
                sel_user = format("Korisnik{}").format(i)
                selected = ""
                if self.user_id is not None and self.user_id == "local:"+sel_user:
                    selected = "SELECTED"

                login_str = login_str + "<option value='{}' {}>{}</option>".format(sel_user, selected, sel_user)

            login_str = login_str + "</select>\n"


        #self.page.add_lines("\n\n<!-- LOGIN END -->\n")
        #self.page.add_lines(login_str)
        return login_str



    



    def render_menu_full(self):

        self.add_lines("\n\n<!-- FULL MENU START -->\n")
        # Edit or view question
        if self.page_name == "edit" or self.page_name == "view" or self.page_name == "generate" :
            if self.page_name == "generate":
                page_name = "edit"
            else:
                page_name = self.page_name
            select="<select id='sel_q_id' name='sel_q_id' onchange='window.location.replace(" + \
                                create_url(page_name = encap_str(page_name), \
                                                q_id = "this.value", \
                                                lang = "sel_lang.value", \
                                                user_id = self.user_id, \
                                                menu = encap_str("full"), \
                                                js = True) + ")'>\n"
            qs = self.get_all_questions(self.language)
        
            for q in qs:
                if q == self.q_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(q, selected, q)
            select = select + "</select>\n"

        # View list
        elif self.page_name == "list" or self.page_name == "test":
            select="<select id='sel_l_id' name='sel_l_id' onchange='window.location.replace(" + \
                                create_url(page_name = encap_str(self.page_name), \
                                                l_id = "this.value", \
                                                lang = "sel_lang.value", \
                                                user_id = self.user_id, \
                                                menu = encap_str("full"), \
                                                js = True) + ")'>\n"
            ls = self.get_all_lists()
        
            for l in ls:
                if l == self.l_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            select = select + "</select>\n"
        else:
            select = ""

        log_header = self.get_login_header()
        
        # Not sure why I have to put explicit height here, otherwise it is zero!
        self.add_lines("<div style='display:block;width=100%;height:25px;background-color:#f0f0f0'>\n")
        self.add_lines("<span style='display:block;float:left;'>\n" + select + log_header + "\n</span>\n")


        
        lright = "<span style='display:block;float:right;'>\n"

        lright = lright + \
                 """<input type='button' style='font-size: 14px;' onclick='(function() {
                        var xhr = new XMLHttpRequest();
                        xhr.open("POST", "reload", true);
                        xhr.send();
                        console.log("Posted reload");
                      }) ();' value='Reload'/>  
                 """
        
        if ("languages" in self.repository.get_config()):
            lang_select="Jezik: <select id='sel_lang' name='sel_lang' onchange='window.location.replace("

            if self.page_name == "edit" or self.page_name == "view":
                lang_select = lang_select + create_url(page_name = encap_str(self.page_name), \
                                                            q_id = "sel_q_id.value", \
                                                            lang = "this.value", \
                                                            user_id = self.user_id, \
                                                            menu = encap_str("full"), \
                                                            js = True) + ")'>\n"
            # View list
            elif self.page_name == "list" or self.page_name == "test":
                lang_select = lang_select + create_url(page_name = encap_str(self.page_name), \
                                                            l_id = "sel_l_id.value", \
                                                            lang = "this.value",
                                                            user_id = self.user_id, \
                                                            menu = encap_str("full"), \
                                                            js = True) + ")'>\n"
            
            for l in self.repository.get_config()["languages"]:
                if l == self.language:
                    selected = "SELECTED"
                else:
                    selected = ""
                lang_select = lang_select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            lang_select = lang_select + "</select>\n"
            lright = lright + lang_select


        op_select = "Operacija: <select id='sel_op' name='sel_op' onchange='window.location.replace(" + \
                                            create_url(page_name = "sel_op.value", \
                                                            q_id = encap_str(self.q_id), \
                                                            l_id = encap_str(self.l_id), \
                                                            lang = encap_str(self.language), \
                                                            user_id = self.user_id, \
                                                            menu = encap_str("full"), \
                                                            js = True) + ")'>\n"

        options = ["view", "edit", "list", "test"]

        for o in options:
            if o == self.page_name:
                selected = "SELECTED"
            else:
                selected = ""
            op_select = op_select + "<option value='{}' {}> {} </option>\n".format(o, selected, o)
        op_select = op_select + "</select>"
        lright = lright + op_select
        
        self.add_lines(lright)
        self.add_lines("</div>")

        self.add_lines("\n<!-- MENU END -->\n\n")
        


    def render_menu_simple(self):
        self.add_lines("\n\n<!-- SIMPLE MENU START -->\n")
        # Edit or view question
        if self.page_name == "edit" or self.page_name == "view":
            select="<select id='sel_q_id' name='sel_q_id' onchange='window.location.replace(" + \
                                create_url(page_name = encap_str(self.page_name), \
                                                q_id = "this.value", \
                                                lang = "sel_lang.value", \
                                                user_id = self.user_id, \
                                                menu = encap_str("simple"), \
                                                js = True) + ")'>\n"

            qs = self.get_all_questions(self.language)
        
            for q in qs:
                if q == self.q_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(q, selected, q)
            select = select + "</select>\n"

        # View list
        elif self.page_name == "list" or self.page_name == "test":
            select="<select id='sel_l_id' name='sel_l_id' onchange='window.location.replace(" + \
                                create_url(page_name = encap_str(self.page_name), \
                                                l_id = "this.value", \
                                                lang = "sel_lang.value", \
                                                user_id = self.user_id, \
                                                menu = encap_str("simple"), \
                                                js = True) + ")'>\n"
            ls = self.get_all_lists()
        
            for l in ls:
                if l == self.l_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            select = select + "</select>\n"

        
        log_header = self.get_login_header()

        # Not sure why I have to put explicit height here, otherwise it is zero!
        self.add_lines("<div style='display:block;width=100%;height:25px;background-color:#f0f0f0'>\n")
        self.add_lines("<span style='display:block;float:left;'>\n" + select + log_header + "\n</span>\n")
        lright = "<span style='display:block;float:right;'>\n"

        if ("languages" in self.repository.get_config()):
            lang_select="<select id='sel_lang' name='sel_lang' onchange='window.location.replace("

            if self.page_name == "edit" or self.page_name == "view":
                #lang_select = lang_select + "?q_id=\" + sel_q_id.value + \"&"
                lang_select = lang_select + create_url(page_name = encap_str(self.page_name), \
                                                            q_id = "sel_q_id.value", \
                                                            lang = "this.value", \
                                                            user_id = self.user_id, \
                                                            menu = encap_str("simple"), \
                                                            js = True) + ")'>\n"
            # View list
            elif self.page_name == "list" or self.page_name == "test":
                lang_select = lang_select + create_url(page_name = encap_str(self.page_name), \
                                                            l_id = "sel_l_id.value", \
                                                            lang = "this.value",
                                                            user_id = self.user_id, \
                                                            menu = encap_str("simple"), \
                                                            js = True) + ")'>\n"
            
            for l in self.repository.get_config()["languages"]:
                if l == self.language:
                    selected = "SELECTED"
                else:
                    selected = ""
                lang_select = lang_select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            lang_select = lang_select + "</select>\n"
            lright = lright + lang_select

        
        self.add_lines(lright)
        self.add_lines("</div>")

        self.add_lines("\n<!-- MENU END -->\n\n")



        

    def render_menu(self, menu_type = "full"):
        if menu_type == "simple":
            self.render_menu_simple()
        else:
            self.render_menu_full()
        



            
    def render_page(self, menu = "full"):
        self.render_menu(menu)

        style = "border:6px;padding:6px;"
        self.add_lines("""
        <div>
          <span style='float:left;display:inline;""" + style + """'>
            <form method="post" action="main">
              <input type="hidden" id="op" name="op" value="generate">
              <input type="hidden" id="q_id" name="q_id" value='""" + self.q_id + """'>
              <input type="hidden" id="language" name="language" value='""" + self.language + """'>
              <div style='""" + style + """background-color:#fafaf0;'>
                  <h3>Init code:</h3>
                  <textarea name="init_code" rows="10" cols="80">
""" + self.init_code + """
                  </textarea>
              </div>
              <div style='""" + style + """background-color:#faf0fa;'>
                  <h3>Iter code:</h3>
                  <textarea name="iter_code" rows="10" cols="80">
""" + self.iter_code + """
                  </textarea>
              </div>
              <div style='""" + style + """background-color:#f0fafa;'>
                  <h3>Question text:</h3>
                  <textarea name="text" rows="10" cols="80">
""" + self.text + """
                  </textarea>
              </div>
              <div style='""" + style + """background-color:#f0faf0;'>
                  <button type="submit">Test</button>
              </div>
                </form>
          </span>
        """)

        if self.question is not None:
            self.add_lines("<span style='float:left;display:inline'>")
            # Most common mogile web pages are 360 x 640 (https://www.hobo-web.co.uk/best-screen-size/)
            # but I can't seem to enforce a size in this view, so skipping for now
            #self.page.add_lines("<div style='border-style:dotted;display:table;height=360px;width=640px;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            self.add_lines("<div style='border-style:dotted;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            self.question.eval_with_exception()
            self.add_lines("</div>")
            self.add_lines("</span>")
            
        self.add_lines("""
        </div>
        """)
        
        return self.render()



    def render_simple_page(self, menu = "full"):

        self.render_menu(menu)
        
        if self.question is not None:
            self.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>")
            self.question.eval_with_exception()
            self.add_lines("</div>")
            
        
        return self.render()



    def parse_parameters(self, page_name, q_id=None, l_id=None, language=None, user_id=None):
        self.page_name = page_name

        # If no question supplied, get the first one for the language
        if q_id is None or not q_id:
            if page_name == "test":
                self.q_id = ""
            else:
                self.q_id = self.get_all_questions(language)[0]
        else:
            self.q_id = q_id

        if l_id is None or not l_id:
            self.l_id = self.get_all_lists()[0]
        else:
            self.l_id = l_id
            
        if language is not None:
            self.language = language
        else:
            self.language = ""


        if user_id is not None:
            self.user_id = user_id
        else:
            self.user_id = ""
            
             

        
    def main(self, op="view", q_id=None, l_id=None, language="rs", menu="full",
             user_id=None, init_code="", iter_code="", text=""):

        self.clear()
        self.parse_parameters(op, q_id, l_id, language, user_id)

        if op == "view":
            q = question(self, user_id, self.rel_path)
            q.set_from_file_with_exception()
            self.add_question(q)
            return self.render_simple_page(menu)
            
        elif op == "edit":
            q = question(self, user_id, self.rel_path)
            q.set_from_file_with_exception()
            self.add_question(q)
            self.add_code(q.get_init_code(), q.get_iter_code(), q.get_text())
            return self.render_page(menu)
            
        elif op == "generate":
            self.add_code(init_code, iter_code, text)
            q = question(self, user_id, self.rel_path, 
                         init_code=init_code, iter_code=iter_code, text=text)
            self.add_question(q)
            return self.render_page(menu)

        elif op == "list":
            self.render_menu(menu)
            ql = qlist(self, user_id, self.rel_path)
            ql.render_all_questions()
            return self.render()

        elif op == "test":
            self.render_menu(menu)
            test = Test(self, user_id, self.rel_path, self.mobile)
            test.render_next_questions()
            return self.render()

        elif op == "content":
            self.render_menu(menu)
            content = Content(self, self.mobile)
            content.render_content()
            return self.render()

        else:
            return "ERROR - operation {} not known".format(op)



    # args is in format returned by urllib.parse.parse_qs
    def register(self, args):
        correct = 0
        incorrect = 0
        questions = ""
        
        if "q_id" in args.keys() and "user_id" in args.keys() and "now" in args.keys() and args["user_id"][0]:
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
                        
            response = {"user_id" : args["user_id"][0],
                        "question_id": args["q_id"][0],
                        "list_id": l_id,
                        "response_type": args["response_type"][0],
                        "time": args["start"][0],
                        "duration": int(args["now"][0]) - int(args["start"][0]),
                        "correct": correct,
                        "incorrect": incorrect,
                        "questions": questions}

            logging.info("Register results: user_id=%s, q_id=%s, l_id=%s, response_type=%s, " +
                        "start=%s, duration=%s, correct=%s, incorrect=%s, questions=\"%s\"", 
                        str(args["user_id"][0]), str(args["q_id"][0]), 
                        str(l_id), str(args["response_type"][0]), 
                        str(args["start"][0]), str(int(args["now"][0]) - int(args["start"][0])),
                        str(correct), str(incorrect), str(questions))

            self.storage.record_response(response)

        



    def logout(self, login_return=None):
        return self.main(login_return["page_name"], login_return["q_id"], login_return["l_id"], 
                         login_return["lang"], login_return["menu"])




    def login_test(self, user_id=None, login_return=None):
        login_return = decode_dict(login_return)

        #remote_ip=headers["Remote-Addr"]
        #user_agent=headers["User-Agent"]
        remote_ip=""
        user_agent=""

        if user_id is None:
            logging.debug("Login test user %s, %s, %s, %s", 'test', 'test', str(remote_ip), str(user_agent))
            self.userdb.session_login_and_update_user('local', 'test',
                                               name='test',
                                               email='test',
                                               remote_ip=remote_ip,
                                               user_agent=user_agent)
        else:
            logging.debug("Login test user %s, %s, %s, %s", user_id, user_id, str(remote_ip), str(user_agent))
            self.userdb.session_login_and_update_user('local', user_id,
                                               name=user_id,
                                               email=user_id,
                                               remote_ip=remote_ip,
                                               user_agent=user_agent)

        full_user_id = "local:" + user_id
        return self.main(login_return["page_name"], login_return["q_id"], login_return["l_id"], 
                         login_return["lang"], login_return["menu"], full_user_id)



    # To be ported to new architecture
    # def login_google(self, id_token, state=None):
    #     self.userdb.check_no_user(state)
    #     headers = cherrypy.request.headers

    #     try:
    #         idinfo = google.oauth2.id_token.verify_oauth2_token(
    #             id_token,
    #             google.auth.transport.requests.Request(),
    #             GOOGLE_CLIENT_ID
    #         )
    #         if idinfo['iss'] not in ['accounts.google.com', 'https://accounts.google.com']:
    #             raise ValueError('Wrong issuer: {}'.format(idinfo['iss']))

    #         auth_user_id = idinfo['sub']
    #         logger("Google validation success: {}".format(idinfo))

    #         name = idinfo['name']
    #         email = idinfo['email']

    #     except ValueError as ex:
    #         logger("Failed google authentication: {}".format(ex))
    #         return "ERROR"

    #     self.session_login_and_update_user('google', auth_user_id,
    #                                        name=name,
    #                                        email=email,
    #                                        remote_ip=headers["Remote-Addr"],
    #                                        user_agent=headers["User-Agent"])

    #     return "OK"
