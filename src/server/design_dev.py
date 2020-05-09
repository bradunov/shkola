from server.helpers import encap_str

from server.types import PageOperation
from server.types import ResponseOperation
from server.types import PageLanguage
from server.stats import Stats
# from server.user_db import TEST_USERS
# import server.context as context

import server.question as question
import server.qlist as qlist

import logging

class Design_dev(object):



    @staticmethod
    def render_main_page(page):

        # Select default
        if not page.page_params.get_param("op") == PageOperation.EDIT and \
           not page.page_params.get_param("op") == PageOperation.GENERATE and \
           not page.page_params.get_param("op") == PageOperation.LIST and \
           not page.page_params.get_param("op") == PageOperation.STATS and \
           not page.page_params.get_param("op") == PageOperation.VIEW:
            page.page_params.set_param("op", PageOperation.VIEW)


        if page.page_params.get_param("op") == PageOperation.EDIT:
            logging.debug("PageOperation.EDIT")
            if not page.page_params.get_param("q_id"):
                page.page_params.set_param("q_id", page.get_default_question())
            q = question.Question(page, test_mode=True)
            q.set_from_file_with_exception()
            page.add_question(q)
            page.add_code(q.get_init_code(), q.get_iter_code(), q.get_text())
            Design_dev.render_edit(page)
            return page.render()
            
        elif page.page_params.get_param("op") == PageOperation.GENERATE:
            logging.debug("PageOperation.GENERATE")
            # Use init_code, iter_code, text from the page's parameter 
            # (as submitted by user) and go to edit mode
            page.page_params.set_param("op", PageOperation.EDIT)
            q = question.Question(page, test_mode=True)
            page.add_question(q)
            Design_dev.render_edit(page)
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.LIST:
            logging.debug("PageOperation.LIST")
            if not page.page_params.get_param("l_id"):
                page.page_params.set_param("l_id", page.get_default_list())
            Design_dev.render_menu(page)
            ql = qlist.Qlist(page)
            ql.render_all_questions()
            return page.render()

        elif page.page_params.get_param("op") == PageOperation.STATS:
            Design_dev.render_page_stats(page)
            return page.render()

        else:
        #elif page.page_params.get_param("op") == PageOperation.VIEW:
            logging.debug("PageOperation.VIEW")
            if not page.page_params.get_param("q_id"):
                page.page_params.set_param("q_id", page.get_default_question())
            q = question.Question(page, test_mode=True)
            q.set_from_file_with_exception()
            page.add_question(q)
            Design_dev.render_view(page)
            return page.render()






    @staticmethod
    def render_menu(page):

        page.template_params["menu"] = {}

        
        ### Questions/lists
        # Edit or view question
        if page.page_params.get_param("op") == PageOperation.EDIT or page.page_params.get_param("op") == PageOperation.VIEW or page.page_params.get_param("op") == PageOperation.GENERATE:
            if page.page_params.get_param("op") == PageOperation.GENERATE:
                page_name = PageOperation.toStr(PageOperation.EDIT)
            else:
                page_name = PageOperation.toStr(page.page_params.get_param("op"))

            page.template_params["menu"]["current_choice"] = page.page_params.get_param("q_id")
            page.template_params["menu"]["choices"] = page.get_all_questions(PageLanguage.toStr(page.page_params.get_param("language")))
            page.template_params["menu"]["choice_action"] = page.page_params.create_url( \
                                    op = encap_str(page_name), \
                                    q_id = "this.value", \
                                    language = "sel_lang.value", \
                                    js = True)

        # View list
        elif page.page_params.get_param("op") == PageOperation.LIST or page.page_params.get_param("op") == PageOperation.TEST:
            page.template_params["menu"]["current_choice"] = page.page_params.get_param("l_id")
            page.template_params["menu"]["choices"] = page.get_all_lists()
            page.template_params["menu"]["choice_action"] = page.page_params.create_url(\
                                    l_id = "this.value", \
                                    language = "sel_lang.value", \
                                    js = True)



        ### Languages
        page.template_params["menu"]["languages"] = page.get_language_list()
        page.template_params["menu"]["current_language"] = PageLanguage.toStr(page.page_params.get_param("language"))
        if page.page_params.get_param("op") == PageOperation.EDIT or page.page_params.get_param("op") == PageOperation.VIEW:
            page.template_params["menu"]["language_action"] = page.page_params.create_url(q_id = "choice_id.value", \
                                                        language = "this.value", \
                                                        js = True)
        # View list
        elif page.page_params.get_param("op") == PageOperation.LIST or page.page_params.get_param("op") == PageOperation.TEST:
            page.template_params["menu"]["language_action"] = page.page_params.create_url(l_id = "choice_id.value", \
                                                        language = "this.value",
                                                        js = True)
        # Generate? 
        else:
            page.template_params["menu"]["language_action"] = page.page_params.create_url(q_id = "choice_id.value", \
                                                        language = "this.value", \
                                                        js = True)
        



        ### Operations
        options = [
            PageOperation.toStr(PageOperation.EDIT),
            PageOperation.toStr(PageOperation.VIEW),
            PageOperation.toStr(PageOperation.LIST),
            PageOperation.toStr(PageOperation.STATS)
            ]
        page.template_params["menu"]["operations"] = options
        page.template_params["menu"]["current_operation"] = PageOperation.toStr(page.page_params.get_param("op"))
        page.template_params["menu"]["operation_action"] = page.page_params.create_url(op = "sel_op.value", \
                                                            js = True)








    @staticmethod
    def render_edit(page):

        page.template_params["template_name"] = "dev/edit.html.j2"

        Design_dev.render_menu(page)

        page.template_params["action"] = page.page_params.get_param("root")
        page.template_params["q_id"] = page.page_params.get_param("q_id")
        page.template_params["language"] = PageLanguage.toStr(page.page_params.get_param("language"))

        page.template_params["init_code"] = page.page_params.get_param("init_code")
        page.template_params["iter_code"] = page.page_params.get_param("iter_code")
        page.template_params["text"] = page.page_params.get_param("text")

        if page.question is not None:
            page.question.eval_with_exception(True)






    @staticmethod
    def render_view(page):

        page.template_params["template_name"] = "dev/view.html.j2"

        Design_dev.render_menu(page)
        
        if page.question is not None:
            page.question.eval_with_exception()
                    




    # @staticmethod
    # def render_list(page):

    #     page.template_params["template_name"] = "dev/view.html.j2"

    #     Design_dev.render_menu(page)
        
    #     if page.question is not None:
    #         page.question.eval_with_exception()
                    






    # @staticmethod    
    # def add_buttons(page, url_next=None):
    #     page.add_lines("\n\n<!-- QUESTIONS START -->\n\n")
    #     page.add_lines("<div id='question' style='display:table; margin:0 auto;'>\n")
    #     page.add_lines("\n<div id='question_buttons' style='display:block;text-align:center;padding-top:20px;padding-bottom:6px'>\n")

    #     OKline = "\n\n<!-- CHECK NEXT BUTTON -->\n"
    #     OKline = OKline + "<input type='button' style='font-size: 14px;' onclick='{}' value='{}'/>\n".format(
    #         Design_dev.on_click(page, \
    #             operation=ResponseOperation.SUBMIT, \
    #             url_next=url_next, \
    #             record=False), page.get_messages()["check"])
    #     page.add_lines(OKline)

    #     if url_next is not None:
    #         NEXTline = ""
    #         NEXTline = "\n<input type='button' style='font-size: 14px;' onclick='{}' value='{}' />\n".format(
    #             Design_dev.on_click(page, \
    #                 operation=ResponseOperation.SKIP, \
    #                 url_next=url_next, \
    #                 record=False), page.get_messages()["skip"])
    #         page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
    #         page.add_lines(NEXTline)
            
    #     page.add_lines("\n<!-- END CHECK NEXT BUTTONS -->\n")


    #     page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
        
    #     page.add_lines("\n<!-- CLEAR BUTTON -->\n")
    #     page.add_lines("\n<input type='button' style='font-size: 14px;' onclick=\"clearAll()\" value='{}' />\n".format(
    #         page.get_messages()["clear"]))
    #     page.add_lines("\n<!-- END CLEAR BUTTON -->\n")


    #     page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
        
    #     page.add_lines("\n<!-- SOLUTION BUTTON -->\n")
    #     page.add_lines("\n<input type='button' style='font-size: 14px;' onclick=\"addSolutionAll()\" value='{}' />\n".format(
    #         "Resenje"))
    #     page.add_lines("\n<!-- END SOLUTION BUTTON -->\n")


    #     page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
        
    #     page.add_lines("\n<!-- ERROR REPORT BUTTON -->\n")
    #     page.add_lines("\n<input type='button' style='font-size: 14px;' " \
    #         "onclick=\"sendFeedbackToServer('{}', 'test', '{}', '{}', 'comment')\" value='{}' />\n".format(
    #         page.page_params.get_param("root"), 
    #         page.page_params.get_param("q_id"),
    #         page.page_params.get_param("l_id"),
    #         "Prijavi gresku"))
    #     page.add_lines("\n<!-- ERROR REPORT BUTTON -->\n")


    #     page.add_lines("\n</div>\n")
    #     page.add_lines("</div>\n")
    #     page.add_lines("\n\n<!-- QUESTIONS END -->\n\n")

        

    @staticmethod
    def render_page_stats(page):
        Design_dev.render_menu(page)

        try:
            stats = Stats.render_question_stats()

            for folder in stats.keys():            
                page.add_lines("<h2> {} </h2><br>\n".format(folder))
                page.add_lines("<table style='border: 1px solid black; border-collapse: collapse; border-spacing: 10px 0;'>")

                page.add_lines("  <tr style='border: 1px solid black'>")
                page.add_lines("    <th style='border: 1px solid black'>Pitanje</th>")
                page.add_lines("    <th style='border: 1px solid black'>Ukupno odgovora</th>")
                page.add_lines("    <th colspan='{}' style='border: 1px solid black'> Statistika po podpitanjima</th>".format(
                    stats[folder]["width"]))
                page.add_lines("  </tr>")

                for q in stats[folder]["content"]:
                    hspace = "<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>"
                    page.add_lines("  <tr style='border: 1px solid black'>")
                    page.add_lines("<th style='border: 1px solid black'>{}{}{}</th>".format(hspace, q["q_id"], hspace))
                    page.add_lines("<th style='border: 1px solid black'>{}{}{}</th>".format(hspace, q["total"], hspace))
                    #line = "<br><b>{}</b>: ukupno odgovora {}, tacno po pitanjima ".format(q_id, total)
                    for s in q["correct"]:
                        page.add_lines("<th style='border: 1px solid black'>{}{:3d}%{}</th>".format(
                            hspace, int(100 * s / q["total"]), hspace))
                    for s in range(0, stats[folder]["width"] - len(q["correct"])):
                        page.add_lines("<th style='border: 1px solid black'></th>")
                    page.add_lines("<tr>\n")
                page.add_lines("</table><br>")
        except:
            page.add_lines("There was a problem generating stats.")
            pass



    @staticmethod
    def _render_user_one_cat_rec(page, cat, desc, indent):
        hspace = "<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>"

        page.add_lines("  <tr>")

        if indent > 1:
            page.add_lines("<td></td> ")

        page.add_lines("<td style='text-align:left'>{}{}{}</td> ".format(hspace, desc, hspace))

        if indent <= 1:
            page.add_lines("<td></td> ")

        if "all" in cat.keys():
            page.add_lines("<td style='text-align:center'>{}{}/{}({:3d}%/{:3d})%{}</td> ".format(
                hspace,
                cat["all"]["total"],
                cat["all"]["subtotal"], 
                int(cat["all"]["questions"]*100), 
                int(cat["all"]["subquestions"]*100),
                hspace
            ))
        else:
            page.add_lines("<td></td> ")

        for d in range(1,4):
            diff = str(d)
            if "difficulty" in cat.keys() and diff in cat["difficulty"].keys():
                page.add_lines("<td style='text-align:center'>{}{}/{}({:3d}%/{:3d}%){}</td> ".format(
                    hspace, 
                    cat["difficulty"][diff]["total"],
                    cat["difficulty"][diff]["subtotal"], 
                    int(cat["difficulty"][diff]["questions"]*100), 
                    int(cat["difficulty"][diff]["subquestions"]*100),
                    hspace
                ))
            else:
                page.add_lines("<td></td> ")
        page.add_lines("</tr>\n")

        for kt in cat.keys():
            if not (kt == "all" or kt == "difficulty"):
                for k in cat[kt].keys():
                    Design_dev._render_user_one_cat_rec(page, cat[kt][k], k, indent+1)




    @staticmethod
    def render_user_stats(page, u_id):
        Design_dev.render_menu(page)
        stats = Stats.render_user_stats(page, u_id)

        hspace = "<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>"
        page.add_lines("<table style='border: none; border-collapse: collapse;'>")
        page.add_lines("<tr><td style='text-align:left'>{}Oblast{}</td> ".format(hspace, hspace) + \
                "<td style='text-align:left'>{}Tema{}</td> ".format(hspace, hspace) + \
                "<td style='text-align:center'>{}Svi zadaci{}</td> ".format(hspace, hspace) + \
                "<td style='text-align:center'>{}1 zvezda{}</td> ".format(hspace, hspace) + \
                "<td style='text-align:center'>{}2 zvezde{}</td> ".format(hspace, hspace) + \
                "<td style='text-align:center'>{}3 zvezde{}</td> ".format(hspace, hspace) + \
                "</tr>\n")
        Design_dev._render_user_one_cat_rec(page, stats, "Svi", 0)
        page.add_lines("</table><br>")




    # @staticmethod
    # def on_click(page, operation:ResponseOperation=None, url_next=None, record=False, quoted=True):
    #     if record:
    #         # Only send results to server if next_url specified (i.e. we are in the test mode)
    #         ret_str = 'cond = checkAll("{}", "{}", "{}", "{}");'.format(
    #             ResponseOperation.toStr(operation),
    #             page.page_params.get_param("root"),
    #             page.page_params.get_param("q_id"),
    #             page.page_params.get_param("l_id")
    #         )
    #     else:
    #         ret_str = "cond = checkAll();"

    #     if url_next is not None:
    #         if operation == ResponseOperation.SUBMIT:
    #             ret_str = ret_str + "if (cond) "
    #         if quoted:
    #             ret_str = ret_str + " {window.location.replace(\"" + url_next + "\");}"
    #         else:
    #             ret_str = ret_str + " {window.location.replace(" + url_next + ");}"

    #     return ret_str





