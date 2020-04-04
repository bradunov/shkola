from helpers import *
from types import *

class Design_test(object):


    @staticmethod
    def render_page(page):
        Design_test.render_simple_page(page)


    @staticmethod
    def render_menu_full(page):
        page.add_lines("\n\n<!-- FULL MENU START -->\n")
        # Edit or view question
        if page.page_name == "edit" or page.page_name == "view" or page.page_name == "generate" :
            if page.page_name == "generate":
                page_name = "edit"
            else:
                page_name = page.page_name
            select="<select id='sel_q_id' name='sel_q_id' onchange='window.location.replace(" + \
                                create_url(page_name = encap_str(page_name), \
                                                q_id = "this.value", \
                                                lang = "sel_lang.value", \
                                                user_id = encap_str(page.user_id), \
                                                menu = encap_str("full"), \
                                                js = True) + ")'>\n"
            qs = page.get_all_questions(page.language)
        
            for q in qs:
                if q == page.q_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(q, selected, q)
            select = select + "</select>\n"

        # View list
        elif page.page_name == "list" or page.page_name == "test":
            select="<select id='sel_l_id' name='sel_l_id' onchange='window.location.replace(" + \
                                create_url(page_name = encap_str(page.page_name), \
                                                l_id = "this.value", \
                                                lang = "sel_lang.value", \
                                                user_id = encap_str(page.user_id), \
                                                menu = encap_str("full"), \
                                                js = True) + ")'>\n"
            ls = page.get_all_lists()
        
            for l in ls:
                if l == page.l_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            select = select + "</select>\n"
        else:
            select = ""

        log_header = Design_test.get_login_header(page)
        
        # Not sure why I have to put explicit height here, otherwise it is zero!
        page.add_lines("<div style='display:block;width=100%;height:25px;background-color:#f0f0f0'>\n")
        page.add_lines("<span style='display:block;float:left;'>\n" + select + log_header + "\n</span>\n")


        
        lright = "<span style='display:block;float:right;'>\n"

        lright = lright + \
                """<input type='button' style='font-size: 14px;' onclick='(function() {
                        var xhr = new XMLHttpRequest();
                        xhr.open("POST", "reload", true);
                        xhr.send();
                        console.log("Posted reload");
                    }) ();' value='Reload'/>  
                """
        
        if ("languages" in page.repository.get_config()):
            lang_select="Jezik: <select id='sel_lang' name='sel_lang' onchange='window.location.replace("

            if page.page_name == "edit" or page.page_name == "view":
                lang_select = lang_select + create_url(page_name = encap_str(page.page_name), \
                                                            q_id = "sel_q_id.value", \
                                                            lang = "this.value", \
                                                            user_id = encap_str(page.user_id), \
                                                            menu = encap_str("full"), \
                                                            js = True) + ")'>\n"
            # View list
            elif page.page_name == "list" or page.page_name == "test":
                lang_select = lang_select + create_url(page_name = encap_str(page.page_name), \
                                                            l_id = "sel_l_id.value", \
                                                            lang = "this.value",
                                                            user_id = encap_str(page.user_id), \
                                                            menu = encap_str("full"), \
                                                            js = True) + ")'>\n"
            # Generate? 
            else:
                lang_select = lang_select + create_url(page_name = encap_str(page.page_name), \
                                                            q_id = "sel_q_id.value", \
                                                            lang = "this.value", \
                                                            user_id = encap_str(page.user_id), \
                                                            menu = encap_str("full"), \
                                                            js = True) + ")'>\n"
            
            for l in page.repository.get_config()["languages"]:
                if l == page.language:
                    selected = "SELECTED"
                else:
                    selected = ""
                lang_select = lang_select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            lang_select = lang_select + "</select>\n"
            lright = lright + lang_select


        op_select = "Operacija: <select id='sel_op' name='sel_op' onchange='window.location.replace(" + \
                                            create_url(page_name = "sel_op.value", \
                                                            q_id = encap_str(page.q_id), \
                                                            l_id = encap_str(page.l_id), \
                                                            lang = encap_str(page.language), \
                                                            user_id = encap_str(page.user_id), \
                                                            menu = encap_str("full"), \
                                                            js = True) + ")'>\n"

        options = ["view", "edit", "list", "test"]

        for o in options:
            if o == page.page_name:
                selected = "SELECTED"
            else:
                selected = ""
            op_select = op_select + "<option value='{}' {}> {} </option>\n".format(o, selected, o)
        op_select = op_select + "</select>"
        lright = lright + op_select
        
        page.add_lines(lright)
        page.add_lines("</div>")

        page.add_lines("\n<!-- MENU END -->\n\n")




    @staticmethod
    def render_menu_simple(page):
        page.add_lines("\n\n<!-- SIMPLE MENU START -->\n")
        # Edit or view question
        if page.page_name == "edit" or page.page_name == "view":
            select="<select id='sel_q_id' name='sel_q_id' onchange='window.location.replace(" + \
                                create_url(page_name = encap_str(page.page_name), \
                                                q_id = "this.value", \
                                                lang = "sel_lang.value", \
                                                user_id = encap_str(page.user_id), \
                                                menu = encap_str("simple"), \
                                                js = True) + ")'>\n"

            qs = page.get_all_questions(page.language)
        
            for q in qs:
                if q == page.q_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(q, selected, q)
            select = select + "</select>\n"

        # View list
        elif page.page_name == "list" or page.page_name == "test":
            select="<select id='sel_l_id' name='sel_l_id' onchange='window.location.replace(" + \
                                create_url(page_name = encap_str(page.page_name), \
                                                l_id = "this.value", \
                                                lang = "sel_lang.value", \
                                                user_id = encap_str(page.user_id), \
                                                menu = encap_str("simple"), \
                                                js = True) + ")'>\n"
            ls = page.get_all_lists()
        
            for l in ls:
                if l == page.l_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            select = select + "</select>\n"

        
        log_header = Design_test.get_login_header(page)

        # Not sure why I have to put explicit height here, otherwise it is zero!
        page.add_lines("<div style='display:block;width=100%;height:25px;background-color:#f0f0f0'>\n")
        page.add_lines("<span style='display:block;float:left;'>\n" + select + log_header + "\n</span>\n")
        lright = "<span style='display:block;float:right;'>\n"

        if ("languages" in page.repository.get_config()):
            lang_select="<select id='sel_lang' name='sel_lang' onchange='window.location.replace("

            if page.page_name == "edit" or page.page_name == "view":
                #lang_select = lang_select + "?q_id=\" + sel_q_id.value + \"&"
                lang_select = lang_select + create_url(page_name = encap_str(page.page_name), \
                                                            q_id = "sel_q_id.value", \
                                                            lang = "this.value", \
                                                            user_id = encap_str(page.user_id), \
                                                            menu = encap_str("simple"), \
                                                            js = True) + ")'>\n"
            # View list
            elif page.page_name == "list" or page.page_name == "test":
                lang_select = lang_select + create_url(page_name = encap_str(page.page_name), \
                                                            l_id = "sel_l_id.value", \
                                                            lang = "this.value",
                                                            user_id = encap_str(page.user_id), \
                                                            menu = encap_str("simple"), \
                                                            js = True) + ")'>\n"
            
            for l in page.repository.get_config()["languages"]:
                if l == page.language:
                    selected = "SELECTED"
                else:
                    selected = ""
                lang_select = lang_select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            lang_select = lang_select + "</select>\n"
            lright = lright + lang_select

        
        page.add_lines(lright)
        page.add_lines("</div>")

        page.add_lines("\n<!-- MENU END -->\n\n")





    @staticmethod
    def render_page_edit(page, menu = "full"):
        Design_test.render_menu_full(menu)

        style = "border:6px;padding:6px;"
        page.add_lines("""
        <div>
          <span style='float:left;display:inline;""" + style + """'>
            <form method="post" action='""" + base_url(menu) + """'>
              <input type="hidden" id="op" name="op" value="generate">
              <input type="hidden" id="q_id" name="q_id" value='""" + page.q_id + """'>
              <input type="hidden" id="language" name="language" value='""" + page.language + """'>
              <div style='""" + style + """background-color:#fafaf0;'>
                  <h3>Init code:</h3>
                  <textarea name="init_code" rows="10" cols="80">
                      """ + page.init_code + """
                  </textarea>
              </div>
              <div style='""" + style + """background-color:#faf0fa;'>
                  <h3>Iter code:</h3>
                  <textarea name="iter_code" rows="10" cols="80">
                      """ + page.iter_code + """
                  </textarea>
              </div>
              <div style='""" + style + """background-color:#f0fafa;'>
                  <h3>Question text:</h3>
                  <textarea name="text" rows="10" cols="80">
                      """ + page.text + """
                  </textarea>
              </div>
              <div style='""" + style + """background-color:#f0faf0;'>
                  <button type="submit">Test</button>
              </div>
                </form>
          </span>
        """)

        if page.question is not None:
            page.add_lines("<span style='float:left;display:inline'>")
            # Most common mogile web pages are 360 x 640 (https://www.hobo-web.co.uk/best-screen-size/)
            # but I can't seem to enforce a size in this view, so skipping for now
            #page.page.add_lines("<div style='border-style:dotted;display:table;height=360px;width=640px;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            page.add_lines("<div style='border-style:dotted;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            page.question.eval_with_exception(True)
            Design_test.add_buttons(page)
            page.add_lines("</div>")
            page.add_lines("</span>")
            
        page.add_lines("""
        </div>
        """)
        





    @staticmethod
    def render_simple_page(page, menu = "full"):

        Design_test.render_menu_simple(menu)
        
        if page.question is not None:
            page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>")
            page.question.eval_with_exception()
            Design_test.add_buttons()
            page.add_lines("</div>")
                    





    @staticmethod    
    def get_login_header(page, mobile=False):
        login_str = ""

        if mobile:
            menu = "simple"
        else:
            menu = "full"


        login_return = {}
        login_return["page_name"] = page.page_name
        login_return["q_id"] = page.q_id
        login_return["l_id"] = page.l_id
        login_return["lang"] = page.language
        login_return["user_id"] = page.user_id
        login_return["menu"] = menu
        login_return["js"] = False
        login_return = encode_dict(login_return)


        test_users = ["Aran", "Petar", "Oren", "Thomas", "Ben", "Luke", "Leo", "Oliver", "Felix", "Darragh", "Jovana", "Zomebody"]
        test_users.sort()

        login_str = ""
        for username in test_users:
            link = base_url(menu) + "?op=login_test&" + "login_return=" + \
                        login_return + "&user_id={}".format(username) 
            str_indent = "<div class='space'></div>"
            login_str = login_str + "<a href='" + link + "' class='w3-bar-item w3-button'> " + str_indent + username + "</a>\n"


        return login_str





    @staticmethod    
    def add_buttons(page, url_next=None):
        page.add_lines("\n\n<!-- QUESTIONS START -->\n\n")
        page.add_lines("<div id='question' style='display:table; margin:0 auto;'>\n")
        page.add_lines("\n<div id='question_buttons' style='display:block;text-align:center;padding-top:20px;padding-bottom:6px'>\n")

        OKline = "\n\n<!-- CHECK NEXT BUTTON -->\n"
        OKline = OKline + "<input type='button' style='font-size: 14px;' onclick='{}' value='{}'/>\n".format(
            page.on_click(Operation.SUBMIT, url_next), page.get_messages()["check"])
        page.add_lines(OKline)

        if url_next is not None:
            NEXTline = ""
            NEXTline = "\n<input type='button' style='font-size: 14px;' onclick='{}' value='{}' />\n".format(
                page.on_click(Operation.SUBMIT, url_next), page.get_messages()["skip"])
            page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
            page.add_lines(NEXTline)
            
        page.add_lines("\n<!-- END CHECK NEXT BUTTONS -->\n")



        page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
        
        page.add_lines("\n<!-- CLEAR BUTTON -->\n")
        page.add_lines("\n<input type='button' style='font-size: 14px;' onclick=\"clearAll()\" value='{}' />\n".format(
            page.get_messages()["clear"]))
        page.add_lines("\n<!-- END CLEAR BUTTON -->\n")

        page.add_lines("\n</div>\n")
        page.add_lines("</div>\n")
        page.add_lines("\n\n<!-- QUESTIONS END -->\n\n")

        



