import json
import random
from server.question import question
from server.helpers import create_url
from server.repository import Repository

import logging


class Test(object):
    page = None
    rel_path = None
    mobile = False

    list = None


    def __init__(self, page, user_id, rel_path=None, mobile=False):
        self.page = page
        self.rel_path = rel_path
        self.mobile = mobile

        self.load_list()


        if self.page.q_id is None or not self.page.q_id:
            self.page.q_id = self.choose_next_question()["name"]
        


    def load_list(self, l_id=None):
        if l_id is not None:
            self.page.l_id = l_id

        self.list = self.page.repository.get_list(self.page.l_id)

    
    def choose_next_question(self, previous_question_name=None):
        next_question = random.randrange(len(self.list["questions"]))
        if previous_question_name is not None and len(self.list["questions"]) > 1:
            cnt = 0
            while self.list["questions"][next_question]["name"] == previous_question_name and cnt < 100:
                next_question = random.randrange(len(self.list["questions"]))
        return self.list["questions"][next_question]
        
        
    def render_next_questions(self):
       
        next_question = self.choose_next_question(self.page.q_id)
        next_question_url = create_url(page_name = "test", \
                                        q_id = next_question["name"], \
                                        l_id = self.page.l_id, \
                                        lang = self.page.language, \
                                        menu = self.page.menu, \
                                        user_id = self.page.user_id, \
                                        js = False)

        
        q = question(self.page, self.page.user_id, self.rel_path, next_question_url)
        q.set_from_file_with_exception()
        q.eval_with_exception()

        return next_question_url




            
