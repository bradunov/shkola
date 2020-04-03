import json
from server.question import question
from server.repository import Repository
import logging

class qlist(object):
    language = None
    l_id = None
    page = None
    rel_path = None

    list = None


    def __init__(self, page, user_id, rel_path=None):
        self.page = page
        self.repository = page.repository
        self.language = page.language
        self.l_id = page.l_id
        self.user_id = user_id
        self.rel_path = rel_path

        self.load_list()

        #logging.debug(json.dumps(self.list, indent=4))
        

    def load_list(self, l_id=None):
        if l_id is not None:
            self.l_id = l_id

        self.list = self.repository.get_list(self.l_id)

        
    def render_all_questions(self):

        title = "List: <em>"
        if "name" in self.list.keys():
            title = title + self.list["name"]
        else:
            title = title + "UNKNOWN"
        title = title + "</em><div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>"
        title = title + " - "

        for key, value in self.list.items():
            if key != "name" and key != "questions":
                title = title + "<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>"
                title = title + str(key) + "=<em>" + str(value) + "</em> "

        self.page.add_lines("\n<!-- LIST HEADER -->\n")
        self.page.add_lines("<div style='display:block;width=100%;background-color:#f080f0'>\n")
        self.page.add_lines("{}\n".format(title))
        self.page.add_lines("</div>\n\n")


        for i in self.list["questions"]:
            q_id = i["name"]

            title = "<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div> - "
            for key, value in i.items():
                if key != "name" :
                    title = title + "<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>"
                    title = title + str(key) + "=<em>" + str(value) + "</em> "

            self.page.q_id = q_id
            q = question(self.page, self.user_id, self.rel_path)
            q.set_from_file_with_exception()

            self.page.add_lines("\n<!-- QUESTION HEADER -->\n")
            self.page.add_lines("<div style='display:block;width=100%;background-color:#80f0f0'>\n")
            self.page.add_lines("Question: <em>{}</em>{}\n".format(q_id, title))
            self.page.add_lines("</div>\n")

            self.page.add_lines("<div style='border-style:dotted;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            q.eval_with_exception()
            self.page.add_buttons()
            self.page.add_lines("</div>")

            
