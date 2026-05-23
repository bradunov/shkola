import traceback
from lupa import LuaRuntime
import random
from server.types import PageLanguage
from server.library import Library
from server.renderer import TemplateRenderer
import logging

        

class Question(object):
    # Lua interpreter
    lua = None

    # Libraries
    lib = None

    page = None

    q_id = None
    language = None

    # Special provisioing for Serbian cyrillic
    cyrillic = False

    questions_rel_path = "questions"
    questions_root_path = None
    
    text = ""
    init_code = None
    iter_code = None

    main_script_begin = """
      function (page, lib, strings)
    """
    main_script_end = """
      end
    """

    
    # This breaks edit mode
    #@timer_section("question.init")
    def __init__(self, page, q_id=None, language=None, test_id=None, test_order=None, 
                 init_code=None, iter_code=None, text=None, rand_vals=None):
                 
        self.lua = LuaRuntime(unpack_returned_tuples=True)
        self.page = page
        self.repository = page.repository
        self.rel_path = page.app_data.rel_path

        # If we have more questions on the same page make sure all use pseudo-random thus unique IDs
        self.q_unique_id = str(int(random.random() * 1000000000))

        if q_id:
            self.q_id = q_id
        else:
            self.q_id = page.page_params.get_param("q_id")
        self.page.add_script_lines("<script> global_q_id = \"{}\";</script>".format(self.q_id))

        if language:
            self.language = language
        else:
            self.language = page.page_params.get_param("language")

        # Special provisioing for Serbian cyrillic
        if self.language == PageLanguage.RSC:
            self.language = PageLanguage.RS
            self.cyrillic = True

        self.page.add_script_lines("<script> global_language = \"{}\";</script>".format(PageLanguage.toStr(self.language)))

        # Parameters useful for error reporting
        if self.page.page_params.get_param("l_id"):
            self.page.add_script_lines("<script> global_l_id = \"{}\";</script>".format(self.page.page_params.get_param("l_id")))
        if self.page.page_params.get_param("root"):
            self.page.add_script_lines("<script> global_root = \"{}\";</script>".format(self.page.page_params.get_param("root")))

        self.test_id = test_id if test_id else 0
        self.test_order = test_order if test_order else 0

        if not init_code is None:
            self.init_code = init_code
        else:
            self.init_code = page.page_params.get_param("init_code")

        if not iter_code is None:
            self.iter_code = iter_code
        else:
            self.iter_code = page.page_params.get_param("iter_code")

        if not text is None:
            self.text = text
        else:
            self.text = page.page_params.get_param("text")

        self.lib = Library(self, rand_vals=rand_vals)
        logging.debug("Rendering question %s, language=%s", 
            self.question_url(), PageLanguage.toStr(self.language))
        self.questions_root_path = self.rel_path + "/" + self.questions_rel_path


    def question_url(self):
        return self.questions_rel_path + "/" + self.q_id


    def set_from_file(self):
        self.init_code = ""
        self.iter_code = ""
        self.text = "\n\n<h3>ERROR: no code exists for question '{}' for language '{}'!</h3>".format(
            self.q_id, PageLanguage.toStr(self.language)
        )
        
        self.page.add_lines("\n<!-- Rendering question '{}' for language '{}' -->\n\n".format(
            self.q_id, PageLanguage.toStr(self.language)
        ))

        q = self.repository.get_question(self.q_id)
        if q is None:
            return

        if "init.lua" in q.keys():
            #logging.debug("%s, %s", str(q.keys()), str(q))
            self.init_code = q["init.lua"]

        if "iter.lua" in q.keys():
            self.iter_code = q["iter.lua"]

        text_key = "text." + PageLanguage.toStr(self.language)
        if text_key in q.keys():
            self.text = q[text_key]
        else:
            logging.error("Question '{}' not found ({}).".format(self.q_id, text_key))
            
            
    def set_from_file_with_exception(self):
        self.set_from_file()
        
        # try:
        #     self.set_from_file()
        # except Exception as err:
        #     err_str = "\n\n<br> Error reading from a question list: \n {} <br>\n".format(str(err))
        #     self.page.add_lines(err_str)
        #     for l in traceback.format_tb(err.__traceback__):
        #         self.page.add_lines("<br> {}".format(l))
        
        
    def set_init_code(self, code):
        self.init_code = code

    def set_iter_code(self, code):
        self.iter_code = code

    def set_text(self, text):
        self.text = text

    def get_init_code(self):
        return self.init_code
        
    def get_iter_code(self):
        return self.iter_code

    def get_text(self):
        return self.text


    def eval(self, page):
        """Render the question template using the grammar-based renderer."""

        self.page.add_lines("\n\n<!-- QUESTIONS START -->\n\n")
        self.page.add_lines("<div id='question' style='display:inline-block; margin:0 auto; width: inherit'>\n")
        self.page.add_lines("<script>var test_id = {}; var test_order = {};</script>\n".format(
            self.test_id, self.test_order))

        renderer = TemplateRenderer(self)
        renderer.render(self.text, self.init_code, self.iter_code)

        if self.lib is not None:
            self.lib.add_check_button_code()
            self.lib.add_clear_button_code()
            self.lib.add_solution_button_code()
            self.lib.add_error_report_button_code()

        self.page.add_lines("</div>\n")
        self.page.add_lines("\n\n<!-- QUESTIONS END -->\n\n")


        
        
    # This breaks edit mode
    #@timer_section("question.eval_with_exception")
    def eval_with_exception(self, catch=False):

        if not catch:
            # Don't catch the exception here
            # Pass the exception to the server for unit testing
            self.eval(self.page)

        else:
            # In edit mode we want to catch so a user can make mistakes
            try:
                self.eval(self.page)
            except Exception as err:
                err_str = "\n\n<br> Error in program:\n {} <br>\n".format(str(err))
                self.page.add_lines(err_str)
                for l in traceback.format_tb(err.__traceback__):
                    self.page.add_lines("<br> {}".format(l))
    
