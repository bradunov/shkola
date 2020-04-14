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
        logging.info("Processing request: %s", page.page_params.op)

        # If login, update user and replace op with the original op
        if page.page_params.op == PageOperation.LOGIN:
            new_url = page.login()
            context.c.headers.redirect(new_url)

            return "ABC"

        elif page.page_params.op == PageOperation.VIEW:
            if not page.page_params.q_id:
                page.page_params.q_id = page.get_default_question()
            q = Question(page)
            q.set_from_file_with_exception()
            page.add_question(q)
            Design.render_page(page)
            return page.render()
            
        elif page.page_params.op == PageOperation.EDIT:
            if not page.page_params.q_id:
                page.page_params.q_id = page.get_default_question()
            q = Question(page)
            q.set_from_file_with_exception()
            page.add_question(q)
            page.add_code(q.get_init_code(), q.get_iter_code(), q.get_text())
            Design.render_page(page)
            return page.render()
            
        elif page.page_params.op == PageOperation.GENERATE:
            # Use init_code, iter_code, text from the page's parameter 
            # (as submitted by user) and go to edit mode
            page.page_params.op = PageOperation.EDIT
            q = Question(page)
            page.add_question(q)
            Design.render_page(page)
            return page.render()

        elif page.page_params.op == PageOperation.LIST:
            if not page.page_params.l_id:
                page.page_params.l_id = page.get_default_list()
            Design.render_menu(page)
            ql = Qlist(page)
            ql.render_all_questions()
            return page.render()

        elif page.page_params.op == PageOperation.TEST:
            if page.page_params.root == "edit":
                Design.render_menu(page)
                test = Test(page)
                next_question_url = test.render_next_questions()
                Design.add_buttons(page, next_question_url)
                return page.render()
            else:
                return Design_default.render_question_page(page)

        elif page.page_params.op == PageOperation.MENU:
            Design_default.render_main_page(page)
            return page.render()

        # Comment out for now - to be adapted to the new user management
        # elif page.page_params.op == PageOperation.STATS:
        #     if not page.page_params.user_id is None and PageUserID.toStr(page.page_params.user_id):
        #         # TBD: old notation
        #         u_id = PageUserID.toStr(page.page_params.user_id)
        #         if len(u_id) >= len("local:") and u_id[:len("local:")] == "local:":
        #             u_id = u_id[len("local:"):]
        #         Design_dev.render_user_stats(page, u_id)
        #     else:
        #         Design_dev.render_page_stats(page)
        #     return page.render()

        elif page.page_params.op == PageOperation.REGISTER:
            page.register(page.page_params.all_state)

        else:
            return "ERROR - operation not known"




    @staticmethod
    def update_design(page):
        # At the moment we use DEV design for edit 
        # and DEFAULT for others, but this could be changed here
        if page.page_params.root == "edit":
            page.page_params.design = PageDesign.DEV
        else:
            page.page_params.design = PageDesign.DEFAULT


    @staticmethod
    def render_page(page):
        Design.update_design(page)
        if page.page_params.design == PageDesign.DEFAULT:
            Design_default.render_page(page)
        elif page.page_params.design == PageDesign.DEV:
            Design_dev.render_page(page)
        else:
            Design_default.render_page(page)


    @staticmethod
    def render_menu(page):
        Design.update_design(page)
        if page.page_params.design == PageDesign.DEFAULT:
            Design_default.render_menu(page)
        elif page.page_params.design == PageDesign.DEV:
            Design_dev.render_menu(page)
        else:
            Design_default.render_menu(page)


    @staticmethod
    def add_buttons(page, next_question_url):
        Design.update_design(page)
        if page.page_params.design == PageDesign.DEFAULT:
            Design_default.add_buttons(page, next_question_url)
        elif page.page_params.design == PageDesign.DEV:
            Design_dev.add_buttons(page, next_question_url)
        else:
            Design_default.add_buttons(page, next_question_url)


