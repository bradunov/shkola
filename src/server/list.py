import random
import time

# from server.question import Question
from server.types import PageOperation
from server.types import PageLanguage
import server.context as context

import logging

class List(object):
    page = None
    mobile = False

    list = None


    def __init__(self, page):
        self.page = page
            


    def _make_topic(self, q):
        return q["subtheme"] + "|" + q["topic"]



    def _get_page_params(self):
        subtheme = self.page.page_params.get_param("subtheme").lower().strip() \
            if self.page.page_params.get_param("subtheme") and self.page.page_params.get_param("subtheme") != "*" else None

        topic = self.page.page_params.get_param("topic").lower().strip() \
            if self.page.page_params.get_param("topic") and self.page.page_params.get_param("topic") != "*" else None

        # period = self.page.page_params.get_param("period").lower().strip() \
        #     if self.page.page_params.get_param("period") and self.page.page_params.get_param("period") != "*" else None

        # difficulty = self.page.page_params.get_param("difficulty").lower().strip() \
        #     if self.page.page_params.get_param("difficulty") and self.page.page_params.get_param("difficulty") != "*" else None

        period = context.c.session.get("period").lower().strip() \
            if context.c.session.get("period") and context.c.session.get("period") != "*" else None

        difficulty = context.c.session.get("difficulty").lower().strip() \
            if context.c.session.get("difficulty") and context.c.session.get("difficulty") != "*" else None

        return subtheme, topic, period, difficulty





    ###############################################
    # BROWSE mode
    #
    # Choose the next question in the order for a given list and return it.
    # Test mode is the mode where we give questions from a theme/subtheme/topic in the order they are listed
    def choose_next_question_browse(self, last_question_id=None):
        log_str = "Next question for browse in {}/{}/{}/{}/{}/{} - ".format(
            self.page.page_params.get_param("year"), 
            self.page.page_params.get_param("theme"), 
            self.page.page_params.get_param("subtheme"),
            self.page.page_params.get_param("topic"),
            context.c.session.get("period"),
            context.c.session.get("difficulty")
        )

        if not last_question_id:
            last_question_id = context.c.session.get("browse_last_q")

        subtheme, topic, period, difficulty = self._get_page_params()

        questions = list(self.page.repository.get_content_questions(
            PageLanguage.toStr(self.page.page_params.get_param("language")), 
            self.page.page_params.get_param("year"), 
            self.page.page_params.get_param("theme"), 
            subtheme=subtheme, topic=topic, period=period, difficulty=difficulty).values())

        questions.sort(key=lambda x:[x["rank_subtheme"], x["rank_topic"], x["period"], x["difficulty"]])

        next_q = None
        prev_q = None

        if not last_question_id: 
            next_q = questions[0]
            prev_q = None
        else:
            for idx, q in enumerate(questions):
                if last_question_id == q["name"].strip():
                    if idx + 1 < len(questions):
                        next_q = questions[idx+1]
                    if idx - 1 >= 0:
                        prev_q = questions[idx-1]
                    break

        log_str += "next_q: {}, prev_q: {}".format(next_q, prev_q)
        print("\n\n\n", log_str, "\n\n\n")

        return prev_q, next_q



    def get_prev_next_questions_browse_url(self):

        prev_question, next_question = self.choose_next_question_browse()

        if prev_question:
            url_prev = self.page.page_params.create_url( 
                op=PageOperation.BROWSE,
                q_id=prev_question["name"], 
                q_num="0",
                beta=True if self.page.page_params.get_param("beta") else None)
        else:
            url_prev = None

        if next_question:
            url_next = self.page.page_params.create_url( 
                op=PageOperation.BROWSE,
                q_id=next_question["name"], 
                q_num="0",
                beta=True if self.page.page_params.get_param("beta") else None)
        else:
            url_next = None

        return url_prev, url_next








    ###############################################
    # TEST mode
    #
    # Choose the next question for the test and return it.
    # Test mode is the mode where shkola selects questions from a theme/subtheme/topic
    # based on previous answers, difficulties, etc. 
    # Questions are preferrably selected without repeat. 
    # Also return the number of possible remaining questions without repeat
    def choose_next_question_test(self):
        log_str = "Next question for test in {}/{}/{}/{}/{}/{} - ".format(
            self.page.page_params.get_param("year"), 
            self.page.page_params.get_param("theme"), 
            self.page.page_params.get_param("subtheme"),
            self.page.page_params.get_param("topic"),
            context.c.session.get("period"),
            context.c.session.get("difficulty")
        )


        # Total number of unique questions (including previously asked ones)
        remaining_question = 0


        potential_questions = {
            "all" : [],
            "topics" : {},
            "difficulty" : {}
        }
        potential_questions_w_repeat = []

        past_questions = {}

        last_question = None
        if context.c.session.get("history"):
            for hist in context.c.session.get("history"):
                last_question = hist["q_id"]
                if not hist["q_id"] in past_questions.keys():
                    past_questions[hist["q_id"]] = {
                        "number" : 1,
                        "correct" : 1 if hist["incorrect"] == 0 else 0,
                        "skipped" : ("skipped" in hist.keys() and hist["skipped"])
                    }
                else:
                    past_questions[hist["q_id"]]["number"] = past_questions[hist["q_id"]]["number"] + 1
                    if hist["incorrect"] == 0:
                        past_questions[hist["q_id"]]["correct"] = past_questions[hist["q_id"]]["correct"] + 1
                    if "skipped" in hist.keys() and hist["skipped"]:
                        past_questions[hist["q_id"]]["skipped"] = True


        prev_question = None


        # Find the list of all question in the subtopic (potential_questions_w_repeat), 
        # and also those among them that haven't been already asked in this session (potential_questions)

        subtheme, topic, period, difficulty = self._get_page_params()

        for _, next_q in self.page.repository.get_content_questions(
            PageLanguage.toStr(self.page.page_params.get_param("language")), 
            self.page.page_params.get_param("year"), 
            self.page.page_params.get_param("theme"), 
            subtheme=subtheme, topic=topic, period=period, difficulty=difficulty).items():

                add_in_random = True
                diff = 0

                if not next_q["name"] in past_questions.keys():
                    potential_questions["all"].append(next_q)
                    topic = self._make_topic(next_q)
                    if topic not in potential_questions["topics"].keys():
                        potential_questions["topics"][topic] = {}
                    if next_q["difficulty"] not in potential_questions["topics"][topic].keys():
                        potential_questions["topics"][topic][next_q["difficulty"]] = []
                    potential_questions["topics"][topic][next_q["difficulty"]].append(next_q)
                    if next_q["difficulty"] not in potential_questions["difficulty"].keys():
                        potential_questions["difficulty"][next_q["difficulty"]] = []
                    potential_questions["difficulty"][next_q["difficulty"]].append(next_q)
                    if next_q["random"] >= 10 or remaining_question >= 100:
                        diff = 100
                        remaining_question = 100
                    else:
                        diff = next_q["random"] if next_q["random"] > 0 else 1
                        remaining_question = remaining_question + diff

                else:
                    if next_q["name"] == last_question:
                        prev_question = next_q

                    ask_again = not past_questions[next_q["name"]]["skipped"]
                    ask_again = ask_again and not (\
                        (past_questions[next_q["name"]]["correct"] >= 1 and next_q["random"] < 5) or \
                        (past_questions[next_q["name"]]["correct"] >= 2 and next_q["random"] >= 5 and next_q["random"] < 10) or \
                        (past_questions[next_q["name"]]["correct"] >= 3 and next_q["random"] >= 10) \
                    )
                    ask_again = ask_again and not \
                        (next_q["random"] < 10 and next_q["random"] <= past_questions[next_q["name"]]["number"])

                    if not ask_again:
                        add_in_random = False
                    else:
                        if next_q["random"] >= 10 or remaining_question >= 100:
                            diff = 100
                            remaining_question = 100
                        else:
                            diff = next_q["random"] - past_questions[next_q["name"]]["number"] \
                                if next_q["random"] - past_questions[next_q["name"]]["number"] >= 0 else 0
                            remaining_question = remaining_question + diff


                #print("Q: {} ({}) - {} {}".format(next_q["name"], add_in_random, diff, remaining_question))

                if add_in_random:
                    potential_questions_w_repeat.append(next_q)

        # print("remaining_question={}\npotential_questions={}\npotential_questions_w_repeat={}".format(
        #     remaining_question, json.dumps(potential_questions, indent=2), json.dumps(potential_questions_w_repeat, indent=2)
        #     ))


        # if not potential_questions_w_repeat:
        #     total = len(all_potential_questions_w_repeat)
        #     index = random.randrange(total)
        #     potential_questions_w_repeat.append(all_potential_questions_w_repeat[index])


        next_question = {
            "name" : "",
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
                elif context.c.session.get("difficulty") == "*":
                    candidate_difficulty = "1"
                else:
                    candidate_difficulty = context.c.session.get("difficulty")

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
                    log_str = log_str + "selected new question: {}".format(next_question["name"])


        if not next_question["name"]:

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
                    self._make_topic(next_question), next_question["name"])


        if not next_question["name"] and potential_questions_w_repeat:
            # Otherwise give randomly any previously asked randomizable question
            total = len(potential_questions_w_repeat)
            index = random.randrange(total)
            next_question = potential_questions_w_repeat[index]
            log_str = log_str + "no new topics - selected previous q: {}".format(next_question["name"])
        elif not next_question["name"]:
            log_str = log_str + "no new topics - no question selected!"

        logging.info("\n\n ************ " + log_str + "\n\n")

        # logging.info("\n\nNEXT Q: {}\n\n {}\n\n {}\n\n {}\n\n".format(
        #      potential_questions_w_repeat, potential_questions, next_question, remaining_question))
 
        # Serve at most remaining_question
        #remaining_question = (remaining_question - 1) if remaining_question > 0 else remaining_question
        logging.info("Remaining questions: {}".format(remaining_question))

        if remaining_question == 0:
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



    def get_next_question_test_url(self, total_questions):
        # We may choose to offer fewer questions if there aren't enough available
        more_questions = False

        if not context.c.session.get("history") or len(context.c.session.get("history")) == 0:
            # Starting a new test, record the start time in epoch seconds
            context.c.session.set("test_id", int(time.time()*1000))

        next_question, more_questions = self.choose_next_question_test()

        q_number = self.get_q_number()
        if q_number >= total_questions or not more_questions:
            url_next = self.page.page_params.create_url( 
                op=PageOperation.SUMMARY,
                beta=True if self.page.page_params.get_param("beta") else None)
            url_skip = url_next
        else:
            url_next = self.page.page_params.create_url( 
                op=PageOperation.TEST,
                q_id=next_question["name"], 
                q_num=str(q_number+1),
                beta=True if self.page.page_params.get_param("beta") else None)
            url_skip = self.page.page_params.create_url( 
                op=PageOperation.TEST,
                q_id=next_question["name"], 
                q_num=str(q_number+1),
                skipped="true",
                beta=True if self.page.page_params.get_param("beta") else None)

        return url_next, url_skip



    def get_prev_question_test_url(self):
        if len(context.c.session.get("history")) <= 1:
            url_prev = self.page.page_params.create_url(\
                        op = PageOperation.MENU_THEME, 
                        beta=True if self.page.page_params.get_param("beta") else None)
        else:
            q_id = context.c.session.get("history")[-2]["q_id"]
            q_number = self.get_q_number()
            url_prev = self.page.page_params.create_url(\
                        op = PageOperation.TEST_PREV, 
                        q_id = q_id, 
                        q_num = str(q_number-1),
                        beta=True if self.page.page_params.get_param("beta") else None)

        return url_prev







            
