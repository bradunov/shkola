import time
import jinja2
import json

from server.helpers import encode_dict, encap_str

from server.types import PageLanguage
from server.types import PageOperation
from server.types import ResponseOperation
from server.types import PageParameters

from server.test import Test
from server.question import Question
from server.stats import Stats

from server.user_db import GOOGLE_CLIENT_ID

import server.context as context

import logging

USE_GOOGLE_AUTH = True


class Design_default(object):
    total_questions = 3

    @staticmethod
    def render_main_page(page):


        # If login, update user and replace op with the original op
        if page.page_params.get_param("op") == PageOperation.LOGIN_ANON:
            new_url = page.login_anon()
            context.c.headers.redirect(new_url)
            return ""

        if page.page_params.get_param("op") == PageOperation.LOGIN_GOOGLE:
            new_url, ok = page.login_google()
            context.c.headers.set_content_type('text/plain')
            return "OK:{}".format(new_url) if ok else "ERROR:{}".format(new_url)

        if not context.c.user:
            # First login, if not already done
            page.page_params.set_param("op", PageOperation.MENU_USER)

        user = context.c.user

        # If we happen to get to too many questions (e.g. reloading or returning to a test from elsewhere)
        # here we check that we didn't reach the end counter, and if we did, redirect to summary
        if (page.page_params.get_param("op") == PageOperation.TEST or \
             page.page_params.get_param("op") == PageOperation.TEST_PREV) and \
             context.c.session.get("history") and len(context.c.session.get("history")) >= Design_default.total_questions:
            page.page_params.set_param("op", PageOperation.SUMMARY)


        #Design_default.add_header(page)
        #Design_default.add_background(page)

        if page.page_params.get_param("op") == PageOperation.TEST or \
             page.page_params.get_param("op") == PageOperation.TEST_PREV:
            # Tests
            logging.debug("PageOperation.TEST - {}".format(page.page_params.get_param("root")))
            Design_default.render_menu(page)
            return Design_default.render_question_page(page)

        elif page.page_params.get_param("op") == PageOperation.SUMMARY:
            # Last page
            logging.debug("PageOperation.SUMMARY")
            Design_default.render_menu(page)
            Design_default.render_summary_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.INTRO:
            # Intro
            logging.debug("PageOperation.INTRO")
            Design_default.render_menu(page)
            Design_default.render_select_get_started_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.MENU_USER:
            # No user selected, first select user
            logging.debug("PageOperation.MENU - select user")
            Design_default.render_select_user_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.MENU_YEAR:
            # No year selected, select it
            logging.debug("PageOperation.MENU - year")
            Design_default.render_select_year_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.MENU_THEME:
            # No theme selected, select it
            logging.debug("PageOperation.MENU - theme")
            Design_default.render_menu(page)
            Design_default.render_select_theme_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.MENU_SUBTHEME:
            # No subtheme selected, select it
            logging.debug("PageOperation.MENU - subtheme")
            Design_default.render_menu(page)
            Design_default.render_select_subtheme_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.STATS:
            if user and user.domain_user_id:
                # TBD: old notation
                u_id = user.domain_user_id
                if len(u_id) >= len("local:") and u_id[:len("local:")] == "local:":
                    u_id = u_id[len("local:"):]
                Design_default.render_menu(page)
                Design_default.render_user_stats(page, u_id)
            else:
                logging.info("PageOperation.STATS - no user - select user")
                root = page.page_params.get_param("root")
                page.page_params.delete_params()
                page.page_params.set_param("root", root)
                page.page_params.set_param("op", PageOperation.MENU_USER)
                Design_default.render_select_year_page(page)
            return page.render()

        else:
            # Something mesed up the state - clean up the state and go to the intro
            logging.info("PageOperation.MENU - wrong parameters - select year")
            root = page.page_params.get_param("root")
            page.page_params.delete_params()
            page.page_params.set_param("root", root)
            page.page_params.set_param("op", PageOperation.MENU_YEAR)
            Design_default.render_select_year_page(page)
            return page.render()








    @staticmethod
    def add_menu(page):
        content = page.repository.get_content(PageLanguage.toStr(page.page_params.get_param("language")))
        page.template_params['menu'] = []

        #page.page_params.print_params()

        new_page_params = PageParameters()
        new_page_params.set_param("root", page.page_params.get_param("root"))
        new_page_params.set_param("op", PageOperation.MENU_YEAR)
        new_page_params.set_param("language", page.page_params.get_param("language"))

        menu_id = 0

        lists = {
            "name" : "Zadaci",
            "submenu" : {
                "id" : "zadaci_{}".format(menu_id),
                "options" : []
            }
        }
        menu_id = menu_id + 1

        for level in sorted(content.keys()):
            options = []

            for theme in sorted(content[level].keys()):
                options.append({
                    "name" : theme.title(),
                    "link" : new_page_params.create_url(\
                        op = PageOperation.toStr(PageOperation.MENU_SUBTHEME), \
                        year = level, \
                        theme = theme, \
                        js = False)
                })

            lists['submenu']['options'].append({
                "name" : level.title(),
                "link" : new_page_params.create_url( \
                        op = PageOperation.toStr(PageOperation.MENU_THEME), \
                        year = level, 
                        js = False),
                "submenu" : {
                    "id" : "zadaci_{}".format(menu_id),
                    "options" : options
                }
            })
            menu_id = menu_id + 1

        page.template_params['menu'].append(lists)

        page.template_params['menu'].append({
            "name" : "Rezultati",
            "link" : new_page_params.create_url(op = PageOperation.toStr(PageOperation.STATS), js = False)
        })

        page.template_params['menu'].append({
            "name" : "Izloguj se (" + context.c.user.name + ")",
            "link" : new_page_params.create_url(op = PageOperation.toStr(PageOperation.MENU_USER), js = False)
        })






    @staticmethod
    def render_select_user_page(page):

        page.page_params.delete_history()
        page.page_params.set_param("year", "")
        page.page_params.set_param("theme", "")
        page.page_params.set_param("subtheme", "")
        page.page_params.set_param("q_id", "")
        page.page_params.set_param("l_id", "")
        context.c.session.clear()
        context.c.user = None

        page.template_params["template_name"] = "user.html.j2"

        page.template_params["google_link"] = "/main?op={}".format(PageOperation['LOGIN_GOOGLE'].value)

        page.template_params["guest_link"] = page.page_params.create_url(
                                      op = PageOperation.toStr(PageOperation.LOGIN_ANON), 
                                      js = False)







    @staticmethod
    def render_select_year_page(page):
        page.page_params.delete_history()
        page.page_params.set_param("year", "")
        page.page_params.set_param("theme", "")
        page.page_params.set_param("subtheme", "")
        page.page_params.set_param("q_id", "")
        page.page_params.set_param("l_id", "")

        page.template_params["template_name"] = "year.html.j2"

        color_list = ["#ff6956", "#489cba", "#f7b500", "#6ab288"]

        years = ["1", "2", "3", "4", "5"]
        #ynumbers = [1, 2, 3, 4, 5, 6, 7, 8]
        ynumbers = [1, 2, 3, 4, 5]
        scale = 1

        width = int(137 * scale)
        height = int(140 * scale)
        font_size = int(111 * scale)
        margin = int(10 * scale)

        page.template_params['button'] = {
            'width' : '{}px'.format(width),
            'height' : '{}px'.format(height),
            'font_size' : '{}px'.format(font_size),
            'margin' : '{}px'.format(margin),
            'choices' : []
        }


        # Create dictionary entries that define menu
        Design_default.add_menu(page)



        for i in range(0, len(ynumbers)):

            razred = ynumbers[i]

            if i < len(years):
                page.template_params['button']['choices'].append({
                    'obj_type' : 'A',
                    'title' : razred,
                    'front_color' : color_list[i % len(color_list)],
                    'back_color' : '#f9f9f9',
                    'link' : page.page_params.create_url(
                        op = PageOperation.toStr(PageOperation.MENU_THEME),                         
                        year = years[i], \
                        theme = "", \
                        subtheme = "", \
                        period = "", \
                        difficulty = "", \
                        js = False)
                })
            else:
                page.template_params['button']['choices'].append({
                    'obj_type' : 'div',
                    'title' : razred,
                    'front_color' : "#999999",
                    'back_color' : '#f9f9f9',
                    'link' : ""
                })









    @staticmethod
    def render_select_theme_page(page):
        page.page_params.delete_history()
        page.page_params.set_param("theme", "")
        page.page_params.set_param("subtheme", "")
        page.page_params.set_param("q_id", "")
        page.page_params.set_param("l_id", "")

        content = page.repository.get_content(PageLanguage.toStr(page.page_params.get_param("language")))
        if content and page.page_params.get_param("year") in content.keys():
            
            page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            page.add_lines("<h3> {} razred - izaberi oblast</h3>\n".format(page.page_params.get_param("year").title()))
            page.add_lines("</div>\n")

            for theme in sorted(content[page.page_params.get_param("year")].keys()):
                page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
                page.add_lines("<a href='" + \
                        page.page_params.create_url(
                            op = PageOperation.toStr(PageOperation.MENU_SUBTHEME), 
                            theme = theme, \
                            subtheme = "", \
                            period = "", \
                            difficulty = "", \
                            js = False) + \
                        "'> " + theme.title() + "</a>\n")
                page.add_lines("</div>\n")

            page.add_lines("<br><br><div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            page.add_lines("<a href='" + \
                    page.page_params.create_url(
                        op = PageOperation.toStr(PageOperation.MENU_YEAR),                         
                        year = "", js = False) + \
                    "'> Nazad na izbor razreda</a>\n")
            page.add_lines("</div>\n")




    @staticmethod
    def render_select_subtheme_page(page):
        page.page_params.delete_history()
        page.page_params.set_param("subtheme", "")
        page.page_params.set_param("q_id", "")
        page.page_params.set_param("l_id", "")

        content = page.repository.get_content(PageLanguage.toStr(page.page_params.get_param("language")))
        if content and page.page_params.get_param("year") in content.keys() and \
                       page.page_params.get_param("theme") in content[page.page_params.get_param("year")].keys():
            
            page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            page.add_lines("<h3> {} razred, {} - izaberi temu</h3>\n".format(\
                page.page_params.get_param("year").title(), page.page_params.get_param("theme").title() ))
            page.add_lines("</div>\n")

            for subclass in sorted(content[page.page_params.get_param("year")][page.page_params.get_param("theme")].keys()):
                if not subclass == "name":
                    page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
                    page.add_lines("<a href='" + \
                            page.page_params.create_url(
                                op = PageOperation.toStr(PageOperation.INTRO), 
                                subtheme = content[page.page_params.get_param("year")][page.page_params.get_param("theme")][subclass]["subtheme"], 
                                period = content[page.page_params.get_param("year")][page.page_params.get_param("theme")][subclass]["period"], 
                                difficulty = content[page.page_params.get_param("year")][page.page_params.get_param("theme")][subclass]["difficulty"], 
                                l_id = content[page.page_params.get_param("year")][page.page_params.get_param("theme")]["name"], js = False) + \
                            "'> " + subclass.title() + "</a>\n")
                    page.add_lines("</div>\n")


            page.add_lines("<br><div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            page.add_lines("<a href='" + \
                    page.page_params.create_url(
                        op = PageOperation.toStr(PageOperation.INTRO), 
                        subtheme = "*", 
                        period = "*", 
                        difficulty = "*", 
                        l_id = content[page.page_params.get_param("year")][page.page_params.get_param("theme")]["name"], js = False) + \
                    "'> Supermix </a>\n")
            page.add_lines("</div>\n")

            page.add_lines("<br><br><div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            page.add_lines("<a href='" + \
                    page.page_params.create_url(
                        op = PageOperation.toStr(PageOperation.MENU_THEME), 
                        theme = "", js = False) + \
                    "'> Nazad na izbor oblasti</a>\n")
            page.add_lines("</div>\n")



    @staticmethod
    def render_select_get_started_page(page):
        page.page_params.delete_history()
        page.page_params.set_param("q_id", "")
        page.page_params.set_param("l_id", "")

        page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
        page.add_lines("<h3> {} razred, {}, {}|{}|{} - Pocetak </h3>\n".format(\
            page.page_params.get_param("year").title(), page.page_params.get_param("theme").title(), \
            page.page_params.get_param("subtheme").title(), page.page_params.get_param("period").title(), \
            page.page_params.get_param("difficulty").title() ))
        page.add_lines("<br>Neke zadatke ces resiti lakse ako spremis papir i olovku.\n")
        page.add_lines("<br>Kad uradis 10 zadataka bez greske, napravi pauzu.\n")
        page.add_lines("<br>Da predjes na sledeci zadatak ili da se vratis na prethodni, koristi trotinet.\n")
        page.add_lines("</div>\n")

        page.add_lines("<br><br><div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
        page.add_lines("<a href='" + \
                page.page_params.create_url(\
                    op = PageOperation.toStr(PageOperation.TEST), 
                    q_id = "", 
                    js = False) + \
                "'> Pocni</a>\n")
        page.add_lines("</div>\n")

        page.add_lines("<br><br><div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
        page.add_lines("<a href='" + \
                page.page_params.create_url(\
                    op = PageOperation.toStr(PageOperation.MENU_SUBTHEME), 
                    subtheme = "", 
                    period = "", 
                    difficulty = "", 
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
            if context.c.session.get("history"):
                page.add_lines("Tvoj rezultat po pitanjima:<br><br>\n")
                for r in context.c.session.get("history"):
                    page.add_lines("{}: tacno {}, netacno {} <br>\n".format(r["q_id"], r["correct"], r["incorrect"]))
                    correct = correct + int(r["correct"])
                    incorrect = incorrect + int(r["incorrect"])
                page.add_lines("<br> Ukupno tacno {}/{} ({} %):<br><br>\n", 
                    correct, correct + incorrect, correct / (correct + incorrect))
        except:
            pass
        page.add_lines("</div>\n")

        page.page_params.delete_history()
        page.page_params.set_param("q_id", "")
        page.page_params.set_param("l_id", "")

        page.add_lines("<a href='" + \
                page.page_params.create_url(op=PageOperation.toStr(PageOperation.MENU_SUBTHEME), \
                                            year=page.page_params.get_param("year"), \
                                            theme = "", \
                                            subtheme = "", \
                                            difficulty = "", \
                                            period = "", \
                                            js=False) + \
                "'> Nazad na izbor teme </a>\n")
        return page.render()




    @staticmethod
    def render_question_page(page):

        next_question = None
        test = Test(page)


        if page.page_params.get_param("op") == PageOperation.TEST_PREV:
            if len(context.c.session.get("history")) <= 1:
                logging.warning("We shouldn't have offered a back link when there is no history.")
                next_question = context.c.session.get("history")[-1]["q_id"]
            else:
                context.c.session.list_delete("history", -1)
                next_question = context.c.session.get("history")[-1]["q_id"]
        else: 
            # At the moment every new PageOperation.TEST is a new question
            # A user can hit refresh, but this will get her/him to the next question
            # This may be avoided if POST is used instead of GET where there will be a warning

            # elif not context.c.session.get("history") or len(context.c.session.get("history")) == 0 or \
            #     not context.c.session.get("history")[-1]["url"] == page.page_params.get_url():
            #     # Not a simple page refresh, update history

            if not context.c.session.get("history") or len(context.c.session.get("history")) == 0:
                # Starting a new test, record the start time in epoch seconds
                context.c.session.set("test_id", int(time.time()*1000))

            next_question = test.choose_next_question()
            context.c.session.list_append("history", {
                "url" : page.page_params.get_url(),
                "q_id" : next_question,
                "correct" : 0, 
                "incorrect" : 0
            })

        # context.c.session.print()

        page.page_params.set_param("q_id", next_question)
        test_id = context.c.session.get("test_id")
        test_order = len(context.c.session.get("history"))
        q = Question(page=page, q_id=next_question, test_id=test_id, test_order=test_order)
        q.set_from_file_with_exception()
        q.eval_with_exception()



        Design_default.add_buttons(page)
        if page.page_params.get_param("root") == "main":
            correct = 0
            incorrect = 0

            if context.c.session.get("history"):
                for r in context.c.session.get("history"):
                    correct = correct + int(r["correct"])
                    incorrect = incorrect + int(r["incorrect"])

            current_q_number = len(context.c.session.get("history"))
            page.add_lines("<br><br><div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            page.add_lines("Pitanje {} od 3\n".format(current_q_number))
            page.add_lines("Do sada: {} / {}".format(correct, incorrect))
            page.add_lines("</div>\n")
        return page.render()
                    




    # Inspired by https://www.w3schools.com/w3css/w3css_sidebar.asp

    @staticmethod
    def render_menu(page):

        # For now remove the language menu
        show_language_menu = True


        page.add_lines("\n\n<!-- MOBILE MENU START -->\n")



        page.add_script_lines("""
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

                <style>
                .sh-font{font-family: 'Bubblegum Sans'; font-size: 18px; color: #029194}
                .sh-button{border:none;display:inline-block;padding:8px 16px;vertical-align:middle;overflow:hidden;text-decoration:none;background-color:white;text-align:center;cursor:pointer;white-space:nowrap}
                .sh-button{-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none}   
                .sh-button-arrow{border:none;display:inline-block;padding:8px 0px 8px 0px;vertical-align:middle;overflow:hidden;text-decoration:none;background-color:white;text-align:center;cursor:pointer;white-space:nowrap}
                .sh-button-arrow{-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none}   
                .sh-border-left{border-left:1px solid #ccc!important}
                .sh-sidebar{height:100%;width:200px;background-color:#fff;position:fixed!important;z-index:1;overflow:auto}
                .sh-left-align{text-align:left!important}
                .sh-right-align{text-align:right!important}
                .sh-block{display:block;width:100%}
                .sh-card{box-shadow:0 2px 5px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)}
                .sh-hide{display:none!important}
                .sh-show{display:block!important}
                .sh-green{color:#fff!important;background-color:#4CAF50!important}
                .sh-bar .sh-bar-item{padding:8px 16px;float:left;width:auto;border:none;display:block;outline:0}
                .sh-bar .sh-dropdown-hover,.sh-bar .sh-dropdown-click{position:static;float:left}
                .sh-bar .sh-button{white-space:normal}
                .sh-bar-block .sh-bar-item{width:100%;display:block;padding:8px 16px;text-align:left;border:none;white-space:normal;float:none;outline:0}
                .sh-bar-block .sh-center .sh-bar-item{text-align:center}.sh-block{display:block;width:100%}
                </style>
                """)

        page.add_lines("""
            <script>
            function myAccFunc(title) {
                var x = document.getElementById(title);
                if (x.className.indexOf("sh-show") == -1) {
                x.className += " sh-show";
                //x.previousElementSibling.className += " sh-green";
                } else { 
                x.className = x.className.replace(" sh-show", "");
                //x.previousElementSibling.className = x.previousElementSibling.className.replace(" sh-green", "");
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
        """)


        str_lang = ""

        if show_language_menu:
            try:
                str_lang = "<button class=\"sh-button sh-dark-grey sh-large sh-font\" " + \
                    "style=\"padding: 0px; display: table-cell; vertical-align: middle; text-align: center; height: 20px; \" " +\
                    "onclick=\"shl_toggle()\">" + \
                    "<input type=\"image\" style=\"padding: 0px\" width=\"36px\" height=\"20px\" alt=\"" + \
                        page.get_language_details()["country"] + \
                        "\" src=\"" + \
                        page.get_file_url("images/" + 
                        page.get_language_details()["image"]) + "\" /></button>" 
            except:
                logging.error("config.json file has a formatting error.")
                str_lang = ""
                show_language_menu = False



        page.add_script_lines("""
            <div>
                <div class="sh-button" style="font-family: 'Bubblegum Sans'; font-size: 24px; color: #029194"> TATA MATA </div> 
                <span width="70px" style='display:table;float:right;'> 
                    """ + str_lang + """
                    <button class="sh-button" style="display: table-cell; vertical-align: middle; text-align: center;padding: 8px 8px; font-size: 20px; font-weight: 900; color: #029194" onclick="shm_toggle()">☰</button>
                </span>
            </div>

            <div class="sh-sidebar sh-bar-block sh-border-left" style="width:200px;right:0;display:none" id="shMenu">
                <button class="sh-button sh-block sh-left-align sh-font" onclick="myAccFunc('accLevel')">
                    """ + page.get_messages()["questions"] + """ <i class="fa fa-caret-down"></i>
                </button>
                <div id='accLevel' class="sh-hide sh-white sh-card">
        """)


        new_page_params = PageParameters()
        new_page_params.set_param("root", page.page_params.get_param("root"))
        new_page_params.set_param("op", PageOperation.MENU_YEAR)
        new_page_params.set_param("language", page.page_params.get_param("language"))
        Design_default.render_menu_drop(page, new_page_params, 1)

        # Design_default.render_menu_drop(page, PageLanguage.toStr(page.page_params.get_param("language")), 
        #     page.page_params.get_param("root") + "?op={}&language={}&menu={}".format(
        #     PageOperation.toStr(page.page_params.get_param("op")), PageLanguage.toStr(page.page_params.get_param("language")), 
        #     "mobile"), 1)



        page.add_lines("""
                </div>
        """)

        user = context.c.user

        if user and user.domain_user_id and not user.domain_user_id == "UNKNOWN":
            new_params = PageParameters()
            new_page_params.set_param("root", page.page_params.get_param("root"))
            page.add_lines("<a class=\"sh-button sh-block sh-left-align sh-font\" href=\"" + \
                new_params.create_url(op = PageOperation.toStr(PageOperation.STATS), js = False) + \
                "\" class=\"sh-bar-item sh-button\"> Rezultati </a>\n")


        # page.add_lines("""
        #         <button class="sh-button sh-block sh-left-align sh-font" onclick="myAccFunc('accUser')">
        #             """ + page.get_messages()["user"] + """ <i class="fa fa-caret-down"></i>
        #         </button>
        #         <div id='accUser' class="sh-hide sh-white sh-card">
        # """)

        # page.add_lines(Design_default.get_login_header(page))

        # page.add_lines("""
        #         </div>
        #     </div>
        # """)


        new_params = PageParameters()
        new_page_params.set_param("root", page.page_params.get_param("root"))
        if not context.c.user:
            page.add_lines("<a class=\"sh-button sh-block sh-left-align sh-font\" href=\"" + \
                new_params.create_url(op = PageOperation.toStr(PageOperation.MENU_USER), js = False) + \
                "\"> Uloguj se </a>\n")
        else:
            page.add_lines("<a class=\"sh-button sh-block sh-left-align sh-font\" href=\"" + \
                        new_params.create_url(op = PageOperation.toStr(PageOperation.MENU_USER), js = False) + \
                        "\"> Izloguj se (" + context.c.user.name + ")</a>\n")

        page.add_lines("</div>")


        if show_language_menu:
            lang_select = """
                        <div class="sh-sidebar sh-bar-block sh-border-left" style="width:200px;right:0;display:none"  id="shLang">
                        """
            for lang in page.get_language_list():
                lang_select = lang_select + "<div align='left' style='display:table; padding: 8px 8px;'>\n"
                # lang_select = lang_select + "<input style=\"display: inline-block;padding: 8px 0px;\" height=\"20px\" type=\"image\" src=\"" + \
                #         page.get_file_url("images/" + \
                #         page.get_language_details(lang)["image"]) + "\" />\n"
                lang_select = lang_select + "<a class=\"sh-font\" style=\"display: table-cell; vertical-align: middle; text-align: center;\" href='" + \
                        page.page_params.create_url( \
                            op = PageOperation.toStr(PageOperation.MENU_YEAR), language = lang, js = False) + \
                        "' class='sh-bar-item sh-button'>" + \
                        "<img style=\"display: inline-block;padding: 0px;\" height=\"20px\" width=\"36px\" src=\"" + \
                            page.get_file_url("images/" + \
                            page.get_language_details(lang)["image"]) + "\"></a>  &nbsp \n"
                lang_select = lang_select + "<a class=\"sh-font\" style=\"display: table-cell; vertical-align: middle; text-align: center;\" href='" + \
                        page.page_params.create_url( \
                            op = PageOperation.toStr(PageOperation.MENU_YEAR), language = lang, js = False) + \
                        "' class='sh-bar-item sh-button'>" + page.get_language_details(lang)["country"] + "</a>\n"
                lang_select = lang_select + "</div>\n"
            
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
        content = page.repository.get_content(PageLanguage.toStr(page.page_params.get_param("language")))

        # new_page_params.print_params()

        str_indent1 = ""
        for i in range(0, indent):
            str_indent1 = str_indent1 + "<div class='space'></div>"
        str_indent2 = str_indent1 + "<div class='space'></div>"

        for level in sorted(content.keys()):
            page.add_lines(\
                "<a class=\"sh-font\" href=\"" + new_page_params.create_url( \
                        op = PageOperation.toStr(PageOperation.MENU_THEME), \
                        year = level, 
                        js = False) + \
                    "\" style='padding: 8px 0px 8px 16px ; text-decoration:none'> " + \
                    str_indent1 + level.title() + "</a>" + \
                """
                    <button class="sh-button-arrow sh-left-align sh-font" onclick="myAccFunc('acc""" + level + """')">
                    """ +  """ <i class="fa fa-caret-down"></i>
                    </button>
                    <div id='acc""" + level + """' class="sh-hide sh-white sh-card">
                """)

            for theme in sorted(content[level].keys()):
                page.add_lines("<a href=\"" + new_page_params.create_url(\
                        op = PageOperation.toStr(PageOperation.MENU_SUBTHEME), \
                        year = level, \
                        theme = theme, \
                        js = False) + \
                    "\" class=\"sh-bar-item sh-button sh-font\"> " + str_indent2 + theme.title() + "</a>\n")

            page.add_lines("</div>")
            
            page.add_lines("<br>")






    # @staticmethod    
    # def get_login_header(page):
    #     login_str = ""

    #     login_return = page.page_params.all_state
    #     login_return["js"] = False
    #     login_return = encode_dict(login_return)

    #     login_str = ""
    #     for username in sorted(TEST_USERS):
    #         link = page.page_params.get_param("root") + "?op=login_test&" + "login_return=" + \
    #                     login_return + "&user_id={}".format(username)
    #         str_indent = "<div class='space'></div>"
    #         login_str = login_str + "<a href='" + link + "' class='w3-bar-item w3-button'> " + str_indent + username + "</a>\n"

    #     return login_str




    @staticmethod
    def add_popup(page, name, inner_html, extra_style=""):
        page.add_lines("\n\n<!-- POPUP {} START -->\n\n".format(name))

        page.add_lines("<span id='popup_" + name + "' style='visibility: hidden;"
            "position: fixed; z-index: 1; bottom: 50%;" 
            "left: 50%; transform: translate(-50%, 0%);")
        page.add_lines(extra_style)
        page.add_lines("'>")

        page.add_lines(inner_html)

        page.add_lines("</span>")        

        page.add_lines("""
            <script>
                // When the user clicks on div, open the popup
                function popup_toggle_""" + name + """() {
                    var popup = document.getElementById("popup_"""+ name + """");
                    if (popup.style.visibility == "hidden") { 
                        popup.style.visibility = "visible";
                    } else {
                        popup.style.visibility = "hidden";
                    }
                }
            </script>
            """
        )

        page.add_lines("\n\n<!-- POPUP {} END -->\n\n".format(name))



    @staticmethod    
    def add_buttons(page):
        page.add_lines("\n\n<!-- QUESTIONS START -->\n\n")
        page.add_lines("<div id='question' style='display:table; margin:0 auto;'>\n")
        page.add_lines("\n<div id='question_buttons' style='display:block;text-align:center;padding-top:20px;padding-bottom:6px'>\n")


        if context.c.session.get("history"):
            q_number = len(context.c.session.get("history"))
        else:
            q_number = 0


        # if q_number >= 2:
        #     url_prev = page.page_params.create_url(\
        #                 op = PageOperation.toStr(PageOperation.TEST_PREV), 
        #                 js = False)
        # else:
        #     url_prev = page.page_params.create_url(\
        #                 op = PageOperation.toStr(PageOperation.INTRO), 
        #                 js = False)
        #

        if q_number >= Design_default.total_questions:
            url_next = page.page_params.create_url( 
                op=encap_str(PageOperation.toStr(PageOperation.SUMMARY)),
                js=True)
        else:
            url_next = page.page_params.create_url( 
                op=encap_str(PageOperation.toStr(PageOperation.TEST)),
                js=True)


        # Not needed in the current design

        # page.add_lines("\n\n<!-- PREV BUTTON -->\n")
        # page.add_lines("\n<input id='but_prev' type='button' style='font-size: 14px;' "\
        #     "onclick='window.location.replace(\"{}\")' value='{}' />\n".format(url_prev, "Nazad"))
        # page.add_lines("\n<!-- END PREV BUTTON -->\n\n")



        page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")        
        page.add_lines("\n<!-- CLEAR BUTTON -->\n")
        page.add_lines("\n<input id='but_clear' type='button' style='font-size: 14px;' onclick=\"clearAll()\" value='{}' />\n".format(
            page.get_messages()["clear"]))
        page.add_lines("\n<!-- END CLEAR BUTTON -->\n")


        # page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
        # page.add_lines("\n\n<!-- CHECK BUTTON -->\n")
        # page.add_lines("<input type='button' style='font-size: 14px;' onclick='{}' value='{}'/>\n".format(
        #     Design_default.on_click(page, \
        #         operation=ResponseOperation.SUBMIT, \
        #         record=True), page.get_messages()["check"]))
        # page.add_lines("\n<!-- END CHECK BUTTONS -->\n")


        page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")        
        page.add_lines("\n\n<!-- CHECK BUTTON -->\n")
        page.add_lines("<input id='but_check' type='button' style='font-size: 14px;' onclick='{}' value='{}'/>\n".format(
            Design_default.on_click(page, \
                operation=ResponseOperation.SUBMIT, \
                url_next=url_next, \
                quoted=False, \
                record=True), page.get_messages()["check"]))
        page.add_lines("\n<!-- END CHECK BUTTON -->\n")


        page.add_lines("\n\n<!-- NEXT BUTTON -->\n")
        page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
        page.add_lines("\n<input id='but_next' type='button' style='display:none; font-size: 14px;' onclick='{}' value='{}' />\n".format(
            Design_default.on_click(page, \
                operation=ResponseOperation.SKIP, \
                url_next=url_next, \
                quoted=False, \
                record=True), page.get_messages()["skip"]))
        page.add_lines("\n<!-- END NEXT BUTTON -->\n\n")
            



        page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
        
        page.add_lines("\n<!-- SOLUTION BUTTON -->\n")
        page.add_lines("\n<input id='but_help' type='button' style='display:none; font-size: 14px;' " \
            "onclick=\"clearAll();addSolutionAll();"
            "document.getElementById('but_check').style.display='none';"
            "document.getElementById('but_help').style.display='none';"
            "document.getElementById('but_clear').style.display='none';"
            "document.getElementById('but_next').value='Dalje';"
            "\" value='{}' />\n".format(
            "Resenje"))
        page.add_lines("\n<!-- END SOLUTION BUTTON -->\n")




        page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
        
        page.add_lines("\n<!-- FEEDBACK BUTTON -->\n")

        inner_html = "<h3> Unesite detalje komentara</h3>\n"
        #inner_html = inner_html + "<form action='javascript:void(0);'>\n"
        inner_html = inner_html + "Mislite da zadatak: <br>"
        inner_html = inner_html + "<input type='radio' id='fb_problem'> Ima problem <br>"
        inner_html = inner_html + "<input type='radio' id='fb_unclear'> Nije jasan <br>"
        inner_html = inner_html + "<input type='radio' id='fb_difficult'> Pretezak <br>"
        inner_html = inner_html + "<input type='radio' id='fb_easy'> Prelak <br>"
        inner_html = inner_html + "<input type='radio' id='fb_other'> Drugo <br> "
        inner_html = inner_html + "<br> Dodatni komentar: <br><input type='text' id='fb_komentar'> <br> <br>"
        inner_html = inner_html + "\n<input align='center' type='button' style='font-size: 14px;' " \
            "onclick=\"sendFeedbackToServer('{}', {}, '{}', '{}', {}); " \
                "popup_toggle_feedback_report(); " \
                "document.getElementById('but_fb').style.display='none';" \
                "\" value='{}' />\n".format(
            page.page_params.get_param("root"), 
            "document.getElementById('fb_problem').checked?'problem':(" \
                "document.getElementById('fb_unclear').checked?'unclear':(" \
                "document.getElementById('fb_difficult').checked?'unclear':(" \
                "document.getElementById('fb_easy').checked?'unclear':'other')))",
            page.page_params.get_param("q_id"),
            page.page_params.get_param("l_id"),
            "document.getElementById('fb_komentar').value",
            "Posalji prijavu")
        # Add gap:
        inner_html = inner_html + "<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>"
        inner_html = inner_html + "\n<input align='center' type='button' style='font-size: 14px;' " \
            "onclick=\"popup_toggle_feedback_report();\" value='{}' />\n".format("Odustani")

        extra_style = "width: 300px; background-color: #555; color: #fff; text-align: center; border-radius: 6px; padding: 8px;"

        Design_default.add_popup(page, "feedback_report", inner_html, extra_style)

        page.add_lines("\n<input id='but_fb' type='button' style='font-size: 14px;' onclick=\"popup_toggle_feedback_report()\" value='{}' />\n".format(
            "Prijavi problem"))

        page.add_lines("\n<!-- END FEEDBACK BUTTON -->\n")




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




    @staticmethod
    def on_click(page, operation:ResponseOperation=None, url_next=None, record=False, quoted=True):
        if record:
            # Only send results to server if next_url specified (i.e. we are in the test mode)
            ret_str = 'cond = checkAll("{}", "{}", "{}", "{}");'.format(
                ResponseOperation.toStr(operation),
                page.page_params.get_param("root"),
                page.page_params.get_param("q_id"),
                page.page_params.get_param("l_id")
            )
        else:
            ret_str = "cond = checkAll();"

        if url_next is not None:
            if operation == ResponseOperation.SUBMIT:
                ret_str = ret_str + "if (cond) "
            if quoted:
                ret_str = ret_str + " {window.location.replace(\"" + url_next + "\");}"
            else:
                ret_str = ret_str + " {window.location.replace(" + url_next + ");}"
            if operation == ResponseOperation.SUBMIT:
                ret_str = ret_str + \
                    "else {document.getElementById(\"but_help\").style.display=\"inline-block\"; " \
                    "document.getElementById(\"but_next\").style.display=\"inline-block\"; }"

        return ret_str



