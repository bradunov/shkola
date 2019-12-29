import json
from question import question
from repository import Repository
import logging


class qlist(object):
    language = None
    l_id = None
    page = None
    rel_path = None

    list = None


    def __init__(self, repository, page, l_id, language, user_id, rel_path=None):
        self.repository = repository
        self.page = page
        self.language = language
        self.l_id = l_id
        self.user_id = user_id
        self.rel_path = rel_path

        self.load_list()

        #logging.debug(json.dumps(self.list, indent=4))
        

    def load_list(self, l_id=None):
        if l_id is not None:
            self.l_id = l_id

        self.list = self.repository.get_list(self.l_id)

        
    def render_all_questions(self):
        for i in self.list["questions"]:
            q_id = i["name"]
            logging.debug("%d, %d", i, q_id)
            q = question(self.repository, self.page, q_id, self.l_id, self.language, self.user_id, self.rel_path)
            q.set_from_file_with_exception()

            self.page.add_lines("\n<!-- QUESTION HEADER -->\n")
            self.page.add_lines("<div style='display:block;width=100%;background-color:#00f0f0'>\n")
            self.page.add_lines("Question: {}\n".format(q_id))
            self.page.add_lines("</div>\n")

            self.page.add_lines("<div style='border-style:dotted;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            q.eval_with_exception()
            self.page.add_lines("</div>")

            
