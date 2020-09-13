import random
import time

# from server.question import Question
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


    def _make_topic(self, q):
        return q["subtheme"] + "|" + q["topic"]


    # Choose the next question, preferrably without repeat, and return it
    # Also return the number of possible remaining questions without repeat
    def choose_next_question(self):
        log_str = "Next question for {}/{}/{}/{} - ".format(
            self.page.page_params.get_param("subtheme"),
            self.page.page_params.get_param("topic"),
            self.page.page_params.get_param("period"),
            self.page.page_params.get_param("difficulty")
        )


        # Total number of unique questions (including previously asked ones)
        remaining_question = 0

        # At least one eligible question has random values
        # (i.e. can be asked meaningully several times)
        randomized_questions = False


        potential_questions = {
            "all" : [],
            "topics" : {},
            "difficulty" : {}
        }
        potential_questions_w_repeat = []

        if context.c.session.get("history") is None:
            asked_questions = []
        else:
            asked_questions = list(map(lambda hist: hist["q_id"], context.c.session.get("history")))

        prev_question = None

        # logging.debug("\n\nQ {}\n\n{}\n{}\n{}\n\n".format(self.list["questions"], 
        #     self.page.page_params.get_param("subtheme"), self.page.page_params.get_param("period"),
        #     self.page.page_params.get_param("difficulty") ))

        # Find the list of all question in the subtopic (potential_questions_w_repeat), 
        # and also those among them that haven't been already asked in this session (potential_questions)
        for q in self.list["questions"]:
            if self.page.page_params.get_param("subtheme") and \
                    (self.page.page_params.get_param("subtheme") == "*" or \
                    q["subtheme"].lower().strip() == self.page.page_params.get_param("subtheme").lower().strip()) and \
               self.page.page_params.get_param("topic") and \
                    (self.page.page_params.get_param("topic") == "*" or \
                    q["topic"].lower().strip() == self.page.page_params.get_param("topic").lower().strip()) and \
               self.page.page_params.get_param("period") and \
                    (self.page.page_params.get_param("period") == "*" or \
                    q["period"].lower().strip() == self.page.page_params.get_param("period").lower().strip()) and \
               self.page.page_params.get_param("difficulty") and \
                    (self.page.page_params.get_param("difficulty") == "*" or \
                    q["difficulty"].lower().strip() == self.page.page_params.get_param("difficulty").lower().strip()):

                if "subtheme" not in q.keys() or "topic" not in q.keys() or \
                   "period" not in q.keys() or "difficulty" not in q.keys() or "random" not in q.keys():
                    logging.error("Problem with question {} in list {}.".format(
                        q,self.page.page_params.get_param("l_id")))

                next_q = {
                    "q_id" : q["name"].strip(),
                    "subtheme" : q["subtheme"].strip() if "subtheme" in q.keys() else "",
                    "topic" : q["topic"].strip() if "topic" in q.keys() else "",
                    "period" : q["period"].strip() if "period" in q.keys() else "", 
                    "difficulty" : q["difficulty"].strip() if "difficulty" in q.keys() else "",
                    "random" : not (q["random"] == 0) if "random" in q.keys() else False
                }

                # DEBUG
                #logging.debug("\n\nNNNNN: {}\n\n".format(next_q))
    
                if next_q["random"]:
                    randomized_questions = True
                    potential_questions_w_repeat.append(next_q)
                    remaining_question = remaining_question + 1

                if not q["name"] in asked_questions:
                    potential_questions["all"].append(next_q)
                    topic = self._make_topic(q)
                    if topic not in potential_questions["topics"].keys():
                        potential_questions["topics"][topic] = {}
                    if q["difficulty"] not in potential_questions["topics"][topic].keys():
                        potential_questions["topics"][topic][q["difficulty"]] = []
                    potential_questions["topics"][topic][q["difficulty"]].append(next_q)
                    if q["difficulty"] not in potential_questions["difficulty"].keys():
                        potential_questions["difficulty"][q["difficulty"]] = []
                    potential_questions["difficulty"][q["difficulty"]].append(next_q)
                    if not next_q["random"]:
                        # We already counted the randomized ones above
                        remaining_question = remaining_question + 1

                elif q["name"] == asked_questions[-1]:
                    prev_question = next_q
                
        next_question = {
            "q_id" : "",
            "subtheme" : "",
            "topic" : "",
            "period" : "", 
            "difficulty" : "",
            "random" : False
        }

        # Do we insiste on a specific topic in a subtheme or we can 
        is_topic_specified = not self.page.page_params.get_param("subtheme") == '*' and \
                             not self.page.page_params.get_param("topic") == '*'

        if prev_question or is_topic_specified:
            if prev_question:
                topic = self._make_topic(prev_question)
            else:
                topic = self.page.page_params.get_param("subtheme") + "|" + \
                    self.page.page_params.get_param("topic")

            if topic in potential_questions["topics"].keys():
                # There are more potential questions in the same topic that have not been asked before, choose one
                candidates = []

                if prev_question:
                    candidate_difficulty = prev_question["difficulty"]
                elif self.page.page_params.get_param("difficulty") == "*":
                    candidate_difficulty = "1"
                else:
                    candidate_difficulty = self.page.page_params.get_param("difficulty")

                log_str = log_str + "found topic {} ".format(topic)
                if candidate_difficulty in potential_questions["topics"][topic].keys():
                    # There are more questions in the same topic with the same difficulty, choose one
                    candidates = potential_questions["topics"][topic][candidate_difficulty]
                    log_str = log_str + "difficulty {} ".format(candidate_difficulty)
                elif str(int(candidate_difficulty) + 1) in potential_questions["topics"][topic].keys():
                    # There are more questions in the same topic with the next difficulty, choose one
                    candidates = potential_questions["topics"][topic][str(int(candidate_difficulty) + 1)]
                    log_str = log_str + "difficulty {} ".format(str(int(candidate_difficulty) + 1))
                elif str(int(candidate_difficulty) + 2) in potential_questions["topics"][topic].keys():
                    candidates = potential_questions["topics"][topic][str(int(candidate_difficulty) + 2)]
                    log_str = log_str + "difficulty {} ".format(str(int(candidate_difficulty) + 2))
                else:
                    log_str = log_str + "no difficulty found (!) - "

                if candidates:
                    total = len(candidates)
                    index = random.randrange(total)
                    next_question = candidates[index]
                    log_str = log_str + "selected new question: {}".format(next_question["q_id"])


        if not next_question["q_id"]:

            # A suitable question from the same topic not found, find an easy one from a new topic 
            # (if new topic allowed, otherwise potential_questions will be empty)
            candidates = []
            if "1" in potential_questions["difficulty"].keys():
                # There are more questions in the same topic with the same difficulty, choose one
                candidates = potential_questions["difficulty"]["1"]
                log_str = log_str + "new topic, difficulty: 1 - "
            elif "2" in potential_questions["difficulty"].keys():
                # There are more questions in the same topic with the next difficulty, choose one
                candidates = potential_questions["difficulty"]["2"]
                log_str = log_str + "new topic, difficulty: 2 - "
            elif "3" in potential_questions["difficulty"].keys():
                candidates = potential_questions["difficulty"]["3"]
                log_str = log_str + "new topic, difficulty: 3 - "
            else:
                log_str = log_str + "no new topics - "

            if candidates:
                total = len(candidates)
                index = random.randrange(total)
                next_question = candidates[index]
                log_str = log_str + "selected: {}- {}".format(
                    self._make_topic(next_question), next_question["q_id"])


        if not next_question["q_id"] and potential_questions_w_repeat:
            # Otherwise give randomly any previously asked randomizable question
            total = len(potential_questions_w_repeat)
            index = random.randrange(total)
            next_question = potential_questions_w_repeat[index]
            log_str = log_str + "no new topics - selected previous q: {}".format(next_question["q_id"])
        elif not next_question["q_id"]:
            log_str = log_str + "no new topics - no question selected!"

        logging.info("\n\n ************ " + log_str + "\n\n")

        logging.info("\n\nNEXT Q: {}\n\n {}\n\n {}\n\n {}\n\n".format(
             potential_questions_w_repeat, potential_questions, next_question, remaining_question))
 
        # Serve at most remaining_question
        remaining_question = (remaining_question - 1) if remaining_question > 0 else remaining_question
        logging.info("Remaining questions: {}".format(remaining_question))

        if remaining_question == 0 and not randomized_questions:
            more_questions = False
        else:
            more_questions = True

        return next_question, more_questions
        

    # Return question number in the test (starting from 1)
    def get_q_number(self):
        if context.c.session.get("history"):
            q_number = len(context.c.session.get("history"))
        else:
            q_number = 0
        return q_number



    def get_next_question_url(self, total_questions):
        # We may choose to offer fewer questions if there aren't enough available
        more_questions = False

        if not context.c.session.get("history") or len(context.c.session.get("history")) == 0:
            # Starting a new test, record the start time in epoch seconds
            context.c.session.set("test_id", int(time.time()*1000))

        next_question, more_questions = self.choose_next_question()

        q_number = self.get_q_number()
        if q_number >= total_questions or not more_questions:
            url_next = self.page.page_params.create_url( 
                op=PageOperation.toStr(PageOperation.SUMMARY),
                js=False)
        else:
            url_next = self.page.page_params.create_url( 
                op=PageOperation.toStr(PageOperation.TEST),
                q_id=next_question["q_id"], 
                q_diff=next_question["difficulty"], 
                q_num=str(q_number+1),
                js=False)

        return url_next



    def get_prev_question_url(self):
        if len(context.c.session.get("history")) <= 1:
            url_prev = self.page.page_params.create_url(\
                        op = PageOperation.toStr(PageOperation.MENU_THEME), 
                        js = False)
        else:
            q_id = context.c.session.get("history")[-2]["q_id"]
            q_diff = context.c.session.get("history")[-2]["difficulty"]
            q_number = self.get_q_number()
            url_prev = self.page.page_params.create_url(\
                        op = PageOperation.toStr(PageOperation.TEST_PREV), 
                        q_id = q_id, 
                        q_diff = q_diff,             
                        q_num = str(q_number-1),
                        js = False)

        return url_prev



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




            
