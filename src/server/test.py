import json
import random
from question import question
from helpers import create_url, is_user_on_mobile


class Test(object):
    params = {}
    lists_path = ""
    questions_path = ""
    page = None

    list = None


    def load_list(self, l_id = None):
        if l_id is not None:
            self.params["l_id"] = l_id

        #print(self.lists_path, self.l_id, self.lists_path + "/" + self.l_id)
        with open(self.lists_path + "/" + self.params["l_id"], "r") as read_list:
            self.list = json.load(read_list)

    
    def choose_next_question(self, previous_question_name=None):
        next_question = random.randrange(len(self.list["questions"]))
        if previous_question_name is not None and len(self.list["questions"]) > 1:
            cnt = 0
            while self.list["questions"][next_question]["name"] == previous_question_name and cnt < 100:
                next_question = random.randrange(len(self.list["questions"]))
        return self.list["questions"][next_question]
        
        
    def __init__(self, page, params, user_id, questions_path, lists_path):
        self.page = page
        self.params = params
        self.user_id = user_id
        self.questions_path = questions_path
        self.lists_path = lists_path

        self.load_list()

        if "q_id" not in self.params.keys() or self.params["q_id"] is None or not self.params["q_id"]:
            self.params["q_id"] = self.choose_next_question()["name"]

        #print("Q: ", self.params["q_id"])   
        #print(json.dumps(self.list, indent=4))
        

    def render_next_questions(self):

        if is_user_on_mobile():
            menu = "simple"
        else:
            menu = "full"
        
        next_question = self.choose_next_question(self.params["q_id"])
        next_question_url = create_url(page_name = "test", \
                                                q_id = next_question["name"], \
                                                l_id = self.params["l_id"], \
                                                lang = self.params["language"], \
                                                menu = menu, \
                                                js = False)

        
        q = question(self.page, self.params, self.user_id, self.questions_path, next_question_url)
        q.set_from_file_with_exception()
        q.eval_with_exception()




            
