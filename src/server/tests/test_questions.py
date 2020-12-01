import logging

import os
import sys
import json

sys.path.append("../..")
sys.path.append("C:/Users/bozidar/Documents/Code/shkola/src")

from server.app_data import AppData
from server.page import Page
from server.headers import Headers
from server.request import Request
from server.timers import TimerControl
from server.list import List
import server.context as context
from server.session import SessionDB
import server.storage


logging.basicConfig(level=logging.DEBUG, format='D: %(message)s')

# https://stackoverflow.com/a/57896847
logging.Logger.root.level = logging.DEBUG



tc = TimerControl()



use_azure_blob = False
preload = True
rel_path = "../../.."

app_data = AppData(use_azure_blob=use_azure_blob, preload=preload, rel_path=rel_path)
page = Page(app_data)


headers = Headers()
#request = Request({})
request = {}

storage = server.storage.get_storage()
sessiondb = SessionDB(storage)


page.page_params.set_param("l_id", "1_geometrija.rs")
page.page_params.set_param("year", "1")
page.page_params.set_param("theme", "Geometrija")
page.page_params.set_param("subtheme", "Linija")
page.page_params.set_param("topic", "*")
page.page_params.set_param("period", "*")
page.page_params.set_param("difficulty", "*")


print("\n\n\n\n**************************************\n\n\n")


run_test = True
run_browse = True



if run_test:
    questions = []

    with context.new_context(request, headers):
        context.c.timers = tc

        with sessiondb.init_test_session() as session:
            context.c.session = session
            #context.c.user = self.userdb.get_user(session.user_id())

            test = List(page)
            for i in range(0, 20):
                next_question, more_questions = test.choose_next_question_test()
                print("Next Q: {} / {}".format(next_question, more_questions))

                context.c.session.list_append("history", {
                    "q_id" : next_question["name"], 
                    "url" : "",
                    "correct" : 0, 
                    "incorrect" : 0,
                    "skipped" : False
                })

                next_question["more"] = more_questions

                questions.append(next_question)
                if not more_questions:
                    break

    print("Selecting: {}/{}".format(
        page.page_params.get_param("l_id"),
        page.page_params.get_param("subtheme"),
        page.page_params.get_param("topic"),
        page.page_params.get_param("period"),
        page.page_params.get_param("difficulty")
    ))

    print(json.dumps(questions, indent=2))



if run_browse:
    questions = []

    with context.new_context(request, headers):
        context.c.timers = tc

        with sessiondb.init_test_session() as session:
            context.c.session = session
            #context.c.user = self.userdb.get_user(session.user_id())

            test = List(page)

            current_question = None
            prev_question, next_question = test.choose_next_question_browse(None)
            assert prev_question == None
            current_question = next_question

            for i in range(0, 20):
                prev_question, next_question = test.choose_next_question_browse(current_question["name"])

                print("Prev/Current/Next Q: {} -- {} -- {}".format(
                    prev_question["name"] if prev_question else None, 
                    current_question["name"] if current_question else None, 
                    next_question["name"] if next_question else None
                ))

                context.c.session.list_append("history", {
                    "q_id" : current_question["name"], 
                    "url" : "",
                    "correct" : 0, 
                    "incorrect" : 0,
                    "skipped" : False
                })

                current_question["prev"] = prev_question["name"] if prev_question else None
                current_question["next"] = next_question["name"] if next_question else None

                questions.append(current_question)
                if not next_question:
                    break

                current_question = next_question


    print("Selecting: {}/{}".format(
        page.page_params.get_param("l_id"),
        page.page_params.get_param("subtheme"),
        page.page_params.get_param("topic"),
        page.page_params.get_param("period"),
        page.page_params.get_param("difficulty")
    ))

    print(json.dumps(questions, indent=2))
