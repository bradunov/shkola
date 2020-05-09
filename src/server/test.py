import random
from server.question import Question
from server.types import PageOperation
import server.context as context

import logging

class Test(object):
    page = None
    mobile = False

    list = None


    def __init__(self, page):
        self.page = page
        self.load_list()

        #if self.page.page_params.get_param("q_id") is None or not self.page.page_params.get_param("q_id"):
        #    self.page.page_params.set_param("q_id", self.choose_next_question())



    def load_list(self):
        self.list = self.page.repository.get_list(self.page.page_params.get_param("l_id"))
        logging.info("\n\nNEXT LOAD: {}\n\n".format(self.page.page_params.get_param("l_id")))

    
    def choose_next_question(self):
            
        potential_questions = []
        potential_questions_w_repeat = []
        if context.c.session.get("history") is None:
            asked_questions = []
        else:
            asked_questions = list(map(lambda hist: hist["q_id"], context.c.session.get("history")))

        # Find the list of all question in the subtopic (potential_questions_w_repeat), 
        # and also those among them that haven't been already asked in this session (potential_questions)
        for q in self.list["questions"]:
            if self.page.page_params.get_param("subtheme") and (self.page.page_params.get_param("subtheme") == "*" or q["subtheme"] == self.page.page_params.get_param("subtheme")) and \
               self.page.page_params.get_param("period") and (self.page.page_params.get_param("period") == "*" or q["period"] == self.page.page_params.get_param("period")) and \
               self.page.page_params.get_param("difficulty") and (self.page.page_params.get_param("difficulty") == "*" or q["difficulty"] == self.page.page_params.get_param("difficulty")):
                next_q = {
                    "q_id" : q["name"],
                    "subtheme" : q["subtheme"],
                    "period" : q["period"], 
                    "difficulty" : q["difficulty"]
                }
                potential_questions_w_repeat.append(next_q)
                if not q["name"] in asked_questions:
                    potential_questions.append(next_q)

        next_question = {
            "q_id" : "",
            "subtheme" : "",
            "period" : "", 
            "difficulty" : ""
        }
        if potential_questions:
            # Give a random, previously unasked question, if such remains
            total = len(potential_questions)
            index = random.randrange(total)
            next_question = potential_questions[index]
        elif potential_questions_w_repeat:
            # Otherwise give randomly any question
            total = len(potential_questions_w_repeat)
            index = random.randrange(total)
            next_question = potential_questions_w_repeat[index]

        logging.info("\n\nNEXT Q: {} {} {}/{} {}\n\n".format(
            potential_questions_w_repeat, potential_questions, 
            index, total, next_question))
 
        return next_question
        

        
    # def render_next_questions(self, next_question=None):  
    #     if not next_question:
    #         next_question = self.choose_next_question()
    #     next_question_url = self.page.page_params.create_url(\
    #         op = PageOperation.toStr(PageOperation.TEST), \
    #         q_id = next_question, \
    #         js = False)

        
    #     q = Question(self.page)
    #     q.set_from_file_with_exception()
    #     q.eval_with_exception()

    #     return next_question_url




            
