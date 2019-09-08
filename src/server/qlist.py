import json
from question import question
from repository import Repository

class qlist(object):
    language = None
    l_id = None
    page = None

    list = None


    def load_list(self, l_id = None):
        if l_id is not None:
            self.l_id = l_id

        self.list = self.repository.get_list(self.l_id)

        
    def __init__(self, repository, page, l_id, language, user_id):
        self.repository = repository
        self.page = page
        self.language = language
        self.l_id = l_id
        self.user_id = user_id

        self.load_list()

        #print(json.dumps(self.list, indent=4))
        

    def render_all_questions(self):
        for i in self.list["questions"]:
            q_id = i["name"]
            print(i, q_id)
            q = question(self.repository, self.page, q_id, self.l_id, self.language, self.user_id)
            q.set_from_file_with_exception()

            self.page.add_lines("\n<!-- QUESTION HEADER -->\n")
            self.page.add_lines("<div style='display:block;width=100%;background-color:#00f0f0'>\n")
            self.page.add_lines("Question: {}\n".format(q_id))
            self.page.add_lines("</div>\n")

            self.page.add_lines("<div style='border-style:dotted;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            q.eval_with_exception()
            self.page.add_lines("</div>")

            
