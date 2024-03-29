# import json

# from server.helpers import encap_str

import re
from server.types import PageLanguage
from server.types import PageOperation
# from server.types import ResponseOperation
from server.types import PageParameters

from server.list import List
from server.question import Question
# from server.stats import Stats

from server.stat_charts import prepare_user_stats_chart

import server.helpers as helpers
import server.context as context
from server.timers import timer_section
from server.helpers import Transliterate

import logging

USE_GOOGLE_AUTH = True


class Design_default(object):
    total_questions = 5

    @staticmethod
    def _get_color(year):
        color_list = ["#ff6956", "#489cba", "#f7b500", "#6ab288"]
        return color_list[(year - 1) % len(color_list)]


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

        if page.page_params.get_param("op") == PageOperation.DEFAULT:
            if not context.c.user:
                # If first time user, send to login page 
                page.page_params.set_param("op", PageOperation.MENU_USER)
            else: 
                page.page_params.set_param("op", PageOperation.MENU_YEAR)


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
            Design_default.render_test_page(page)
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

        elif page.page_params.get_param("op") == PageOperation.TEST_INTRO:
            # Test intro
            logging.debug("PageOperation.TEST_INTRO")
            context.c.session.set("showed_test_intro", True)
            Design_default.render_select_get_test_started_page(page)
            return page.render()

        if page.page_params.get_param("op") == PageOperation.BROWSE:
            # Browse
            logging.debug("PageOperation.BROWSE - {}".format(page.page_params.get_param("root")))
            Design_default.render_browse_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.BROWSE_INTRO:
            # Browse intro
            logging.debug("PageOperation.BROWSE_INTRO")
            context.c.session.set("showed_browse_intro", True)
            Design_default.render_select_get_browse_started_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.MENU_USER and not context.c.user:
            # If user is already logged in, we cannot do login again
            logging.debug("PageOperation.MENU - select user")
            Design_default.render_select_user_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.MENU_YEAR or \
             page.page_params.get_param("op") == PageOperation.DEFAULT:
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
                page.page_params.set_param("op", PageOperation.MENU_USER)
                Design_default.render_select_year_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.ABOUT:
            Design_default.render_about(page)
            return page.render()

        else:
            # Something mesed up the state - clean up the state and go to the intro
            # We could get PageOperation.MENU_USER with a wrong bookmark, so don't log
            if page.page_params.get_param("op") != PageOperation.MENU_USER:
                logging.error("PageOperation.MENU - wrong parameters - select year: {}".format(page.page_params.get_param("op")))
            page.page_params.set_param("op", PageOperation.MENU_YEAR)
            Design_default.render_select_year_page(page)
            return page.render()








    @staticmethod
    @timer_section("add_menu")
    def add_menu(page):
        content = page.repository.get_content(PageLanguage.toStr(page.page_params.get_param("language")))
        page.template_params['menu'] = []

        #page.page_params.print_params()
        current_lang = page.page_params.get_param("language")

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
                            op = PageOperation.MENU_YEAR, 
                            beta = True if page.page_params.get_param("beta") else None, 
                            language = lang)
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
            "name" : page.get_messages()["year"].upper(),
            "link" : new_page_params.create_url(\
                    op = PageOperation.MENU_YEAR, \
                    language = PageLanguage.toStr(page.page_params.get_param("language")), \
                    beta = True if page.page_params.get_param("beta") else None),
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
            #                 op = PageOperation.toStr(PageOperation.TEST_INTRO), \
            #                 year = level, \
            #                 theme = theme, \
            #                 subtheme = "*", \
            #                 topic = "*", \
            #                 period = "*", \
            #                 difficulty = "*", \
            #                 l_id = content[level][theme]["name"], \
            #                 js = False)
            #         })

            # Year 9+ are not complete so we only show in beta mode
            # I had an error in logs, not sure why (some inconsistency in input data):
            #   File "./server/design_default.py", line 238, in add_menu
            #   if int(level) <= 4 or page.page_params.get_param("beta"):
            #   ValueError: invalid literal for int() with base 10: 'first'
            # so added exception handling for ValueError
            try:
                if int(level) <= 8 or page.page_params.get_param("beta"): 
                    lists['submenu']['options'].append({
                        "name" : level.upper(),
                        "link" : new_page_params.create_url( \
                                op = PageOperation.MENU_THEME, \
                                language = PageLanguage.toStr(page.page_params.get_param("language")), \
                                year = level, 
                                beta = True if page.page_params.get_param("beta") else None)
                        #         js = False),
                        # "submenu" : {
                        #     "id" : "zadaci_{}".format(menu_id),
                        #     "options" : options
                        # }
                    })
                    menu_id = menu_id + 1
            except ValueError:
                pass


        page.template_params['menu'].append(lists)

        # # Do not show results to an anonymous user
        # if not user_picture is None:
        page.template_params['menu'].append({
            "name" : page.get_messages()["results"].upper(),
            "link" : new_page_params.create_url(
                op = PageOperation.STATS, 
                language = PageLanguage.toStr(page.page_params.get_param("language")), \
                beta = True if page.page_params.get_param("beta") else None 
            )
        })

        # "name" : "Izloguj se (" + context.c.user.name + ")",
        page.template_params['menu'].append({
            "name" : page.get_messages()["about"].upper(),
            "link" : new_page_params.create_url(
                op = PageOperation.ABOUT, 
                language = PageLanguage.toStr(page.page_params.get_param("language")), \
                beta = True if page.page_params.get_param("beta") else None
            )
        })

        # "name" : "Izloguj se (" + context.c.user.name + ")",
        page.template_params['menu'].append({
            "name" : page.get_messages()["logout"].upper(),
            "link" : new_page_params.create_url(
                op = PageOperation.LOGOUT, 
                language = PageLanguage.toStr(page.page_params.get_param("language")), \
                beta = True if page.page_params.get_param("beta") else None
            )
        })



    @staticmethod
    def _add_language(page, s):
        return page.page_params.get_param("language").value + "/" + s


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

        page.template_params["template_name"] = Design_default._add_language(page, "user.html.j2")

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
                    op = PageOperation.MENU_USER, 
                    language = lang, 
                    beta = True if page.page_params.get_param("beta") else None 
                )
            })            

        page.template_params['menu_lang'] = sublang


        root = page.page_params.get_param("root")

        page.template_params["google_link"] = page.page_params.create_url(
                                    op = PageOperation.LOGIN_GOOGLE, 
                                    beta = True if page.page_params.get_param("beta") else None)


        page.template_params["guest_link"] = page.page_params.create_url(
                                    op = PageOperation.LOGIN_ANON, 
                                    language = PageLanguage.toStr(page.page_params.get_param("language")), \
                                    beta = True if page.page_params.get_param("beta") else None)







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

        page.template_params["template_name"] = Design_default._add_language(page, "year.html.j2")

        page.template_params["h1"] = "Izaberi godinu"

        page.template_params["google_link"] = page.page_params.create_url(
            op = PageOperation.LOGIN_GOOGLE, 
            beta = True if page.page_params.get_param("beta") else None)
        page.template_params["fwd_url"] = page.page_params.relative_url(quoted=True)

        content = page.repository.get_content(PageLanguage.toStr(page.page_params.get_param("language")))

        if content :


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

                # Year 9+ are not complete so we only show in beta mode
                if int(ordered[ynumber]) <= 8 or page.page_params.get_param("beta"): 
                    year = ordered[ynumber]

                    page.template_params['button']['choices'].append({
                        'title' : ynumber,
                        'front_color' : Design_default._get_color(i+1),
                        #'back_color' : '#f9f9f9',
                        'back_color' : '#ffffff',
                        'link' : page.page_params.create_url(
                            op = PageOperation.MENU_THEME,                         
                            language = PageLanguage.toStr(page.page_params.get_param("language")), \
                            year = year, \
                            theme = "", \
                            subtheme = "", \
                            topic = "", \
                            period = "", \
                            difficulty = "", \
                            beta = True if page.page_params.get_param("beta") else None)
                    })
                    i = i+1

        else:
            page.template_params["template_name"] = Design_default._add_language(page, "error.html.j2")
            page.template_params["error_msg"] = "No content"




    @staticmethod
    def _next_theme_test_url(page, theme, subtheme, topic, period, difficulty, l_id):

        # Only show intro once per login 
        if context.c.session.get("showed_test_intro"):
            page.page_params.set_param("theme", theme)
            page.page_params.set_param("subtheme", subtheme)
            page.page_params.set_param("topic", topic)
            page.page_params.set_param("period", period)
            page.page_params.set_param("difficulty", difficulty)
            page.page_params.set_param("l_id", l_id)

            test = List(page)
            url_next, url_skip = test.get_next_question_test_url(Design_default.total_questions)

        else:
            url_next = page.page_params.create_url(
                    op = PageOperation.TEST_INTRO, 
                    language = PageLanguage.toStr(page.page_params.get_param("language")), \
                    theme = theme, 
                    subtheme = subtheme, 
                    topic = topic, 
                    period = period, 
                    difficulty = difficulty, 
                    beta = True if page.page_params.get_param("beta") else None, 
                    l_id = l_id)

        return url_next




    @staticmethod
    def _next_theme_browse_url(page, theme, subtheme, topic, period, difficulty, l_id):

        # Only show intro once per login 
        if context.c.session.get("showed_browse_intro"):
            page.page_params.set_param("theme", theme)
            page.page_params.set_param("subtheme", subtheme)
            page.page_params.set_param("topic", topic)
            page.page_params.set_param("period", period)
            page.page_params.set_param("difficulty", difficulty)
            page.page_params.set_param("l_id", l_id)

            test = List(page)
            _, url_next = test.get_prev_next_questions_browse_url()

        else:
            url_next = page.page_params.create_url(
                    op = PageOperation.BROWSE_INTRO, 
                    language = PageLanguage.toStr(page.page_params.get_param("language")), \
                    theme = theme, 
                    subtheme = subtheme, 
                    topic = topic, 
                    period = period, 
                    difficulty = difficulty, 
                    beta = True if page.page_params.get_param("beta") else None, 
                    l_id = l_id)

        return url_next




    # BROWSE
    @staticmethod
    def _next_theme_url(page, theme, subtheme, topic, period, difficulty, l_id):
        return Design_default._next_theme_browse_url(page, theme, subtheme, topic, period, difficulty, l_id)




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

        lang = page.page_params.get_param("language")
        content = page.repository.get_content(PageLanguage.toStr(lang))

        icon_cnt = 0

        if content and page.page_params.get_param("year") in content.keys():
            
            page.template_params["template_name"] = Design_default._add_language(page, "theme.html.j2")

            page.template_params['year'] = page.page_params.get_param("year").upper().strip()

            try:
                int_year = int(page.page_params.get_param("year"))
            except:
                int_year = 1
                pass

            page.template_params['year_color'] = Design_default._get_color(int_year)

            page.template_params['url_year'] = page.page_params.create_url(
                                            language = PageLanguage.toStr(page.page_params.get_param("language")), \
                                            op = PageOperation.MENU_YEAR, 
                                            beta = True if page.page_params.get_param("beta") else None)

            page.template_params['themes'] = []

            page.template_params["h1"] = page.template_params['year']
            page.template_params["h2"] = "Izaberi temu"

            # page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>\n")
            # page.add_lines("<h3> {} razred - izaberi oblast</h3>\n".format(page.page_params.get_param("year").title()))
            # page.add_lines("</div>\n")


            # Sort according to the assigned rank
            sorted_themes = []
            for theme in sorted(content[page.page_params.get_param("year")].keys()):
                if not theme == "level_short": 
                    sorted_themes.append([theme, content[page.page_params.get_param("year")][theme]["rank"]])
            sorted_themes.sort(key=lambda x:x[1])
            sorted_themes = [x[0] for x in sorted_themes]

            #for theme in sorted(content[page.page_params.get_param("year")].keys()):
            for theme in sorted_themes:
                subtheme_list = []
                subtheme_dict = dict()

                # Special provisioing for Serbian cyrillic
                if lang == PageLanguage.RSC:
                    theme_o = Transliterate.rs(theme)
                else:
                    theme_o = theme

                for subclass in sorted(content[page.page_params.get_param("year")][theme].keys()):
                    if not subclass == "name" and not subclass == "rank":
                        subtheme = content[page.page_params.get_param("year")][theme][subclass]["subtheme"].strip()
                        topic = content[page.page_params.get_param("year")][theme][subclass]["topic"].strip()
                        # Special provisioing for Serbian cyrillic
                        if lang == PageLanguage.RSC:
                            subtheme_o = Transliterate.rs(subtheme)
                            topic_o = Transliterate.rs(topic)
                        else:
                            subtheme_o = subtheme
                            topic_o = topic
                        rank_subtheme = content[page.page_params.get_param("year")][theme][subclass]["rank_subtheme"].strip()
                        rank_topic = content[page.page_params.get_param("year")][theme][subclass]["rank_topic"].strip()
                        period = content[page.page_params.get_param("year")][theme][subclass]["period"]
                        if subtheme not in subtheme_dict.keys():
                            icon_svg = page.repository.get_icon_svg(PageLanguage.toStr(lang), subtheme)

                            # Different SVGs can have same path IDs (e.g. created in the same program)
                            # So we change names here
                            
                            #icon_svg = re.sub(r'id="(.*?)"', 'id="\\1_R_{}"'.format(icon_cnt), icon_svg)
                            icon_svg = re.sub(r'cls-(.)', 'cld-\\1_R_{}'.format(icon_cnt), icon_svg)
                            icon_cnt = icon_cnt + 1

                            subtheme_d = {
                                'title' : subtheme_o.capitalize(),
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


                            # BROWSE
                            link = Design_default._next_theme_test_url(
                                        page = page, 
                                        theme = theme.title().strip(), 
                                        subtheme = subtheme, 
                                        topic = "*", 
                                        period = "*", 
                                        difficulty = "*", 
                                        l_id = content[page.page_params.get_param("year")][theme]["name"])

                            topic_d = {
                                # Special provisioing for Serbian cyrillic
                                'title' : "Sve teme" if not lang == PageLanguage.RSC else "Све теме",
                                'rank_topic' : "0",
                                'min_period' : "0",
                                'link' : link
                            }

                            # BROWSE
                            topic_d['rank_topic'] = "9999"
                            topic_d['title'] = page.get_messages()['test']
                            topic_d['color'] = Design_default._get_color(int_year)
                            topic_d['font-weight'] = 'bolder'
                            topic_d['font-size'] = '12px'                                    

                            subtheme_d['topics_dir']["all"] = topic_d
                            subtheme_d['topics'].append(topic_d)


                        else:
                            subtheme_d = subtheme_dict[subtheme]

                        if topic not in subtheme_d['topics_dir'].keys():
                            topic_d = {
                                'title' : topic_o.capitalize(),
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
                    'title' : theme_o.capitalize().strip(),
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
            page.template_params["template_name"] = Design_default._add_language(page, "error.html.j2")
            if not page.page_params.get_param("year") in content.keys():
                page.template_params["error_msg"] = "No year {} in content".format(page.page_params.get_param("year"))
            else:
                page.template_params["error_msg"] = "No content"


        page.template_params["google_link"] = page.page_params.create_url(
            op = PageOperation.LOGIN_GOOGLE, 
            beta = True if page.page_params.get_param("beta") else None)
        page.template_params["fwd_url"] = page.page_params.relative_url(quoted=True)



    @staticmethod
    @timer_section("render_confirm_anon_page")
    def render_confirm_anon_page(page):

        page.template_params["template_name"] = Design_default._add_language(page, "confirm_anon.html.j2")

        page.template_params["next"] = page.page_params.create_url(\
                    op = PageOperation.MENU_YEAR, 
                    language = PageLanguage.toStr(page.page_params.get_param("language")),
                    beta = True if page.page_params.get_param("beta") else None
                )
        page.template_params["back"] = page.page_params.create_url(\
                    op = PageOperation.LOGOUT, 
                    language = PageLanguage.toStr(page.page_params.get_param("language")),
                    beta = True if page.page_params.get_param("beta") else None
                )


        # This is otherwise loaded from the menu, and in this case we don't display menu
        user_name = context.c.session.get("user_name")
        if not user_name is None:
            page.template_params["user_name"] = user_name

        page.template_params["google_link"] = page.page_params.create_url(
            op = PageOperation.LOGIN_GOOGLE, 
            beta = True if page.page_params.get_param("beta") else None)
        page.template_params["fwd_url"] = page.page_params.relative_url(quoted=True)


    @staticmethod
    @timer_section("render_select_get_test_started_page")
    def render_select_get_test_started_page(page):
        page.page_params.delete_history()
        page.page_params.set_param("q_id", "")

        # Create dictionary entries that define menu
        Design_default.add_menu(page)


        page.template_params["template_name"] = Design_default._add_language(page, "test_intro.html.j2")


        year = ""
        theme = ""
        subtheme = ""
        topic = ""
        period = ""
        difficulty = ""

        try:
            year = page.page_params.get_param("year").title()
            theme = page.page_params.get_param("theme").title()
            subtheme = page.page_params.get_param("subtheme").title()
            topic = page.page_params.get_param("topic").title()
            period = context.c.session.get("period").title()
            difficulty = context.c.session.get("difficulty").title()
        except Exception as ex:
            logging.error(
                "Error getting params for {}/{}/{}/{}/{}/{}: {}".format(
                    year, theme, subtheme, topic, period, difficulty, ex
                ))
            pass


        page.template_params["year"] = year
        page.template_params["theme"] = theme
        page.template_params["subtheme"] = subtheme
        page.template_params["topic"] = topic
        page.template_params["period"] = period
        page.template_params["difficulty"] = difficulty


        page.template_params["google_link"] = page.page_params.create_url(
            op = PageOperation.LOGIN_GOOGLE, 
            beta = True if page.page_params.get_param("beta") else None)
        page.template_params["fwd_url"] = page.page_params.relative_url(quoted=True)

        page.template_params["h1"] = page.template_params['year']
        page.template_params["h2"] = page.template_params["theme"]
        page.template_params["h3"] = page.template_params["topic"]
        page.template_params["h4"] = "Start test"

        if context.c.session.get("beta"):
            page.template_params["beta"] = True
        else:
            page.template_params["beta"] = False


        test = List(page)
        url_next, url_skip = test.get_next_question_test_url(Design_default.total_questions)
        page.template_params["next"] = url_next
        page.template_params["skip"] = url_skip

        page.template_params["back"] = page.page_params.create_url(\
                    op = PageOperation.MENU_THEME, 
                    language = PageLanguage.toStr(page.page_params.get_param("language")),
                    subtheme = "", 
                    topic = "", 
                    period = "", 
                    difficulty = "", 
                    l_id = "", 
                    beta = True if page.page_params.get_param("beta") else None
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
    # Store page parameters into session
    # Used when registering results in order to get good statistics of years/topics/themes/etc 
    def _store_last_question_into_session(page):
        context.c.session.set("last_q_year", page.page_params.get_param("year"))
        context.c.session.set("last_q_theme", page.page_params.get_param("theme"))
        context.c.session.set("last_q_subtheme", page.page_params.get_param("subtheme"))
        context.c.session.set("last_q_topic", page.page_params.get_param("topic"))
        



    @staticmethod
    @timer_section("render_test_page")
    def render_test_page(page):

        test = List(page)

        Design_default._store_last_question_into_session(page)

        # Create dictionary entries that define menu
        Design_default.add_menu(page)

        page.template_params["template_name"] = Design_default._add_language(page, "test.html.j2")

        page.template_params["google_link"] = page.page_params.create_url(
            op = PageOperation.LOGIN_GOOGLE, 
            beta = True if page.page_params.get_param("beta") else None)
        page.template_params["fwd_url"] = page.page_params.relative_url(quoted=True)


        q_id = page.page_params.get_param("q_id")


        q_number = context.c.session.get("q_num")
        try:
            q_number = int(q_number) if q_number else 0
        except ValueError as ex:
            logging.error("Incorrect q_num={}\n{}".format(q_number, helpers.get_stack_trace()))
            q_number = 0

        skipped = page.page_params.get_param("skipped")
        if skipped and isinstance(skipped, str) and skipped.lower() == "true":
            try:
                context.c.session.get("history")[-1]["skipped"] = True
            except:
                # I believe this happens when a link with "skipped" parameteris bookmarked, 
                # so we don't want alerts on this one. 
                logging.debug("Cannot mark last question as skipped\nhist={}\n{}".format(
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
            elif q_number > 0 and q_number == test.get_q_number():
                # The same question - probably a refresh
                # Happens too often, not sure why (refreshes, clicks on history?) so just ignoring
                if not q_id == context.c.session.get("history")[-1]["q_id"]:
                    logging.debug("Error in history: q_id={}, q_num={}\nHist={}\n{}".format(
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



        url_next, url_skip = test.get_next_question_test_url(Design_default.total_questions)
        page.template_params["next"] = url_next
        page.template_params["skip"] = url_skip

        #url_prev = test.get_prev_question_test_url()
        #page.template_params["back"] = url_prev
        


        Design_default._render_result_bar_and_get_last_difficulty(page)

        all_questions = page.repository.get_content_questions(
            PageLanguage.toStr(page.page_params.get_param("language")), 
            page.page_params.get_param("year"), 
            page.page_params.get_param("theme"))

        if page.page_params.get_param("q_id") in all_questions.keys():
            difficulty = all_questions[page.page_params.get_param("q_id")]["difficulty"]
        else:
            difficulty = None
        if hist and page.page_params.get_param("q_id") in all_questions.keys():
            hist["difficulty"] = difficulty

        page.template_params["q_number"] = str(q_number)

        page.template_params["debug"] = "DEBUG: {} / {} / {} / {} - {}".format(
            page.page_params.get_param("subtheme"), 
            page.page_params.get_param("topic"), 
            context.c.session.get("period"), 
            difficulty, 
            page.page_params.get_param("q_id")
        )

        page.template_params["root"] = page.page_params.get_param("root")
        page.template_params["q_id"] = page.page_params.get_param("q_id")
        page.template_params["l_id"] = page.page_params.get_param("l_id")
        page.template_params["language"] = PageLanguage.toStr(page.page_params.get_param("language"))

        page.template_params["year"] = page.page_params.get_param("year").upper()
        if page.page_params.get_param("language") == PageLanguage.RSC:
            page.template_params["theme"] = Transliterate.rs(page.page_params.get_param("theme")).upper()
            page.template_params["subtheme"] = Transliterate.rs(page.page_params.get_param("subtheme"))
        else:
            page.template_params["theme"] = page.page_params.get_param("theme").upper()
            page.template_params["subtheme"] = page.page_params.get_param("subtheme")

        page.template_params["topic"] = page.page_params.get_param("topic")
        page.template_params["difficulty"] = int(difficulty) if difficulty else 1

        page.template_params["h1"] = page.template_params['year']
        page.template_params["h2"] = page.template_params["theme"]
        page.template_params["h3"] = page.template_params["topic"]
        page.template_params["h4"] = "Test"

        page.template_params["exit"] = page.page_params.create_url(
                                        op=PageOperation.MENU_THEME, \
                                        language = PageLanguage.toStr(page.page_params.get_param("language")), \
                                        year=page.page_params.get_param("year"), \
                                        theme = "", \
                                        subtheme = "", \
                                        topic = "", \
                                        difficulty = "", \
                                        period = "", \
                                        beta = True if page.page_params.get_param("beta") else None)

        return




    @staticmethod
    @timer_section("render_summary_page")
    def render_summary_page(page):
        

        # Create dictionary entries that define menu
        Design_default.add_menu(page)

        page.template_params["template_name"] = Design_default._add_language(page, "summary.html.j2")

        page.template_params["google_link"] = page.page_params.create_url(
            op = PageOperation.LOGIN_GOOGLE, 
            beta = True if page.page_params.get_param("beta") else None)
        page.template_params["fwd_url"] = page.page_params.relative_url(quoted=True)

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


        page.template_params["next"] = page.page_params.create_url(
                                        op=PageOperation.MENU_THEME, \
                                        language = PageLanguage.toStr(page.page_params.get_param("language")), \
                                        year=page.page_params.get_param("year"), \
                                        theme = "", \
                                        subtheme = "", \
                                        topic = "", \
                                        difficulty = "", \
                                        period = "", \
                                        beta = True if page.page_params.get_param("beta") else None)


        page.page_params.delete_history()
        #page.page_params.set_param("q_id", "")
        page.page_params.set_param("l_id", "")

        page.template_params["h1"] = page.page_params.get_param("year").upper()
        page.template_params["h2"] = page.page_params.get_param("theme").upper()
        page.template_params["h3"] = page.page_params.get_param("topic").upper()
        page.template_params["h4"] = "Rezultat"

        return







    @staticmethod
    @timer_section("render_select_get_browse_started_page")
    def render_select_get_browse_started_page(page):
        page.page_params.delete_history()
        page.page_params.set_param("q_id", "")

        # Create dictionary entries that define menu
        Design_default.add_menu(page)


        page.template_params["template_name"] = Design_default._add_language(page, "browse_intro.html.j2")

        year = ""
        theme = ""
        subtheme = ""
        topic = ""
        period = ""
        difficulty = ""

        try:
            year = page.page_params.get_param("year").title()
            theme = page.page_params.get_param("theme").title()
            subtheme = page.page_params.get_param("subtheme").title()
            topic = page.page_params.get_param("topic").title()
            period = context.c.session.get("period").title()
            difficulty = context.c.session.get("difficulty").title()
        except Exception as ex:
            logging.error(
                "Error getting params for {}/{}/{}/{}/{}/{}: {}".format(
                    year, theme, subtheme, topic, period, difficulty, ex
                ))
            pass


        page.template_params["year"] = year
        page.template_params["theme"] = theme
        page.template_params["subtheme"] = subtheme
        page.template_params["topic"] = topic
        page.template_params["period"] = period
        page.template_params["difficulty"] = difficulty


        page.template_params["h1"] = page.template_params['year']
        page.template_params["h2"] = page.template_params["theme"]
        page.template_params["h3"] = page.template_params["topic"]
        page.template_params["h4"] = "Start browse"


        page.template_params["google_link"] = page.page_params.create_url(
            op = PageOperation.LOGIN_GOOGLE, 
            beta = True if page.page_params.get_param("beta") else None)
        page.template_params["fwd_url"] = page.page_params.relative_url(quoted=True)


        test = List(page)
        _, url_next = test.get_prev_next_questions_browse_url()

        page.template_params["next"] = url_next
        page.template_params["back"] = page.page_params.create_url(\
                    op = PageOperation.MENU_THEME, 
                    language = PageLanguage.toStr(page.page_params.get_param("language")), \
                    subtheme = "", 
                    topic = "", 
                    period = "", 
                    difficulty = "", 
                    l_id = "", 
                    beta = True if page.page_params.get_param("beta") else None
        )
        
        


    @staticmethod
    @timer_section("render_browse_page")
    def render_browse_page(page):

        test = List(page)

        Design_default._store_last_question_into_session(page)

        # Create dictionary entries that define menu
        Design_default.add_menu(page)

        page.template_params["template_name"] = Design_default._add_language(page, "browse.html.j2")

        page.template_params["google_link"] = page.page_params.create_url(
            op = PageOperation.LOGIN_GOOGLE, 
            beta = True if page.page_params.get_param("beta") else None)
        page.template_params["fwd_url"] = page.page_params.relative_url(quoted=True)

        q_id = page.page_params.get_param("q_id")


        hist = None
        context.c.session.set("browse_last_q", q_id)

        # DEBUG
        # context.c.session.print()


        test_id = 0
        q = Question(page=page, q_id=q_id)
        q.set_from_file_with_exception()
        q.eval_with_exception()


        all_questions = page.repository.get_content_questions(
            PageLanguage.toStr(page.page_params.get_param("language")), 
            page.page_params.get_param("year"), 
            page.page_params.get_param("theme"))

        if page.page_params.get_param("q_id") in all_questions.keys():
            try:
                difficulty = int(all_questions[page.page_params.get_param("q_id")]["difficulty"])
            except:
                difficulty = 0
        else:
            difficulty = 0


        url_prev, url_next = test.get_prev_next_questions_browse_url()

        page.template_params["difficulty"] = difficulty
        page.template_params["next"] = url_next
        page.template_params["prev"] = url_prev
        page.template_params["exit"] = page.page_params.create_url(\
            op = PageOperation.MENU_THEME, 
            language = PageLanguage.toStr(page.page_params.get_param("language")), \
            subtheme = "", 
            topic = "", 
            period = "", 
            difficulty = "", 
            l_id = "", 
            beta = True if page.page_params.get_param("beta") else None
        )


        

        Design_default._render_result_bar_and_get_last_difficulty(page)

        page.template_params["debug"] = "DEBUG: {} / {} / {} - {}".format(
            page.page_params.get_param("subtheme"), 
            page.page_params.get_param("topic"), 
            context.c.session.get("period"), 
            page.page_params.get_param("q_id")
        )

        page.template_params["root"] = page.page_params.get_param("root")
        page.template_params["q_id"] = page.page_params.get_param("q_id")
        page.template_params["l_id"] = page.page_params.get_param("l_id")
        page.template_params["language"] = PageLanguage.toStr(page.page_params.get_param("language"))

        page.template_params["year"] = page.page_params.get_param("year").upper()
        if page.page_params.get_param("language") == PageLanguage.RSC:
            page.template_params["theme"] = Transliterate.rs(page.page_params.get_param("theme")).upper()
            page.template_params["subtheme"] = Transliterate.rs(page.page_params.get_param("subtheme"))
        else:
            page.template_params["theme"] = page.page_params.get_param("theme").upper()
            page.template_params["subtheme"] = page.page_params.get_param("subtheme")
        page.template_params["topic"] = page.page_params.get_param("topic")

        page.template_params["h1"] = page.template_params['year']
        page.template_params["h2"] = page.template_params["theme"]
        page.template_params["h3"] = page.template_params["topic"]
        page.template_params["h4"] = "Browse"


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

        page.template_params["google_link"] = page.page_params.create_url(
            op = PageOperation.LOGIN_GOOGLE, 
            beta = True if page.page_params.get_param("beta") else None)
        page.template_params["fwd_url"] = page.page_params.relative_url(quoted=True)

        #prepare_user_stats_chart(page, 'Petar')
        prepare_user_stats_chart(page, u_id)



    @staticmethod
    @timer_section("render_about")
    def render_about(page):

        # Create dictionary entries that define menu
        Design_default.add_menu(page)

        page.template_params["template_name"] = Design_default._add_language(page, "about.html.j2")

        page.template_params["h1"] = "O name"

        page.template_params["google_link"] = page.page_params.create_url(
            op = PageOperation.LOGIN_GOOGLE, 
            beta = True if page.page_params.get_param("beta") else None)
        page.template_params["fwd_url"] = page.page_params.relative_url(quoted=True)


