import logging

import os
import sys
import json

sys.path.append("../..")
sys.path.append("C:/Users/bozidar/Documents/Code/shkola/src")

from server.page import Page
from server.headers import Headers
from server.request import Request
from server.timers import TimerControl
from server.test import Test
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

page = Page(use_azure_blob=use_azure_blob, preload=preload, rel_path=rel_path)


headers = Headers()
#request = Request({})
request = {}

storage = server.storage.get_storage()
sessiondb = SessionDB(storage)


page.page_params.set_param("l_id", "1_geometrija.rs")
page.page_params.set_param("subtheme", "Linija")
page.page_params.set_param("topic", "*")
page.page_params.set_param("period", "*")
page.page_params.set_param("difficulty", "*")


questions = []

with context.new_context(request, headers):
    context.c.timers = tc

    with sessiondb.init_test_session() as session:
        context.c.session = session
        #context.c.user = self.userdb.get_user(session.user_id())

        test = Test(page)
        for i in range(0, 20):
            next_question, more_questions = test.choose_next_question()
            print("Next Q: {} / {}".format(next_question, more_questions))

            context.c.session.list_append("history", {
                "q_id" : next_question["q_id"], 
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
