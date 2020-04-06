from server.question import Question
from server.design_dev import Design_dev


# This is not (yet?) design agnostic

class Qlist(object):
    language = None
    l_id = None
    page = None

    list = None


    def __init__(self, page):
        self.page = page
        self.load_list()
        #logging.debug(json.dumps(self.list, indent=4))
        

    def load_list(self):
        self.list = self.page.repository.get_list(self.page.page_params.l_id)

        
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

            self.page.page_params.q_id = q_id
            q = Question(self.page)
            q.set_from_file_with_exception()

            self.page.add_lines("\n<!-- QUESTION HEADER -->\n")
            self.page.add_lines("<div style='display:block;width=100%;background-color:#80f0f0'>\n")
            self.page.add_lines("Question: <em>{}</em>{}\n".format(q_id, title))
            self.page.add_lines("</div>\n")

            self.page.add_lines("<div style='border-style:dotted;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            q.eval_with_exception()
            Design_dev.add_buttons(self.page)
            self.page.add_lines("</div>")

            
