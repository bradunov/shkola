import json
from question import question



class qlist(object):
    language = None
    l_id = None
    lists_path = ""
    questions_path = ""
    page = None

    list = None


    def load_list(self, l_id = None):
        if l_id is not None:
            self.l_id = l_id

        #print(self.lists_path, self.l_id, self.lists_path + "/" + self.l_id)
        with open(self.lists_path + "/" + self.l_id, "r") as read_list:
            self.list = json.load(read_list)

    
    def __init__(self, page, l_id, language, questions_path, lists_path):
        self.page = page
        self.language = language
        self.l_id = l_id
        self.questions_path = questions_path
        self.lists_path = lists_path

        self.load_list()

        #print(json.dumps(self.list, indent=4))
        

    def render_all_questions(self):
        for i in self.list:
            q_id = i["name"]
            q = question(self.page, q_id, self.language, self.questions_path)
            q.set_from_file_with_exception()

            self.page.add_lines("\n<!-- QUESTION HEADER -->\n")
            self.page.add_lines("<div style='display:block;width=100%;background-color:#00f0f0'>\n")
            self.page.add_lines("Question: {}\n".format(q_id))
            self.page.add_lines("</div>\n")

            self.page.add_lines("<div style='border-style:dotted;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            q.eval_with_exception()
            self.page.add_lines("</div>")

            
