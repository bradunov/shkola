from server.helpers import encode_dict

from server.types import PageUserID
from server.types import PageLanguage
from server.types import PageOperation
from server.types import ResponseOperation



class Design_default(object):
  
    @staticmethod
    def render_page(page):

        Design_default.render_menu(page)
        
        if page.question is not None:
            page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>")
            page.question.eval_with_exception()
            Design_default.add_buttons(page)
            page.add_lines("</div>")
                    


    # Inspired by https://www.w3schools.com/w3css/w3css_sidebar.asp

    @staticmethod
    def render_menu(page):
        page.add_lines("\n\n<!-- MOBILE MENU START -->\n")

        # Temporary, for debugging:
        debug_str = ""
        if page.page_params.user_id is not None and PageUserID.toStr(page.page_params.user_id):
            if len(PageUserID.toStr(page.page_params.user_id)) >= len("local:") and PageUserID.toStr(page.page_params.user_id)[:len("local:")] == "local:":
                debug_str = debug_str + "Hi {} ".format(PageUserID.toStr(page.page_params.user_id)[len("local:"):])
            else:
                debug_str = debug_str + "Hi {} ".format(PageUserID.toStr(page.page_params.user_id))
        if page.page_params.q_id is not None and page.page_params.q_id:
            debug_str = debug_str + "(Q: {})".format(page.page_params.q_id)

        page.add_script_lines("""
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
                <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
                """)

        page.add_lines("""
            <script>
            function myAccFunc(title) {
                var x = document.getElementById(title);
                if (x.className.indexOf("w3-show") == -1) {
                x.className += " w3-show";
                x.previousElementSibling.className += " w3-green";
                } else { 
                x.className = x.className.replace(" w3-show", "");
                x.previousElementSibling.className = 
                x.previousElementSibling.className.replace(" w3-green", "");
                }
            }
            function shm_toggle() {
                if (document.getElementById("shMenu").style.display == "none") {
                    document.getElementById("shMenu").style.display = "block";
                } else {
                    document.getElementById("shMenu").style.display = "none";
                }
            }
            function shl_toggle() {
                if (document.getElementById("shLang").style.display == "none") {
                    document.getElementById("shLang").style.display = "block";
                } else {
                    document.getElementById("shLang").style.display = "none";
                }
            }
            </script>
            <div class="w3-dark-grey">
            <button class="w3-button w3-dark-grey w3-large" onclick="shm_toggle()">☰</button>
            """ + debug_str + """
            <span style='display:block;float:right;'>
            <button class="w3-button w3-dark-grey w3-large" onclick="shl_toggle()">""" + page.get_messages()["language"] + """</button>
            </span>
            </div>
            <div class="w3-sidebar w3-bar-block w3-border-right" style="display:none" id="shMenu">
                <button class="w3-button w3-block w3-left-align" onclick="myAccFunc('accLevel')">
                    """ + page.get_messages()["questions"] + """ <i class="fa fa-caret-down"></i>
                </button>
                <div id='accLevel' class="w3-hide w3-white w3-card">
        """)


        Design_default.render_menu_drop(page, PageLanguage.toStr(page.page_params.language), 
            page.page_params.root + "?op={}&language={}&menu={}&user_id={}".format(
            PageOperation.toStr(page.page_params.op), PageLanguage.toStr(page.page_params.language), 
            "mobile", PageUserID.toStr(page.page_params.user_id) ), 1)



        page.add_lines("""
                </div>

                <button class="w3-button w3-block w3-left-align" onclick="myAccFunc('accUser')">
                    """ + page.get_messages()["user"] + """ <i class="fa fa-caret-down"></i>
                </button>
                <div id='accUser' class="w3-hide w3-white w3-card">
        """)


        page.add_lines(Design_default.get_login_header(page))


        page.add_lines("""
                </div>
            </div>
        """)

        if ("languages" in page.repository.get_config()):
            
            lang_select = """
                        <div class="w3-sidebar w3-bar-block w3-border-left" style="width:200px;right:0;display:none"  id="shLang">
                        """
            for lang in page.get_language_list():
                lang_select = lang_select + "<a href='" + \
                        page.create_url(language = lang, js = False) + \
                        "' class='w3-bar-item w3-button'>" + page.get_messages(lang)["name"] + "</a>"
            
            lang_select = lang_select + """
                        </div>
                        """
            page.add_lines(lang_select)




        page.add_lines("\n<!-- MENU END -->\n\n")




        '''
    @staticmethod
    def render_content(page, language, level="Prvi"):
        content = page.repository.get_content(language)

        if level not in content.keys():
        logging.info("No level %s in content, rendering empty page", level)
        return

        for theme_name in sorted(content[level].keys()):
        theme_dict = content[level][theme_name]

        page.add_lines("\n\n<!-- NEW THEME -->\n")
        page.add_lines("  <div style='display:inline-block;font-weight:bold;font-size:18px;padding-top:6px;padding-bottom:4px;'>\n")
        page.add_lines("    {}\n".format(theme_name))
        page.add_lines("  </div>\n")
        page.add_lines("<div style='display:table;padding-top:0px;padding-bottom:0px;float:center'> </div>")

        for label in theme_dict.keys():
            page.add_lines("    <div style='display:inline-block;font-weight:bold;font-size:14px;padding-top:4px;padding-bottom:2px;'>\n")
            page.add_lines("      <div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
            page.add_lines("      <a href=''>{}</a>\n".format(label))
            page.add_lines("    </div>\n")
            page.add_lines("<div style='display:table;padding-top:0px;padding-bottom:0px;float:center'> </div>")
        '''




    @staticmethod
    def render_menu_drop(page, language, link, indent=0):
        content = page.repository.get_content(language)

        str_indent1 = ""
        for i in range(0, indent):
            str_indent1 = str_indent1 + "<div class='space'></div>"
        str_indent2 = str_indent1 + "<div class='space'></div>"

        for level in sorted(content.keys()):
            page.add_lines("""
                <button class="w3-button w3-block w3-left-align" onclick="myAccFunc('acc""" + level + """')">
                """ + str_indent1 + level + """ <i class="fa fa-caret-down"></i>
                </button>
                <div id='acc""" + level + """' class="w3-hide w3-white w3-card">
            """)

            for theme in sorted(content[level].keys()):
                page.add_lines("""
                <a href='""" + link + "&l_id=" + content[level][theme]["name"] + 
                """' class="w3-bar-item w3-button"> """ + str_indent2 + theme + """</a>
                """)

            page.add_lines("</div>")
            






    @staticmethod    
    def get_login_header(page):
        login_str = ""


        login_return = page.page_params.all_state
        login_return["js"] = False
        login_return = encode_dict(login_return)


        test_users = ["Aran", "Petar", "Oren", "Thomas", "Ben", "Luke", "Leo", "Oliver", "Felix", "Darragh", "Jovana", "Zomebody"]
        test_users.sort()

        login_str = ""
        for username in test_users:
            link = page.page_params.root + "?op=login_test&" + "login_return=" + \
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
            page.on_click(\
                operation=ResponseOperation.SUBMIT, \
                url_next=url_next, \
                record=True), page.get_messages()["check"])
        page.add_lines(OKline)

        if url_next is not None:
            NEXTline = ""
            NEXTline = "\n<input type='button' style='font-size: 14px;' onclick='{}' value='{}' />\n".format(
                page.on_click(\
                    operation=ResponseOperation.SKIP, \
                    url_next=url_next, \
                    record=True), page.get_messages()["skip"])
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

        



