from server.question import Question
from server.types import PageOperation
# from server.types import ResponseOperation
import logging

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
        self.list = self.page.repository.get_list(self.page.page_params.get_param("l_id"))

        
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

        # DEBUG
        #print(json.dumps(self.list, indent=2))

        for i in self.list["questions"]:
            q_id = i["name"]

            title = "<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div> - "
            for key, value in i.items():
                if key != "name" :
                    title = title + "<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>"
                    title = title + str(key) + "=<em>" + str(value) + "</em> "

            self.page.page_params.set_param("q_id", q_id)
            q = Question(self.page)
            q.set_from_file_with_exception()

            self.page.add_lines("\n<!-- QUESTION HEADER -->\n")
            self.page.add_lines("<div style='display:block;width=100%;background-color:#80f0f0'>\n")
            self.page.add_lines("Question: <a href='{}'><em>{}</em></a>{}\n".format(\
                self.page.page_params.create_url( \
                                    op = PageOperation.VIEW, \
                                    q_id = q_id, \
                                    beta = True if self.page.page_params.get_param("beta") else None, 
                                    js = False), \
                q_id, title))
            self.page.add_lines("</div>\n")

            self.page.add_lines("<div style='border-style:dotted;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            try:
                q.eval_with_exception()
            except:
                self.page.add_lines("Problem with the question!\n")
                logging.error("\n\nERROR: problem with question {}!\n\n".format(q_id))
                pass
            self.add_buttons(self.page, q)
            self.page.add_lines("</div>")

            
    # Different buttons for q_list with different check per each question
    def add_buttons(self, page, question):
        lib_id = question.lib.lib_id
        
        page.add_lines("\n\n<!-- QUESTIONS START -->\n\n")
        page.add_lines("<div id='question' style='display:table; margin:0 auto;'>\n")
        page.add_lines("\n<div id='question_buttons' style='display:block;text-align:center;padding-top:20px;padding-bottom:6px'>\n")

        OKline = "\n\n<!-- CHECK BUTTON -->\n"
        OKline = OKline + "<input type='button' style='font-size: 14px;' onclick='checkAll_{}()' value='{}'/>\n".format(
            lib_id, page.get_messages()["check"])
        page.add_lines(OKline)            
        page.add_lines("\n<!-- END CHECK BUTTONS -->\n")



        page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
        
        page.add_lines("\n<!-- CLEAR BUTTON -->\n")
        page.add_lines("\n<input type='button' style='font-size: 14px;' onclick=\"clearAll_{}()\" value='{}' />\n".format(
            lib_id, page.get_messages()["clear"]))
        page.add_lines("\n<!-- END CLEAR BUTTON -->\n")



        page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
        
        page.add_lines("\n<!-- SOLUTION BUTTON -->\n")
        page.add_lines("\n<input type='button' style='font-size: 14px;' onclick=\"addSolutionAll_{}()\" value='{}' />\n".format(
            lib_id, "Resenje"))
        page.add_lines("\n<!-- END SOLUTION BUTTON -->\n")



        page.add_lines("\n</div>\n")
        page.add_lines("</div>\n")
        page.add_lines("\n\n<!-- QUESTIONS END -->\n\n")
