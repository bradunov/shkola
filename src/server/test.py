import random
from server.question import Question
from server.types import PageOperation


class Test(object):
    page = None
    mobile = False

    list = None


    def __init__(self, page):
        self.page = page
        self.load_list()

        if self.page.page_params.q_id is None or not self.page.page_params.q_id:
            self.page.page_params.q_id = self.choose_next_question()
            try:
                self.page.page_params.menu_state["last_question"] = self.page.page_params.q_id
            except:
                pass



    def load_list(self):
        self.list = self.page.repository.get_list(self.page.page_params.l_id)

    
    def choose_next_question(self, previous_question_name=None):

        potential_questions = []
        potential_questions_w_repeat = []
        asked_questions = list(map(lambda hist: hist["question"], self.page.page_params.menu_state["history"]))
        asked_questions.append(self.page.page_params.menu_state["last_question"])

        # Find the list of all question in the subtopic (potential_questions_w_repeat), 
        # and also those among them that haven't been already asked in this session (potential_questions)
        for q in self.list["questions"]:
            if self.page.page_params.subtheme and q["subtheme"] == self.page.page_params.subtheme and \
               self.page.page_params.period and q["period"] == self.page.page_params.period and \
               self.page.page_params.difficulty and q["difficulty"] == self.page.page_params.difficulty:
                potential_questions_w_repeat.append(q["name"])
                if not q["name"] in asked_questions:
                    potential_questions.append(q["name"])

        next_question = ""
        if potential_questions:
            # Give a random, previously unasked question, if such remains
            next_question = potential_questions[random.randrange(len(potential_questions))]
        elif potential_questions_w_repeat:
            # Otherwise give randomly any question
            next_question = potential_questions_w_repeat[random.randrange(len(potential_questions_w_repeat))]

 
        return next_question
        

        
    def render_next_questions(self):
       
        next_question = self.choose_next_question(self.page.page_params.q_id)
        next_question_url = self.page.page_params.create_url(\
            op = PageOperation.toStr(PageOperation.TEST), \
            q_id = next_question, \
            correct="\" + q_correct + \"", incorrect="\" + q_incorrect + \"", \
            js = False)

        
        q = Question(self.page)
        q.set_from_file_with_exception()
        q.eval_with_exception()

        return next_question_url




            
