# import json

# from server.helpers import encap_str

import re
from server.types import PageLanguage
from server.types import PageOperation
# from server.types import ResponseOperation
from server.types import PageParameters

from server.test import Test
from server.question import Question
# from server.stats import Stats

from server.stat_charts import prepare_user_stats_chart

import server.helpers as helpers
import server.context as context
from server.timers import timer_section

import logging

USE_GOOGLE_AUTH = True


class Design_default(object):
    total_questions = 5

    @staticmethod
    @timer_section("render_main_page")
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

        if page.page_params.get_param("op") == PageOperation.LOGOUT:
            new_url = page.logout()
            context.c.headers.redirect(new_url)
            return ""

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
            Design_default.render_question_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.SUMMARY:
            # Last page
            logging.debug("PageOperation.SUMMARY")
            Design_default.render_summary_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.CONFIRM_ANON:
            # Confirm anonymous login
            logging.debug("PageOperation.CONFIRM_ANON")
            Design_default.render_confirm_anon_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.INTRO:
            # Intro
            logging.debug("PageOperation.INTRO")
            context.c.session.set("showed_intro", True)
            Design_default.render_select_get_started_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.MENU_USER and not context.c.user:
            # If user is already logged in, we cannot do login again
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
            Design_default.render_select_theme_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.STATS:
            if user and user.user_id:
                # Full user id (e.g. google:XXXX)
                u_id = user.user_id

                # TBD: old notation for local tests - remove "local:" if present
                if len(u_id) >= len("local:") and u_id[:len("local:")] == "local:":
                    u_id = u_id[len("local:"):]
                Design_default.render_user_stats(page, u_id)

            else:
                logging.info("PageOperation.STATS - no user - select user")
                root = page.page_params.get_param("root")
                page.page_params.delete_params()
                page.page_params.set_param("root", root)
                page.page_params.set_param("op", PageOperation.MENU_USER)
                Design_default.render_select_year_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.ABOUT:
            Design_default.render_about(page)
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
    @timer_section("add_menu")
    def add_menu(page):
        content = page.repository.get_content(PageLanguage.toStr(page.page_params.get_param("language")))
        page.template_params['menu'] = []

        #page.page_params.print_params()

        new_page_params = PageParameters()
        new_page_params.set_param("root", page.page_params.get_param("root"))
        new_page_params.set_param("op", PageOperation.MENU_YEAR)
        new_page_params.set_param("language", page.page_params.get_param("language"))

        user_picture = context.c.session.get("user_picture")
        if not user_picture is None:
            page.template_params["user_picture"] = user_picture
            page.template_params["user_name"] = context.c.session.get("user_name")



        sublang = []
        for lang in page.get_language_list():
            sublang.append({
                "name" : "<input type=\"image\" style=\"padding: 0px\" width=\"27px\" "
                    "height=\"15px\" alt=\"" + page.get_language_details(lang)["country"] + 
                    "\" src=\"" + page.get_file_url("images/" + 
                                  page.get_language_details(lang)["image"]) + "\"> &nbsp; " + 
                                  page.get_language_details(lang)["country"],
                "link" : page.page_params.create_url( \
                            op = PageOperation.toStr(PageOperation.MENU_YEAR), 
                            beta = True if page.page_params.get_param("beta") else None, 
                            language = lang, js = False)
            })            

        # Jezik: &nbsp; 
        lang = {
            "name" : "<input type=\"image\" style=\"padding: 0px\" width=\"27px\" "
                    "height=\"15px\" alt=\"" + page.get_language_details()["country"] + 
                    "\" src=\"" + page.get_file_url("images/" + 
                                  page.get_language_details()["image"]) + "\">",
            "submenu" : {
                "id" : "lang",
                "options" : sublang
            }
        }
        page.template_params['menu'].append(lang)


        menu_id = 0

        lists = {
            "name" : "Razred".upper(),
            "link" : new_page_params.create_url(\
                    op = PageOperation.toStr(PageOperation.MENU_YEAR), \
                    beta = True if page.page_params.get_param("beta") else None, 
                    js = False),
            "submenu" : {
                "id" : "zadaci_{}".format(menu_id),
                "options" : []
            }
        }
        menu_id = menu_id + 1

        for level in sorted(content.keys()):
            # options = []
            # for theme in sorted(content[level].keys()):
            #     if not theme == "level_short":
            #         options.append({
            #             "name" : theme.upper(),
            #             "link" : new_page_params.create_url(\
            #                 op = PageOperation.toStr(PageOperation.INTRO), \
            #                 year = level, \
            #                 theme = theme, \
            #                 subtheme = "*", \
            #                 topic = "*", \
            #                 period = "*", \
            #                 difficulty = "*", \
            #                 l_id = content[level][theme]["name"], \
            #                 js = False)
            #         })

            # Year 5+ are not complete so we only show in beta mode
            if int(level) <= 4 or page.page_params.get_param("beta"): 
                lists['submenu']['options'].append({
                    "name" : level.upper(),
                    "link" : new_page_params.create_url( \
                            op = PageOperation.toStr(PageOperation.MENU_THEME), \
                            year = level, 
                            beta = True if page.page_params.get_param("beta") else None, 
                            js = False)
                    #         js = False),
                    # "submenu" : {
                    #     "id" : "zadaci_{}".format(menu_id),
                    #     "options" : options
                    # }
                })
                menu_id = menu_id + 1

        page.template_params['menu'].append(lists)

        # Do not show results to an anonymous user
        if not user_picture is None:
            page.template_params['menu'].append({
                "name" : "Moj uspeh".upper(),
                "link" : new_page_params.create_url(
                    op = PageOperation.toStr(PageOperation.STATS), 
                    beta = True if page.page_params.get_param("beta") else None, 
                    js = False
                )
            })

        # "name" : "Izloguj se (" + context.c.user.name + ")",
        page.template_params['menu'].append({
            "name" : "Izloguj se".upper(),
            "link" : new_page_params.create_url(
                op = PageOperation.LOGOUT.value, 
                beta = True if page.page_params.get_param("beta") else None, 
                js = False
            )
        })






    @staticmethod
    @timer_section("render_select_user_page")
    def render_select_user_page(page):

        page.page_params.delete_history()
        page.page_params.set_param("year", "")
        page.page_params.set_param("theme", "")
        page.page_params.set_param("subtheme", "")
        page.page_params.set_param("topic", "")
        page.page_params.set_param("q_id", "")
        page.page_params.set_param("l_id", "")

        page.template_params["template_name"] = "user.html.j2"

        page.template_params["h1"] = "Login"

        page.template_params['current_lang'] = \
            "<input type=\"image\" style=\"padding: 0px\" width=\"27px\" " \
                "height=\"15px\" alt=\"" + page.get_language_details()["country"] + \
                "\" src=\"" + page.get_file_url("images/" + \
                                page.get_language_details()["image"]) + "\">"

        sublang = []
        for lang in page.get_language_list():
            sublang.append({
                "name" : "<input type=\"image\" style=\"padding: 0px\" width=\"27px\" "
                    "height=\"15px\" alt=\"" + page.get_language_details(lang)["country"] + 
                    "\" src=\"" + page.get_file_url("images/" + 
                                  page.get_language_details(lang)["image"]) + "\"> &nbsp; " + 
                                  page.get_language_details(lang)["country"],
                "link" : page.page_params.create_url(
                    op = PageOperation.toStr(PageOperation.MENU_USER), 
                    language = lang, 
                    beta = True if page.page_params.get_param("beta") else None, 
                    js = False
                )
            })            

        page.template_params['menu_lang'] = sublang



        page.template_params["google_link"] = "/main?op={}".format(PageOperation['LOGIN_GOOGLE'].value)

        page.template_params["guest_link"] = page.page_params.create_url(
                                    op = PageOperation.toStr(PageOperation.LOGIN_ANON), 
                                    beta = True if page.page_params.get_param("beta") else None, 
                                    js = False)







    @staticmethod
    @timer_section("render_select_year_page")
    def render_select_year_page(page):
        page.page_params.delete_history()
        page.page_params.set_param("year", "")
        page.page_params.set_param("theme", "")
        page.page_params.set_param("subtheme", "")
        page.page_params.set_param("topic", "")
        page.page_params.set_param("q_id", "")
        page.page_params.set_param("l_id", "")

        page.template_params["template_name"] = "year.html.j2"

        page.template_params["h1"] = "Izaberi godinu"


        content = page.repository.get_content(PageLanguage.toStr(page.page_params.get_param("language")))

        if content :

            color_list = ["#ff6956", "#489cba", "#f7b500", "#6ab288"]


            #ordered = collections.OrderedDict()
            ordered = {}
            for year in content.keys():
                ordered[content[year]["level_short"]] = year


            scale = 1
            width = int(137 * scale)
            height = int(140 * scale)
            font_size = int(111 * scale)
            # margin = int(10 * scale)

            page.template_params['button'] = {
                'width' : '{}px'.format(width),
                'height' : '{}px'.format(height),
                'font_size' : '{}px'.format(font_size),
                'choices' : []
            }


            # Create dictionary entries that define menu
            Design_default.add_menu(page)

            i = 0
            for ynumber in sorted(ordered.keys()):

                # Year 5+ are not complete so we only show in beta mode
                if int(ordered[ynumber]) <= 4 or page.page_params.get_param("beta"): 
                    year = ordered[ynumber]

                    page.template_params['button']['choices'].append({
                        'title' : ynumber,
                        'front_color' : color_list[i % len(color_list)],
                        #'back_color' : '#f9f9f9',
                        'back_color' : '#ffffff',
                        'link' : page.page_params.create_url(
                            op = PageOperation.toStr(PageOperation.MENU_THEME),                         
                            year = year, \
                            theme = "", \
                            subtheme = "", \
                            topic = "", \
                            period = "", \
                            difficulty = "", \
                            beta = True if page.page_params.get_param("beta") else None, 
                            js = False)
                    })
                    i = i+1

        else:
            page.template_params["template_name"] = "error.html.j2"
            page.template_params["error_msg"] = "No content"




    @staticmethod
    def _next_theme_url(page, theme, subtheme, topic, period, difficulty, l_id):
        # Only show intro once per login 
        if context.c.session.get("showed_intro"):
            page.page_params.set_param("theme", theme)
            page.page_params.set_param("subtheme", subtheme)
            page.page_params.set_param("topic", topic)
            page.page_params.set_param("period", period)
            page.page_params.set_param("difficulty", difficulty)
            page.page_params.set_param("l_id", l_id)

            test = Test(page)
            url_next, url_skip = test.get_next_question_url(Design_default.total_questions)

        else:
            url_next = page.page_params.create_url(
                    op = PageOperation.toStr(PageOperation.INTRO), 
                    theme = theme, 
                    subtheme = subtheme, 
                    topic = topic, 
                    period = period, 
                    difficulty = difficulty, 
                    beta = True if page.page_params.get_param("beta") else None, 
                    l_id = l_id)

        return url_next




    @staticmethod
    @timer_section("render_select_theme_page")
    def render_select_theme_page(page):
        page.page_params.delete_history()
        page.page_params.set_param("theme", "")
        page.page_params.set_param("subtheme", "")
        page.page_params.set_param("topic", "")
        page.page_params.set_param("q_id", "")
        page.page_params.set_param("l_id", "")

        # Create dictionary entries that define menu
        Design_default.add_menu(page)


        content = page.repository.get_content(PageLanguage.toStr(page.page_params.get_param("language")))
        icons = page.repository.get_icons()

        icon_cnt = 0

        if content and page.page_params.get_param("year") in content.keys():
            
            page.template_params["template_name"] = "theme.html.j2"

            page.template_params['year'] = page.page_params.get_param("year").upper().strip()
            page.template_params['url_year'] = page.page_params.create_url(
                                            op = PageOperation.toStr(PageOperation.MENU_YEAR), 
                                            beta = True if page.page_params.get_param("beta") else None, 
                                            js = False)

            page.template_params['themes'] = []

            page.template_params["h1"] = page.template_params['year']
            page.template_params["h2"] = "Izaberi temu"

            # page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            # page.add_lines("<h3> {} razred - izaberi oblast</h3>\n".format(page.page_params.get_param("year").title()))
            # page.add_lines("</div>\n")

            for theme in sorted(content[page.page_params.get_param("year")].keys()):

                if not theme == "level_short": 
                    subtheme_list = []
                    subtheme_dict = dict()

                    for subclass in sorted(content[page.page_params.get_param("year")][theme].keys()):
                        if not subclass == "name":
                            subtheme = content[page.page_params.get_param("year")][theme][subclass]["subtheme"].strip()
                            topic = content[page.page_params.get_param("year")][theme][subclass]["topic"].strip()
                            rank_subtheme = content[page.page_params.get_param("year")][theme][subclass]["rank_subtheme"].strip()
                            rank_topic = content[page.page_params.get_param("year")][theme][subclass]["rank_topic"].strip()
                            period = content[page.page_params.get_param("year")][theme][subclass]["period"]
                            if subtheme not in subtheme_dict.keys():
                                try:
                                    icon_svg = icons[subtheme.strip().lower()]
                                    # Different SVGs can have same path IDs (e.g. created in the same program)
                                    # So we change names here
                                    
                                    #icon_svg = re.sub(r'id="(.*?)"', 'id="\\1_R_{}"'.format(icon_cnt), icon_svg)
                                    icon_svg = re.sub(r'cls-(.)', 'cld-\\1_R_{}'.format(icon_cnt), icon_svg)
                                    icon_cnt = icon_cnt + 1
                                except:
                                    icon_svg = ""

                                subtheme_d = {
                                    'title' : subtheme.capitalize(),
                                    'icon' : icon_svg, 
                                    'rank_subtheme' : rank_subtheme,
                                    'topics' : [],
                                    'topics_dir' : {},
                                    'min_period' : period,
                                    'link' : Design_default._next_theme_url(
                                            page = page, 
                                            theme = theme.title().strip(), 
                                            subtheme = subtheme, 
                                            topic = "*", 
                                            period = "*", 
                                            difficulty = "*", 
                                            l_id = content[page.page_params.get_param("year")][theme]["name"])
                                }
                                subtheme_dict[subtheme] = subtheme_d
                                subtheme_list.append(subtheme_d)

                                topic_d = {
                                    'title' : "Sve teme",
                                    'rank_topic' : "0",
                                    'min_period' : "0",
                                    'link' : Design_default._next_theme_url(
                                            page = page, 
                                            theme = theme.title().strip(), 
                                            subtheme = subtheme, 
                                            topic = "*", 
                                            period = "*", 
                                            difficulty = "*", 
                                            l_id = content[page.page_params.get_param("year")][theme]["name"])
                                }
                                subtheme_d['topics_dir']["all"] = topic_d
                                subtheme_d['topics'].append(topic_d)


                            else:
                                subtheme_d = subtheme_dict[subtheme]

                            if topic not in subtheme_d['topics_dir'].keys():
                                topic_d = {
                                    'title' : topic.capitalize(),
                                    'rank_topic' : rank_topic,
                                    'min_period' : period,
                                    'link' : Design_default._next_theme_url(
                                            page = page, 
                                            theme = theme.title().strip(), 
                                            subtheme = subtheme, 
                                            topic = topic, 
                                            period = "*", 
                                            difficulty = "*", 
                                            l_id = content[page.page_params.get_param("year")][theme]["name"])
                                }
                                subtheme_d['topics_dir'][topic] = topic_d
                                subtheme_d['topics'].append(topic_d)
                            else:
                                topic_d = subtheme_d['topics_dir'][topic]

                            subtheme_d['min_period'] = period if period < subtheme_d['min_period'] else subtheme_d['min_period']
                            topic_d['min_period'] = period if period < topic_d['min_period'] else topic_d['min_period']


                            # page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
                            # page.add_lines("<a href='" + \
                            #         page.page_params.create_url(
                            #             op = PageOperation.toStr(PageOperation.INTRO), 
                            #             subtheme = content[page.page_params.get_param("year")][page.page_params.get_param("theme")][subclass]["subtheme"], 
                            #             period = content[page.page_params.get_param("year")][page.page_params.get_param("theme")][subclass]["period"], 
                            #             difficulty = content[page.page_params.get_param("year")][page.page_params.get_param("theme")][subclass]["difficulty"], 
                            #             l_id = content[page.page_params.get_param("year")][page.page_params.get_param("theme")]["name"], js = False) + \
                            #         "'> " + subclass.capitalize() + "</a>\n")
                            # page.add_lines("</div>\n")

                    # Sort first by period and then alphabetically
                    #subtheme_list.sort(key=lambda x:x['min_period'] + x['title'])
                    subtheme_list.sort(key=lambda x:x['rank_subtheme'] + x['title'])
                    #logging.debug("THEME {}: \n{}\n\n".format(
                    #    theme, [[x['title'], x['min_period']] for x in subtheme_list] ))
                    for st in subtheme_list:
                        #st['topics'].sort(key=lambda x:x['min_period'] + x['title'])
                        st['topics'].sort(key=lambda x:x['rank_topic'] + x['title'])
                        #logging.debug("SUBTHEME {}: \n{}\n\n".format(
                        #    st['title'], [[x['title'], x['min_period']] for x in st['topics']] ))


                    page.template_params['themes'].append({
                        'title' : theme.capitalize().strip(),
                        'link' : Design_default._next_theme_url(
                                page = page, 
                                theme = theme.title().strip(), \
                                subtheme = "*", \
                                topic = "*", \
                                period = "*", \
                                difficulty = "*", \
                                l_id = content[page.page_params.get_param("year")][theme]["name"]),
                        'subthemes' : subtheme_list
                    })



        else:
            page.template_params["template_name"] = "error.html.j2"
            if not page.page_params.get_param("year") in content.keys():
                page.template_params["error_msg"] = "No year {} in content".format(page.page_params.get_param("year"))
            else:
                page.template_params["error_msg"] = "No content"



    @staticmethod
    @timer_section("render_confirm_anon_page")
    def render_confirm_anon_page(page):

        page.template_params["template_name"] = "confirm_anon.html.j2"

        page.template_params["next"] = page.page_params.create_url(\
                    op = PageOperation.toStr(PageOperation.MENU_YEAR), 
                    beta = True if page.page_params.get_param("beta") else None, 
                    js = False
                )
        page.template_params["back"] = page.page_params.create_url(\
                    op = PageOperation.toStr(PageOperation.LOGOUT), 
                    beta = True if page.page_params.get_param("beta") else None, 
                    js = False
                )

#                    op = PageOperation.toStr(PageOperation.MENU_USER), js = False)



    @staticmethod
    @timer_section("render_select_get_started_page")
    def render_select_get_started_page(page):
        page.page_params.delete_history()
        page.page_params.set_param("q_id", "")

        # Create dictionary entries that define menu
        Design_default.add_menu(page)


        page.template_params["template_name"] = "intro.html.j2"

        page.template_params["year"] = page.page_params.get_param("year").title()
        page.template_params["theme"] = page.page_params.get_param("theme").title()
        page.template_params["subtheme"] = page.page_params.get_param("subtheme").title()
        page.template_params["topic"] = page.page_params.get_param("topic").title()
        page.template_params["period"] = page.page_params.get_param("period").title()
        page.template_params["difficulty"] = page.page_params.get_param("difficulty").title()


        page.template_params["h1"] = page.template_params['year']
        page.template_params["h2"] = page.template_params["theme"]
        page.template_params["h3"] = "Start"


        test = Test(page)
        url_next, url_skip = test.get_next_question_url(Design_default.total_questions)
        page.template_params["next"] = url_next
        page.template_params["skip"] = url_skip

        # page.template_params["back"] = page.page_params.create_url(
        #             op = PageOperation.toStr(PageOperation.MENU_THEME),                         
        #             year = page.page_params.get_param("year"), \
        #             theme = "", \
        #             subtheme = "", \
        #             topic = "", \
        #             period = "", \
        #             difficulty = "", \
        #             js = False)
        page.template_params["back"] = page.page_params.create_url(\
                    op = PageOperation.toStr(PageOperation.MENU_THEME), 
                    subtheme = "", 
                    topic = "", 
                    period = "", 
                    difficulty = "", 
                    l_id = "", 
                    beta = True if page.page_params.get_param("beta") else None, 
                    js = False
        )
        
        

    @staticmethod
    def _render_result_bar_and_get_last_difficulty(page):
        difficulty = "0"
        page.template_params["total_bar"] = {"star1": 0, "star2": 0, "star3": 0, "missed": 0}
        page.template_params["type_bar"] = {"star1": 0, "star2": 0, "star3": 0, "missed": 0}

        # Count only the best asnwer to each question        
        questions = {}
        if context.c.session.get("history"):
            for r in context.c.session.get("history"):
                if "difficulty" in r.keys() and (r["difficulty"] == "1" or r["difficulty"] == "2" or r["difficulty"] == "3"):
                    difficulty = r["difficulty"]
                    if not r["q_id"] in questions.keys():
                        questions[r["q_id"]] = r
                    else:
                        if r["incorrect"] < questions[r["q_id"]]["incorrect"]:
                            questions[r["q_id"]]["incorrect"] = r["incorrect"]
                            questions[r["q_id"]]["correct"] = r["correct"]

        # A question is correct if all subquestions are correct
        for k, r in questions.items():
            if r["difficulty"] == "1":
                if r["incorrect"] == 0:
                    page.template_params["type_bar"]["star1"] = page.template_params["type_bar"]["star1"] + 1
                else:
                    page.template_params["type_bar"]["missed"] = page.template_params["type_bar"]["missed"] + 1
                page.template_params["total_bar"]["star1"] = page.template_params["total_bar"]["star1"] + r["correct"]
                page.template_params["total_bar"]["missed"] = page.template_params["total_bar"]["missed"] + r["incorrect"]
            elif r["difficulty"] == "2":
                if r["incorrect"] == 0:
                    page.template_params["type_bar"]["star2"] = page.template_params["type_bar"]["star2"] + 1
                else:
                    page.template_params["type_bar"]["missed"] = page.template_params["type_bar"]["missed"] + 1
                page.template_params["total_bar"]["star2"] = page.template_params["total_bar"]["star2"] + r["correct"]
                page.template_params["total_bar"]["missed"] = page.template_params["total_bar"]["missed"] + r["incorrect"]
            elif r["difficulty"] == "3":
                if r["incorrect"] == 0:
                    page.template_params["type_bar"]["star3"] = page.template_params["type_bar"]["star3"] + 1
                else:
                    page.template_params["type_bar"]["missed"] = page.template_params["type_bar"]["missed"] + 1
                page.template_params["total_bar"]["star3"] = page.template_params["total_bar"]["star3"] + r["correct"]
                page.template_params["total_bar"]["missed"] = page.template_params["total_bar"]["missed"] + r["incorrect"]


        return difficulty




    @staticmethod
    @timer_section("render_question_page")
    def render_question_page(page):

        test = Test(page)

        # Create dictionary entries that define menu
        Design_default.add_menu(page)

        page.template_params["template_name"] = "question.html.j2"

        q_id = page.page_params.get_param("q_id")


        q_number = page.page_params.get_param("q_num")
        try:
            q_number = int(q_number) if not q_number is None else 0
        except ValueError as ex:
            logging.error("Incorrect q_num={}\n{}".format(q_number, helpers.get_stack_trace()))
            q_number = 0

        skipped = page.page_params.get_param("skipped")
        if skipped.lower() == "true":
            try:
                context.c.session.get("history")[-1]["skipped"] = True
            except:
                logging.error("Cannot mark last question as skipped\nhist={}\n{}".format(
                    context.c.session.get("history"), helpers.get_stack_trace()
                    ))


        hist = None
        if page.page_params.get_param("op") == PageOperation.TEST_PREV or q_number == test.get_q_number() - 1:
            context.c.session.list_delete("history", -1)
            # At this point current q_id should match the last one in history,
            # otherwise there was an error creating TEST_PREV link
            if not q_id == context.c.session.get("history")[-1]["q_id"]:
                logging.error("Error getting back in questions: q_id={}, q_num={}\nHist={}\n{}".format(
                    q_id, q_number, context.c.session.get("history"), helpers.get_stack_trace()
                ))
        else:
            if q_number == test.get_q_number() + 1:
                # New question - add to history
                # Apriory set to incorrect so that we have matching history on skip
                hist = {
                    "q_id" : q_id, 
                    "url" : page.page_params.get_url(),
                    "correct" : 0, 
                    "incorrect" : 1
                }
                #hist.update(next_question)
                context.c.session.list_append("history", hist)
            elif q_number == test.get_q_number():
                # The same question - probably a refresh
                if not q_id == context.c.session.get("history")[-1]["q_id"]:
                    logging.error("Error in history: q_id={}, q_num={}\nHist={}\n{}".format(
                        q_id, q_number, context.c.session.get("history"), helpers.get_stack_trace()
                    ))
            else:
                # This happens too often - for now just correct the number
                # Likely wrong
                logging.debug("Error in question numbering: q_id={}, q_num={}/{}\nHist={}\n{}".format(
                    q_id, q_number, test.get_q_number(), context.c.session.get("history"), helpers.get_stack_trace()
                ))
                q_number = test.get_q_number()
                page.page_params.set_param("q_num", q_number)



        # DEBUG
        # context.c.session.print()


        test_id = context.c.session.get("test_id")
        q = Question(page=page, q_id=q_id, test_id=test_id, test_order=q_number)
        q.set_from_file_with_exception()
        q.eval_with_exception()



        url_next, url_skip = test.get_next_question_url(Design_default.total_questions)
        page.template_params["next"] = url_next
        page.template_params["skip"] = url_skip

        #url_prev = test.get_prev_question_url()
        #page.template_params["back"] = url_prev
        


        Design_default._render_result_bar_and_get_last_difficulty(page)
        difficulty = page.page_params.get_param("q_diff")
        if hist:
            hist["difficulty"] = difficulty

        page.template_params["q_number"] = str(q_number)

        page.template_params["debug"] = "DEBUG: {} / {} / {} / {} - {}".format(
            page.page_params.get_param("subtheme"), 
            page.page_params.get_param("topic"), 
            page.page_params.get_param("period"), 
            page.page_params.get_param("q_diff"), 
            page.page_params.get_param("q_id")
        )

        page.template_params["root"] = page.page_params.get_param("root")
        page.template_params["q_id"] = page.page_params.get_param("q_id")
        page.template_params["l_id"] = page.page_params.get_param("l_id")
        page.template_params["language"] = PageLanguage.toStr(page.page_params.get_param("language"))

        page.template_params["year"] = page.page_params.get_param("year").upper()
        page.template_params["theme"] = page.page_params.get_param("theme").upper()
        page.template_params["subtheme"] = page.page_params.get_param("subtheme")
        page.template_params["topic"] = page.page_params.get_param("topic")
        page.template_params["difficulty"] = int(difficulty)

        page.template_params["h1"] = page.template_params['year']
        page.template_params["h2"] = page.template_params["theme"]
        page.template_params["h3"] = "Pitanje"


        return




    @staticmethod
    @timer_section("render_summary_page")
    def render_summary_page(page):
        

        # Create dictionary entries that define menu
        Design_default.add_menu(page)

        page.template_params["template_name"] = "summary.html.j2"

        # page.template_params["results"] = []
        # page.template_params["correct"] = 0
        # page.template_params["incorrect"] = 0

        # try:
        #     if context.c.session.get("history"):
        #         for r in context.c.session.get("history"):
        #             # r["q_id"], r["correct"], r["incorrect"]
        #             page.template_params["results"].append(r)
        #             page.template_params["correct"] = page.template_params["correct"] + int(r["correct"])
        #             page.template_params["incorrect"] = page.template_params["incorrect"] + int(r["incorrect"])                
        # except:
        #     pass

        Design_default._render_result_bar_and_get_last_difficulty(page)


        # page.template_params["url_year"] = page.page_params.create_url(op=PageOperation.toStr(PageOperation.MENU_YEAR), \
        #                                 year = "", \
        #                                 theme = "", \
        #                                 subtheme = "", \
        #                                 topic = "", \
        #                                 difficulty = "", \
        #                                 period = "", \
        #                                 js=False)

        # page.template_params["url_theme"] = page.page_params.create_url(op=PageOperation.toStr(PageOperation.MENU_THEME), \
        #                                 year=page.page_params.get_param("year"), \
        #                                 theme = "", \
        #                                 subtheme = "", \
        #                                 topic = "", \
        #                                 difficulty = "", \
        #                                 period = "", \
        #                                 js=False)

        page.template_params["next"] = page.page_params.create_url(op=PageOperation.toStr(PageOperation.MENU_THEME), \
                                        year=page.page_params.get_param("year"), \
                                        theme = "", \
                                        subtheme = "", \
                                        topic = "", \
                                        difficulty = "", \
                                        period = "", \
                                        beta = True if page.page_params.get_param("beta") else None, 
                                        js=False)


        page.page_params.delete_history()
        page.page_params.set_param("q_id", "")
        page.page_params.set_param("l_id", "")

        page.template_params["h1"] = page.page_params.get_param("year").upper()
        page.template_params["h2"] = page.page_params.get_param("theme").upper()
        page.template_params["h3"] = "Rezultat"

        return









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
    @timer_section("render_user_stats")
    def render_user_stats(page, u_id):

        # Create dictionary entries that define menu
        Design_default.add_menu(page)

        page.template_params["h1"] = "Rezultat"

        #prepare_user_stats_chart(page, 'Petar')
        prepare_user_stats_chart(page, u_id)



    @staticmethod
    @timer_section("render_about")
    def render_about(page):

        # Create dictionary entries that define menu
        Design_default.add_menu(page)

        page.template_params["template_name"] = "about.html.j2"

        page.template_params["h1"] = "O name"


