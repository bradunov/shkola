import random
from server.question import Question


class Test(object):
    page = None
    mobile = False

    list = None


    def __init__(self, page):
        self.page = page
        self.load_list()

        if self.page.page_params.q_id is None or not self.page.page_params.q_id:
            self.page.page_params.q_id = self.choose_next_question()["name"]
        


    def load_list(self):
        self.list = self.page.repository.get_list(self.page.page_params.l_id)

    
    def choose_next_question(self, previous_question_name=None):
        next_question = random.randrange(len(self.list["questions"]))
        if previous_question_name is not None and len(self.list["questions"]) > 1:
            cnt = 0
            while self.list["questions"][next_question]["name"] == previous_question_name and cnt < 100:
                next_question = random.randrange(len(self.list["questions"]))
        return self.list["questions"][next_question]
        
        
    def render_next_questions(self):
       
        next_question = self.choose_next_question(self.page.page_params.q_id)
        next_question_url = self.page.create_url(\
            op = "test", \
            q_id = next_question["name"], \
            js = False)

        
        q = Question(self.page)
        q.set_from_file_with_exception()
        q.eval_with_exception()

        return next_question_url




            
