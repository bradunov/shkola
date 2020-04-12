from copy import copy, deepcopy

from server.helpers import encode_dict, encap_str

from server.types import PageUserID
from server.types import PageLanguage
from server.types import PageOperation
from server.types import ResponseOperation
from server.types import PageParameters

from server.test import Test
from server.stats import Stats



class Design_default(object):
  




    @staticmethod
    def render_main_page(page):

        Design_default.render_menu(page)

        if isinstance(page.page_params.menu_state, dict) and \
            "summary" in page.page_params.menu_state.keys() and \
                page.page_params.menu_state["summary"]:
            # Last page
            Design_default.render_summary_page(page)
        elif not page.page_params.year:
            # No year selected, first select year
            Design_default.render_select_year_page(page)
        elif not page.page_params.theme:
            # No theme selected, select it
            Design_default.render_select_theme_page(page)
        elif not page.page_params.subtheme:
            # No theme selected, select it
            Design_default.render_select_subtheme_page(page)
        elif isinstance(page.page_params.menu_state, dict) and \
            "intro" in page.page_params.menu_state.keys() and page.page_params.menu_state["intro"]:
            Design_default.render_select_get_started_page(page)



    @staticmethod
    def render_select_year_page(page):
        page.page_params.delete_history()

        content = page.repository.get_content(PageLanguage.toStr(page.page_params.language))
        if content:

            page.add_lines("""
            <script>
                function invert_colors(index, cb, ct) {
                var button = document.getElementById("button_"+index);
                var text = document.getElementById("text_"+index);
                button.style.background=cb;
                text.style.color=ct;
                }
            </script>
            """)


            page.add_lines("<div class=\"\" align=\"center\" style=\"display:content; "
                "margin-top:12px; font-family: 'Lato'; font-weight: 400; font-size: 20px; color: #636661\">\n")
            page.add_lines("  Nije teško savladati\n")
            page.add_lines("</div>\n")

            page.add_lines("<div class=\"\" align=\"center\" style=\"display:content; "
                "margin-top:-12px; font-family: 'Lato'; font-weight: 400; font-size: 40px; color: #636661\">\n")
            page.add_lines("  matematiku!\n")
            page.add_lines("</div>\n")

            page.add_lines("<div class=\"\" align=\"center\" style=\"display:content; "
                "margin-top:12px; margin-bottom:34px; font-family: 'Lato'; font-weight: 400; font-size: 20px; color: #636661\">\n")
            page.add_lines("  Odaberi razred.")
            page.add_lines("</div>\n")


            page.add_lines("<div style=\"display:table; margin:0 auto\">\n")
            page.add_lines("<div class=\"\" align=\"center\" style=\"display:content; border:0px; padding:0px; margin:0px\">\n")  

            color_list = ["#ff6956", "#489cba", "#f7b500", "#6ab288"]

            # for i in range(0,4):
            #     if i % 2 == 0 and i > 0:
            #         page.add_lines("</div>\n")
            #         page.add_lines("<div class=\"\" align=\"center\" style=\"display:content; border:0px; padding:0px; margin:0px\">\n")  

            years = ["peti", "cetvrti", "drugi", "treci", "prvi"]
            ynumbers = [5, 4, 2, 3, 1]
            # width = 137
            # height = 140
            # font_size = 111
            # margin = 10
            scale = 0.6
            width = int(137 * scale)
            height = int(140 * scale)
            font_size = int(111 * scale)
            margin = int(10 * scale)

            for i in range(0, len(ynumbers)):

                # One button

                back_color = "#f9f9f9"
                color = color_list[i % len(color_list)]
                razred = ynumbers[i]
                year = years[i]

                button = """
                    <a id="button_{}" class="" 
                        style="display: inline-block;
                                border-radius: 10px;
                                border: 0.1px solid #000000;
                                padding: 0px;
                                color: {};
                                width: {}px;
                                height: {}px;
                                margin-right: {}px;
                                margin-left: {}px;
                                margin-bottom: {}px;
                                margin-top: {}px;
                                box-shadow: 0px 5px ;"
                                onmouseover="invert_colors('{}', '{}', '{}');" 
                                onmouseout="invert_colors('{}', '{}', '{}');" 
                        href="{}">
                        <div id="text_{}", class="" 
                            style="display: inline-block;
                                font-family: 'Bubblegum Sans'; 
                                font-size: {}px; 
                                color: {}"> {} </div>
                    </a>""".format(i, back_color, height, width, 
                        margin, margin, margin, margin, 
                        i, color, back_color, 
                        i, back_color, color, 
                        page.page_params.create_url(year = year, \
                                                    theme = "", \
                                                    subtheme = "", \
                                                    period = "", \
                                                    difficulty = "", \
                                                    js = False),
                        i, font_size, color, razred)

                page.add_lines(button)

                if not i == 2:
                    page.add_lines("</div>\n")
                    page.add_lines("<div class=\"\" align=\"center\" style=\"display:content; border:0px; padding:0px; margin:0px\">\n")  



            page.add_lines("</div>\n")
            page.add_lines("</div>\n")






            page.add_lines("")

            # page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            # page.add_lines("<h3>Izaberi razred</h3>\n")
            # page.add_lines("</div>\n")

            # for year in sorted(content.keys()):
            #     page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            #     page.add_lines("<a href='" + \
            #             page.page_params.create_url(year = year, \
            #                                         theme = "", \
            #                                         subtheme = "", \
            #                                         period = "", \
            #                                         difficulty = "", \
            #                                         js = False) + \
            #             "'> " + year.title() + "</a>\n")
            #     page.add_lines("</div>\n")




    @staticmethod
    def render_select_theme_page(page):
        page.page_params.delete_history()

        content = page.repository.get_content(PageLanguage.toStr(page.page_params.language))
        if content and page.page_params.year in content.keys():
            
            page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            page.add_lines("<h3> {} razred - izaberi oblast</h3>\n".format(page.page_params.year.title()))
            page.add_lines("</div>\n")

            for theme in sorted(content[page.page_params.year].keys()):
                page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
                page.add_lines("<a href='" + \
                        page.page_params.create_url(
                            theme = theme, \
                            subtheme = "", \
                            period = "", \
                            difficulty = "", \
                            js = False) + \
                        "'> " + theme.title() + "</a>\n")
                page.add_lines("</div>\n")

            page.add_lines("<br><br><div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            page.add_lines("<a href='" + \
                    page.page_params.create_url(year = "", js = False) + \
                    "'> Nazad na izbor razreda</a>\n")
            page.add_lines("</div>\n")




    @staticmethod
    def render_select_subtheme_page(page):
        page.page_params.delete_history()

        content = page.repository.get_content(PageLanguage.toStr(page.page_params.language))
        if content and page.page_params.year in content.keys() and \
                       page.page_params.theme in content[page.page_params.year].keys():
            
            page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            page.add_lines("<h3> {} razred, {} - izaberi temu</h3>\n".format(\
                page.page_params.year.title(), page.page_params.theme.title() ))
            page.add_lines("</div>\n")

            for subclass in sorted(content[page.page_params.year][page.page_params.theme].keys()):
                if not subclass == "name":
                    page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
                    page.add_lines("<a href='" + \
                            page.page_params.create_url(
                                subtheme = content[page.page_params.year][page.page_params.theme][subclass]["subtheme"], 
                                period = content[page.page_params.year][page.page_params.theme][subclass]["period"], 
                                difficulty = content[page.page_params.year][page.page_params.theme][subclass]["difficulty"], 
                                menu_state = {"intro": True}, 
                                l_id = content[page.page_params.year][page.page_params.theme]["name"], js = False) + \
                            "'> " + subclass.title() + "</a>\n")
                    page.add_lines("</div>\n")


            page.add_lines("<br><div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            page.add_lines("<a href='" + \
                    page.page_params.create_url(
                        subtheme = "*", 
                        period = "*", 
                        difficulty = "*", 
                        menu_state = {"intro": True}, 
                        l_id = content[page.page_params.year][page.page_params.theme]["name"], js = False) + \
                    "'> Supermix </a>\n")
            page.add_lines("</div>\n")

            page.add_lines("<br><br><div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            page.add_lines("<a href='" + \
                    page.page_params.create_url(theme = "", js = False) + \
                    "'> Nazad na izbor oblasti</a>\n")
            page.add_lines("</div>\n")



    @staticmethod
    def render_select_get_started_page(page):
        page.page_params.delete_history()

        page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
        page.add_lines("<h3> {} razred, {}, {}|{}|{} - Pocetak </h3>\n".format(\
            page.page_params.year.title(), page.page_params.theme.title(), \
            page.page_params.subtheme.title(), page.page_params.period.title(), \
            page.page_params.difficulty.title() ))
        page.add_lines("<br>Neke zadatke ces resiti lakse ako spremis papir i olovku.\n")
        page.add_lines("<br>Kad uradis 10 zadataka bez greske, napravi pauzu.\n")
        page.add_lines("<br>Da predjes na sledeci zadatak ili da se vratis na prethodni, koristi trotinet.\n")
        page.add_lines("</div>\n")

        page.add_lines("<br><br><div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
        page.add_lines("<a href='" + \
                page.page_params.create_url(\
                    op = PageOperation.toStr(PageOperation.TEST), 
                    q_id = "", 
                    menu_state = {"q_number": 1}, 
                    js = False) + \
                "'> Pocni</a>\n")
        page.add_lines("</div>\n")

        page.add_lines("<br><br><div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
        page.add_lines("<a href='" + \
                page.page_params.create_url(\
                    subtheme = "", 
                    period = "", 
                    difficulty = "", 
                    menu_state = {}, 
                    l_id = "", js = False) + \
                "'> Nazad na izbor podteme</a>\n")
        page.add_lines("</div>\n")


    @staticmethod
    def render_summary_page(page):
        page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
        page.add_lines("<h3>Bravo!</h3><br>\n")
        correct = 0
        incorrect = 0
        try:
            if "history" in page.page_params.menu_state.keys():
                page.add_lines("Tvoj rezultat po pitanjima:<br><br>\n")
                for r in page.page_params.menu_state["history"]:
                    page.add_lines("{}: tacno {}, netacno {} <br>\n".format(r["question"], r["correct"], r["incorrect"]))
                    correct = correct + int(r["correct"])
                    incorrect = incorrect + int(r["incorrect"])
                page.add_lines("<br> Ukupno tacno {}/{} ({} %):<br><br>\n", 
                    correct, correct + incorrect, correct / (correct + incorrect))
        except:
            pass
        page.add_lines("</div>\n")

        page.page_params.delete_history()

        page.add_lines("<a href='" + \
                page.page_params.create_url(year=page.page_params.year, \
                                            theme = "", \
                                            subtheme = "", \
                                            difficulty = "", \
                                            period = "", \
                                            js=False) + \
                "'> Nazad na izbor teme </a>\n")
        return page.render()




    @staticmethod
    def render_question_page(page):
        Design_default.render_menu(page)
        test = Test(page)


        if isinstance(page.page_params.menu_state, dict) and "q_number" in page.page_params.menu_state.keys():
            current_number = page.page_params.menu_state["q_number"]
            if current_number > 1 and "history" in page.page_params.menu_state.keys () and \
                                                   len(page.page_params.menu_state["history"]) >= 1:

                # Go back to the previous page and reset history:
                # Remove the last item in history, decrease the page counter
                # and delete "last_question" key 
                # The last one is a "hack", otherwise this question will be added to the history
                new_menu_state = deepcopy(page.page_params.menu_state)
                del new_menu_state["history"][-1]
                new_menu_state["q_number"] = new_menu_state["q_number"] - 1
                del new_menu_state["last_question"]

                prev_url = page.page_params.create_url(\
                            q_id = page.page_params.menu_state["history"][-1]["question"], \
                            menu_state = new_menu_state,
                            js = False)
            else:
                prev_url = page.page_params.create_url(\
                            op = PageOperation.toStr(PageOperation.MENU), 
                            q_id = "", 
                            menu_state = {"intro": True}, 
                            js = False)

            page.page_params.menu_state["q_number"] = page.page_params.menu_state["q_number"] + 1

        next_question_url = test.render_next_questions()

        Design_default.add_buttons(page, next_question_url, prev_url)
        if page.page_params.root == "main":
            page.add_lines("<br><br><div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            page.add_lines("Pitanje {} od 3\n".format(current_number))
            page.add_lines("Prethodno: {} / {}".format(page.page_params.correct, page.page_params.incorrect))
            page.add_lines("</div>\n")
        return page.render()
                    


    # Inspired by https://www.w3schools.com/w3css/w3css_sidebar.asp

    @staticmethod
    def render_menu(page):

        # For now remove the language menu
        show_language_menu = False


        page.add_lines("\n\n<!-- MOBILE MENU START -->\n")

        # Temporary, for debugging:
        # debug_str = ""
        # if page.page_params.user_id is not None and PageUserID.toStr(page.page_params.user_id):
        #     if len(PageUserID.toStr(page.page_params.user_id)) >= len("local:") and PageUserID.toStr(page.page_params.user_id)[:len("local:")] == "local:":
        #         debug_str = debug_str + "Hi {} ".format(PageUserID.toStr(page.page_params.user_id)[len("local:"):])
        #     else:
        #         debug_str = debug_str + "Hi {} ".format(PageUserID.toStr(page.page_params.user_id))
        # if page.page_params.q_id is not None and page.page_params.q_id:
        #     debug_str = debug_str + "(Q: {})".format(page.page_params.q_id)

        page.add_script_lines("""
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
                <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
                <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Bubblegum+Sans" />
                <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Lato" />
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

            <div class="w3-white">
                <div class="w3-button" style="font-family: 'Bubblegum Sans'; font-size: 24px; color: #029194"> TATA MATA </div> 
                <span style='display:block;float:right;'> """ + \
                (("<button class=\"w3-button w3-dark-grey w3-large\" onclick=\"shl_toggle()\">" + \
                    page.get_messages()["language"] + "</button>") if show_language_menu else "") \
                + """
                <button class="w3-button" style="font-size: 20px; font-weight: 900; color: #029194" onclick="shm_toggle()">☰</button>
                </span>
            </div>

            <div class="w3-sidebar w3-bar-block w3-border-left" style="width:200px;right:0;display:none" id="shMenu">
                <button class="w3-button w3-block w3-left-align" onclick="myAccFunc('accLevel')">
                    """ + page.get_messages()["questions"] + """ <i class="fa fa-caret-down"></i>
                </button>
                <div id='accLevel' class="w3-hide w3-white w3-card">
        """)


        new_page_params = PageParameters()
        new_page_params.root = page.page_params.root 
        new_page_params.op = PageOperation.MENU
        new_page_params.language = page.page_params.language
        Design_default.render_menu_drop(page, new_page_params, 1)

        page.add_lines("""
                </div>
        """)

        if not page.page_params.user_id is None and PageUserID.toStr(page.page_params.user_id):
            #print("\n\nAAAAA:{}\n\n".format(PageUserID.toStr(page.page_params.user_id)))
            page.add_lines("<a href=\"" + \
                page.page_params.create_url(op = PageOperation.toStr(PageOperation.STATS), js = False) + \
                "\" class=\"w3-bar-item w3-button\"> Rezultati </a>\n")


        page.add_lines("""
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


        if show_language_menu:
            if ("languages" in page.repository.get_config()):
                
                lang_select = """
                            <div class="w3-sidebar w3-bar-block w3-border-left" style="width:200px;right:0;display:none"  id="shLang">
                            """
                for lang in page.get_language_list():
                    lang_select = lang_select + "<a href='" + \
                            page.page_params.create_url(language = lang, js = False) + \
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
    def render_menu_drop(page, new_page_params : PageParameters, indent=0):
        content = page.repository.get_content(PageLanguage.toStr(page.page_params.language))

        str_indent1 = ""
        for i in range(0, indent):
            str_indent1 = str_indent1 + "<div class='space'></div>"
        str_indent2 = str_indent1 + "<div class='space'></div>"

        for level in sorted(content.keys()):
            new_page_params.year = level
            new_page_params.theme = ""
            page.add_lines(str_indent1 + \
                "<a href=\"" + new_page_params.create_url(js = False) + "\" style='text-decoration:none'> " + level + "</a>" + \
                """
                    <button class="w3-button w3-left-align" onclick="myAccFunc('acc""" + level + """')">
                    """ +  """ <i class="fa fa-caret-down"></i>
                    </button>
                    <div id='acc""" + level + """' class="w3-hide w3-white w3-card">
                """)

            for theme in sorted(content[level].keys()):
                new_page_params.theme = theme
                page.add_lines("<a href=\"" + new_page_params.create_url(js = False) + \
                    "\" class=\"w3-bar-item w3-button\"> " + str_indent2 + theme + "</a>\n")

            page.add_lines("</div>")
            
            page.add_lines("<br>")






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
    def add_buttons(page, url_next=None, url_prev=None):
        page.add_lines("\n\n<!-- QUESTIONS START -->\n\n")
        page.add_lines("<div id='question' style='display:table; margin:0 auto;'>\n")
        page.add_lines("\n<div id='question_buttons' style='display:block;text-align:center;padding-top:20px;padding-bottom:6px'>\n")

        total_questions = 3

        if isinstance(page.page_params.menu_state, dict) and "q_number" in page.page_params.menu_state.keys():
            q_number = page.page_params.menu_state["q_number"]
        else:
            q_number = 0

        if q_number == total_questions + 1:
            new_params = copy(page.page_params.menu_state)
            new_params["summary"] = True
            home_url = page.page_params.create_url( op=encap_str(PageOperation.toStr(PageOperation.MENU)),
                                                    year=encap_str(page.page_params.year), 
                                                    q_id=encap_str(""), 
                                                    l_id=encap_str(""), 
                                                    theme=encap_str(""), 
                                                    menu_state=new_params,
                                                    correct="q_correct", incorrect="q_incorrect", \
                                                    js=True)


        if url_prev is not None:
            page.add_lines("\n\n<!-- PREV BUTTON -->\n")
            page.add_lines("\n<input type='button' style='font-size: 14px;' "\
                "onclick='window.location.replace(\"{}\")' value='{}' />\n".format(url_prev, "Nazad"))
            page.add_lines("\n<!-- END PREV BUTTON -->\n\n")

        page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")        
        page.add_lines("\n<!-- CLEAR BUTTON -->\n")
        page.add_lines("\n<input type='button' style='font-size: 14px;' onclick=\"clearAll()\" value='{}' />\n".format(
            page.get_messages()["clear"]))
        page.add_lines("\n<!-- END CLEAR BUTTON -->\n")


        # page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
        # page.add_lines("\n\n<!-- CHECK BUTTON -->\n")
        # page.add_lines("<input type='button' style='font-size: 14px;' onclick='{}' value='{}'/>\n".format(
        #     page.on_click(\
        #         operation=ResponseOperation.SUBMIT, \
        #         record=True), page.get_messages()["check"]))
        # page.add_lines("\n<!-- END CHECK BUTTONS -->\n")


        page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")        
        page.add_lines("\n\n<!-- CHECK BUTTON -->\n")
        if q_number == total_questions + 1:
            page.add_lines("<input type='button' style='font-size: 14px;' onclick='{}' value='{}'/>\n".format(
                page.on_click(\
                    operation=ResponseOperation.SUBMIT, \
                    url_next=home_url, quoted=False, \
                    record=True), page.get_messages()["check"]))
        else:
            page.add_lines("<input type='button' style='font-size: 14px;' onclick='{}' value='{}'/>\n".format(
                page.on_click(\
                    operation=ResponseOperation.SUBMIT, \
                    url_next=url_next, \
                    record=True), page.get_messages()["check"]))
        page.add_lines("\n<!-- END CHECK BUTTON -->\n")


        if url_next is not None:
            page.add_lines("\n\n<!-- NEXT BUTTON -->\n")
            page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
            if q_number == total_questions + 1:
                page.add_lines("\n<input type='button' style='font-size: 14px;' onclick='{}' value='{}' />\n".format(
                    page.on_click(\
                        operation=ResponseOperation.SKIP, \
                        url_next=home_url, quoted=False, \
                        record=True), page.get_messages()["skip"]))
            else:
                page.add_lines("\n<input type='button' style='font-size: 14px;' onclick='{}' value='{}' />\n".format(
                    page.on_click(\
                        operation=ResponseOperation.SKIP, \
                        url_next=url_next, \
                        record=True), page.get_messages()["skip"]))
            page.add_lines("\n<!-- END NEXT BUTTON -->\n\n")
            


        page.add_lines("\n</div>\n")
        page.add_lines("</div>\n")
        page.add_lines("\n\n<!-- QUESTIONS END -->\n\n")

        





    @staticmethod
    def _render_user_one_cat_rec(page, cat, desc, indent):
        hspace = "<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>"

        page.add_lines("  <tr>")

        if indent > 1:
            page.add_lines("<td></td> ")

        page.add_lines("<td style='text-align:left'>{}{}{}</td> ".format(hspace, desc, hspace))

        if indent <= 1:
            page.add_lines("<td></td> ")

        if "all" in cat.keys():
            page.add_lines("<td style='text-align:center'>{}{}/{}({:3d}%/{:3d})%{}</td> ".format(
                hspace,
                cat["all"]["total"],
                cat["all"]["subtotal"], 
                int(cat["all"]["questions"]*100), 
                int(cat["all"]["subquestions"]*100),
                hspace
            ))
        else:
            page.add_lines("<td></td> ")

        for d in range(1,4):
            diff = str(d)
            if "difficulty" in cat.keys() and diff in cat["difficulty"].keys():
                page.add_lines("<td style='text-align:center'>{}{}/{}({:3d}%/{:3d}%){}</td> ".format(
                    hspace, 
                    cat["difficulty"][diff]["total"],
                    cat["difficulty"][diff]["subtotal"], 
                    int(cat["difficulty"][diff]["questions"]*100), 
                    int(cat["difficulty"][diff]["subquestions"]*100),
                    hspace
                ))
            else:
                page.add_lines("<td></td> ")
        page.add_lines("</tr>\n")

        for kt in cat.keys():
            if not (kt == "all" or kt == "difficulty"):
                for k in cat[kt].keys():
                    Design_default._render_user_one_cat_rec(page, cat[kt][k], k, indent+1)




    @staticmethod
    def render_user_stats(page, u_id):
        Design_default.render_menu(page)
        stats = Stats.render_user_stats(page, u_id)

        hspace = "<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>"
        page.add_lines("<table style='border: none; border-collapse: collapse;'>")
        page.add_lines("<tr><td style='text-align:left'>{}Oblast{}</td> ".format(hspace, hspace) + \
                "<td style='text-align:left'>{}Tema{}</td> ".format(hspace, hspace) + \
                "<td style='text-align:center'>{}Svi zadaci{}</td> ".format(hspace, hspace) + \
                "<td style='text-align:center'>{}1 zvezda{}</td> ".format(hspace, hspace) + \
                "<td style='text-align:center'>{}2 zvezde{}</td> ".format(hspace, hspace) + \
                "<td style='text-align:center'>{}3 zvezde{}</td> ".format(hspace, hspace) + \
                "</tr>\n")
        Design_default._render_user_one_cat_rec(page, stats, "Svi", 0)
        page.add_lines("</table><br>")






