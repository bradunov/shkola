import json
import random
from server.question import question
from server.helpers import create_url, is_user_on_mobile
from server.repository import Repository


class Test(object):
    language = None
    l_id = None
    page = None
    rel_path = None

    list = None


    def __init__(self, page, user_id, rel_path=None):
        self.repository = page.repository
        self.page = page
        self.language = page.language
        self.l_id = page.l_id
        self.q_id = page.q_id
        self.user_id = user_id
        self.rel_path = rel_path

        self.load_list()

        if self.q_id is None or not self.q_id:
            self.q_id = self.choose_next_question()["name"]

        #print(json.dumps(self.list, indent=4))
        


    def load_list(self, l_id=None):
        if l_id is not None:
            self.l_id = l_id

        self.list = self.repository.get_list(self.l_id)

    
    def choose_next_question(self, previous_question_name=None):
        next_question = random.randrange(len(self.list["questions"]))
        if previous_question_name is not None and len(self.list["questions"]) > 1:
            cnt = 0
            while self.list["questions"][next_question]["name"] == previous_question_name and cnt < 100:
                next_question = random.randrange(len(self.list["questions"]))
        return self.list["questions"][next_question]
        
        
    def render_next_questions(self):

        if is_user_on_mobile():
            menu = "simple"
        else:
            menu = "full"
        
        next_question = self.choose_next_question(self.q_id)
        next_question_url = create_url(page_name = "test", \
                                                q_id = next_question["name"], \
                                                l_id = self.l_id, \
                                                lang = self.language, \
                                                menu = menu, \
                                                state = self.page.get_state(), \
                                                js = False)

        
        q = question(self.page, self.user_id, self.rel_path, next_question_url)
        q.set_from_file_with_exception()
        q.eval_with_exception()




            
