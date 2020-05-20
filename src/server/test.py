import random
# from server.question import Question
# from server.types import PageOperation
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
        log_str = "Next question for {}/{}/{} - ".format(
            self.page.page_params.get_param("subtheme"),
            self.page.page_params.get_param("period"),
            self.page.page_params.get_param("difficulty")
        )

        remaining_question = 0
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
                    q["subtheme"].lower() == self.page.page_params.get_param("subtheme").lower()) and \
               self.page.page_params.get_param("period") and \
                    (self.page.page_params.get_param("period") == "*" or \
                    q["period"].lower() == self.page.page_params.get_param("period").lower()) and \
               self.page.page_params.get_param("difficulty") and \
                    (self.page.page_params.get_param("difficulty") == "*" or \
                    q["difficulty"].lower() == self.page.page_params.get_param("difficulty").lower()):
                next_q = {
                    "q_id" : q["name"],
                    "subtheme" : q["subtheme"],
                    "topic" : q["topic"],
                    "period" : q["period"], 
                    "difficulty" : q["difficulty"],
                    "random" : not (q["random"] == 0)
                }
                logging.debug("\n\nNNNNN: {}\n\n".format(next_q))
    
                if next_q["random"]:
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

        if prev_question:
            topic = self._make_topic(prev_question)
            if topic in potential_questions["topics"].keys():
                # There are more potential questions in the same topic, choose one
                candidates = []
                log_str = log_str + "found topic {} ".format(topic)
                if prev_question["difficulty"] in potential_questions["topics"][topic].keys():
                    # There are more questions in the same topic with the same difficulty, choose one
                    candidates = potential_questions["topics"][topic][prev_question["difficulty"]]
                    log_str = log_str + "difficulty {} ".format(prev_question["difficulty"])
                elif str(int(prev_question["difficulty"]) + 1) in potential_questions["topics"][topic].keys():
                    # There are more questions in the same topic with the next difficulty, choose one
                    candidates = potential_questions["topics"][topic][str(int(prev_question["difficulty"]) + 1)]
                    log_str = log_str + "difficulty {} ".format(str(int(prev_question["difficulty"]) + 1))
                elif str(int(prev_question["difficulty"]) + 2) in potential_questions["topics"][topic].keys():
                    candidates = potential_questions["topics"][topic][str(int(prev_question["difficulty"]) + 2)]
                    log_str = log_str + "difficulty {} ".format(str(int(prev_question["difficulty"]) + 2))
                else:
                    log_str = log_str + "no difficulty found (!) - "

                if candidates:
                    total = len(candidates)
                    index = random.randrange(total)
                    next_question = candidates[index]
                    log_str = log_str + "selected: {}".format(next_question["q_id"])


        if not next_question["q_id"]:
            # A suitable question from the same topic not found, find an easy one from a new topic
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

        logging.info("\n\n" + log_str + "\n\n")

        # logging.info("\n\nNEXT Q: {}\n\n {}\n\n {}\n\n {}\n\n".format(
        #      potential_questions_w_repeat, potential_questions, next_question, remaining_question))
 
        # Serve at most remaining_question
        remaining_question = (remaining_question - 1) if remaining_question > 0 else remaining_question

        return next_question, remaining_question
        

        
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




            
