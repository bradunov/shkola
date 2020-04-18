from server.design_dev import Design_dev
from server.design_default import Design_default

from server.types import PageDesign
from server.types import PageOperation
#from server.types import PageUserID

from server.question import Question
from server.qlist import Qlist
from server.test import Test

import server.context as context

import logging


class Design(object):

    @staticmethod
    def main(page):
        Design.add_header(page)

        # Select default
        if page.page_params.get_param("op") == PageOperation.DEFAULT:
            if page.page_params.get_param("root") == "edit":
                page.page_params.set_param("op", PageOperation.VIEW)
            else:
                page.page_params.set_param("op", PageOperation.MENU)

        logging.info("Processing request: %s", page.page_params.get_param("op"))

        # If login, update user and replace op with the original op
        if page.page_params.get_param("op") == PageOperation.LOGIN:
            new_url = page.login()
            context.c.headers.redirect(new_url)

            return "ABC"

        elif page.page_params.get_param("op") == PageOperation.VIEW:
            if not page.page_params.get_param("q_id"):
                page.page_params.set_param("q_id", page.get_default_question())
            q = Question(page)
            q.set_from_file_with_exception()
            page.add_question(q)
            Design.render_page(page)
            return page.render()
            
        elif page.page_params.get_param("op") == PageOperation.EDIT:
            if not page.page_params.get_param("q_id"):
                page.page_params.set_param("q_id", page.get_default_question())
            q = Question(page)
            q.set_from_file_with_exception()
            page.add_question(q)
            page.add_code(q.get_init_code(), q.get_iter_code(), q.get_text())
            Design.render_page(page)
            return page.render()
            
        elif page.page_params.get_param("op") == PageOperation.GENERATE:
            # Use init_code, iter_code, text from the page's parameter 
            # (as submitted by user) and go to edit mode
            page.page_params.set_param("op", PageOperation.EDIT)
            q = Question(page)
            page.add_question(q)
            Design.render_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.LIST:
            if not page.page_params.get_param("l_id"):
                page.page_params.set_param("l_id", page.get_default_list())
            Design.render_menu(page)
            ql = Qlist(page)
            ql.render_all_questions()
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.TEST:
            if page.page_params.get_param("root") == "edit":
                Design.render_menu(page)
                test = Test(page)
                next_question_url = test.render_next_questions()
                Design.add_buttons(page, next_question_url)
                return page.render()
            else:
                Design_default.add_background(page)
                return Design_default.render_question_page(page)

        elif page.page_params.get_param("op") == PageOperation.MENU or \
                page.page_params.get_param("op") == PageOperation.INTRO or \
                page.page_params.get_param("op") == PageOperation.SUMMARY:
            Design_default.add_background(page)
            Design_default.render_main_page(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.STATS:
            Design.add_background(page)

            user = context.c.user

            if user and user.domain_user_id:
                # TBD: old notation
                u_id = user.domain_user_id
                if len(u_id) >= len("local:") and u_id[:len("local:")] == "local:":
                    u_id = u_id[len("local:"):]
                Design.render_user_stats(page, u_id)
            else:
                if page.page_params.get_param("root") == "edit":
                    Design_dev.render_page_stats(page)
            return page.render()

        else:
            return "ERROR - operation {} not known".format(PageOperation.toStr(page.page_params.get_param("op")))




    @staticmethod
    def add_header(page):
        if not page.page_params.get_param("root") == "edit":
            Design_default.add_header(page)



    @staticmethod
    def add_background(page):
        if not page.page_params.get_param("root") == "edit":
            Design_default.add_background(page)



    @staticmethod
    def update_design(page):
        # At the moment we use DEV design for edit 
        # and DEFAULT for others, but this could be changed here
        if page.page_params.get_param("root") == "edit":
            page.page_params.set_param("design", PageDesign.DEV)
        else:
            page.page_params.set_param("design", PageDesign.DEFAULT)


    @staticmethod
    def render_page(page):
        Design.update_design(page)
        if page.page_params.get_param("design") == PageDesign.DEFAULT:
            Design_default.render_page(page)
        elif page.page_params.get_param("design") == PageDesign.DEV:
            Design_dev.render_page(page)
        else:
            Design_default.render_page(page)


    @staticmethod
    def render_menu(page):
        Design.update_design(page)
        if page.page_params.get_param("design") == PageDesign.DEFAULT:
            Design_default.render_menu(page)
        elif page.page_params.get_param("design") == PageDesign.DEV:
            Design_dev.render_menu(page)
        else:
            Design_default.render_menu(page)


    @staticmethod
    def add_buttons(page, next_question_url):
        Design.update_design(page)
        if page.page_params.get_param("design") == PageDesign.DEFAULT:
            Design_default.add_buttons(page, next_question_url)
        elif page.page_params.get_param("design") == PageDesign.DEV:
            Design_dev.add_buttons(page, next_question_url)
        else:
            Design_default.add_buttons(page, next_question_url)



    @staticmethod
    def render_user_stats(page, u_id):
        Design.update_design(page)
        if page.page_params.get_param("design") == PageDesign.DEFAULT:
            Design_default.render_user_stats(page, u_id)
        elif page.page_params.get_param("design") == PageDesign.DEV:
            Design_dev.render_user_stats(page, u_id)
        else:
            Design_default.render_user_stats(page, u_id)
