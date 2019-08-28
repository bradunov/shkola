import json
import random
from question import question
from helpers import create_url


class Test(object):
    language = None
    l_id = None
    lists_path = ""
    questions_path = ""
    page = None

    list = None


    def load_list(self, l_id = None):
        if l_id is not None:
            self.l_id = l_id

        #print(self.lists_path, self.l_id, self.lists_path + "/" + self.l_id)
        with open(self.lists_path + "/" + self.l_id, "r") as read_list:
            self.list = json.load(read_list)

    
    def choose_next_question(self, previous_question_name=None):
        next_question = random.randrange(len(self.list["questions"]))
        if previous_question_name is not None and len(self.list["questions"]) > 1:
            cnt = 0
            while self.list["questions"][next_question]["name"] == previous_question_name and cnt < 100:
                next_question = random.randrange(len(self.list["questions"]))
        return self.list["questions"][next_question]
        
        
    def __init__(self, page, l_id, q_id, language, user_id, questions_path, lists_path):
        self.page = page
        self.language = language
        self.l_id = l_id
        self.q_id = q_id
        self.user_id = user_id
        self.questions_path = questions_path
        self.lists_path = lists_path

        self.load_list()

        if self.q_id is None or not self.q_id:
            self.q_id = self.choose_next_question()["name"]

        print("Q: ", self.q_id)
            
        #print(json.dumps(self.list, indent=4))
        

    def render_next_questions(self):

        print("AAAA", self.l_id, self.q_id)
        
        next_question = self.choose_next_question(self.q_id)
        next_question_url = create_url(page_name = "test", \
                                                q_id = next_question["name"], \
                                                l_id = self.l_id, \
                                                lang = self.language, \
                                                menu = "full", \
                                                js = False)

        print("AAAA", next_question, next_question_url)

        
        q = question(self.page, self.q_id, self.language, self.user_id, self.questions_path, next_question_url)
        q.set_from_file_with_exception()
        q.eval_with_exception()




            
