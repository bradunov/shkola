from server.helpers import encode_dict
from server.helpers import encap_str

from server.types import PageOperation
from server.types import PageUserID
from server.types import ResponseOperation
from server.types import PageLanguage
from server.stats import Stats


class Design_dev(object):


    @staticmethod
    def render_page(page):
        if page.page_params.op == PageOperation.EDIT:
            Design_dev.render_page_edit(page)
        else:
            Design_dev.render_simple_page(page)


    @staticmethod
    def render_menu(page):
        if page.page_params.mobile:
            Design_dev.render_menu_simple(page)
        else:
            Design_dev.render_menu_full(page)


    @staticmethod
    def render_menu_full(page):
        page.add_lines("\n\n<!-- FULL MENU START -->\n")
        # Edit or view question
        if page.page_params.op == PageOperation.EDIT or page.page_params.op == PageOperation.VIEW or page.page_params.op == PageOperation.GENERATE:
            if page.page_params.op == PageOperation.GENERATE:
                page_name = PageOperation.toStr(PageOperation.EDIT)
            else:
                page_name = PageOperation.toStr(page.page_params.op)
            select="<select id='sel_q_id' name='sel_q_id' onchange='window.location.replace(" + \
                                page.page_params.create_url( \
                                    op = encap_str(page_name), \
                                    q_id = "this.value", \
                                    language = "sel_lang.value", \
                                    js = True) + ")'>\n"
            qs = page.get_all_questions(PageLanguage.toStr(page.page_params.language))
        
            for q in qs:
                if q == page.page_params.q_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(q, selected, q)
            select = select + "</select>\n"

        # View list
        elif page.page_params.op == PageOperation.LIST or page.page_params.op == PageOperation.TEST:
            select="<select id='sel_l_id' name='sel_l_id' onchange='window.location.replace(" + \
                                page.page_params.create_url(\
                                    l_id = "this.value", \
                                    language = "sel_lang.value", \
                                    js = True) + ")'>\n"
            ls = page.get_all_lists()
        
            for l in ls:
                if l == page.page_params.l_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            select = select + "</select>\n"
        else:
            select = ""



        # No need to select user in stats mode
        if not page.page_params.op == PageOperation.STATS:
            log_header = Design_dev.get_login_header(page)
        else:
            log_header = ""


        # Not sure why I have to put explicit height here, otherwise it is zero!
        page.add_lines("<div style='display:block;width=100%;height:25px;background-color:#f0f0f0'>\n")
        page.add_lines("<span style='display:block;float:left;'>\n" + select + log_header + "\n</span>\n")


        
        lright = "<span style='display:block;float:right;'>\n"

        lright = lright + \
                """<input type='button' style='font-size: 14px;' onclick='(function() {
                        var xhr = new XMLHttpRequest();
                        xhr.open("POST", "reload", true);
                        xhr.send();
                        console.log("Posted reload");
                    }) ();' value='Reload'/>  
                """
        
        if ("languages" in page.repository.get_config()):
            lang_select="Jezik: <select id='sel_lang' name='sel_lang' onchange='window.location.replace("

            if page.page_params.op == PageOperation.EDIT or page.page_params.op == PageOperation.VIEW:
                lang_select = lang_select + page.page_params.create_url(q_id = "sel_q_id.value", \
                                                            language = "this.value", \
                                                            js = True) + ")'>\n"
            # View list
            elif page.page_params.op == PageOperation.LIST or page.page_params.op == PageOperation.TEST:
                lang_select = lang_select + page.page_params.create_url(l_id = "sel_l_id.value", \
                                                            language = "this.value",
                                                            js = True) + ")'>\n"
            # Generate? 
            else:
                lang_select = lang_select + page.page_params.create_url(q_id = "sel_q_id.value", \
                                                            language = "this.value", \
                                                            js = True) + ")'>\n"
            
            for l in page.repository.get_config()["languages"]:
                if l == PageLanguage.toStr(page.page_params.language):
                    selected = "SELECTED"
                else:
                    selected = ""
                lang_select = lang_select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            lang_select = lang_select + "</select>\n"
            lright = lright + lang_select


        op_select = "Operacija: <select id='sel_op' name='sel_op' onchange='window.location.replace(" + \
                                            page.page_params.create_url(op = "sel_op.value", \
                                                            js = True) + ")'>\n"

        options = [
            PageOperation.toStr(PageOperation.EDIT),
            PageOperation.toStr(PageOperation.VIEW),
            PageOperation.toStr(PageOperation.LIST),
            PageOperation.toStr(PageOperation.TEST),
            PageOperation.toStr(PageOperation.STATS)
            ]

        for o in options:
            if o == PageOperation.toStr(page.page_params.op):
                selected = "SELECTED"
            else:
                selected = ""
            op_select = op_select + "<option value='{}' {}> {} </option>\n".format(o, selected, o)
        op_select = op_select + "</select>"
        lright = lright + op_select
        
        page.add_lines(lright)
        page.add_lines("</div>")

        page.add_lines("\n<!-- MENU END -->\n\n")




    @staticmethod
    def render_menu_simple(page):
        page.add_lines("\n\n<!-- SIMPLE MENU START -->\n")
        # Edit or view question
        if page.page_params.op == PageOperation.EDIT or page.page_params.op == PageOperation.VIEW:
            select="<select id='sel_q_id' name='sel_q_id' onchange='window.location.replace(" + \
                                page.page_params.create_url(q_id = "this.value", \
                                                language = "sel_lang.value", \
                                                js = True) + ")'>\n"

            qs = page.get_all_questions(PageLanguage.toStr(page.page_params.language))
        
            for q in qs:
                if q == page.page_params.q_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(q, selected, q)
            select = select + "</select>\n"

        # View list
        elif page.page_params.op == PageOperation.LIST or page.page_params.op == PageOperation.TEST:
            select="<select id='sel_l_id' name='sel_l_id' onchange='window.location.replace(" + \
                                page.page_params.create_url(l_id = "this.value", \
                                                language = "sel_lang.value", \
                                                js = True) + ")'>\n"
            ls = page.get_all_lists()
        
            for l in ls:
                if l == page.page_params.l_id:
                    selected = "SELECTED"
                else:
                    selected = ""
                select = select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            select = select + "</select>\n"

        
        log_header = Design_dev.get_login_header(page)

        # Not sure why I have to put explicit height here, otherwise it is zero!
        page.add_lines("<div style='display:block;width=100%;height:25px;background-color:#f0f0f0'>\n")
        page.add_lines("<span style='display:block;float:left;'>\n" + select + log_header + "\n</span>\n")
        lright = "<span style='display:block;float:right;'>\n"

        if ("languages" in page.repository.get_config()):
            lang_select="<select id='sel_lang' name='sel_lang' onchange='window.location.replace("

            if page.page_params.op == PageOperation.EDIT or page.page_params.op == PageOperation.VIEW:
                #lang_select = lang_select + "?q_id=\" + sel_q_id.value + \"&"
                lang_select = lang_select + page.page_params.create_url(q_id = "sel_q_id.value", \
                                                            language = "this.value", \
                                                            js = True) + ")'>\n"
            # View list
            elif page.page_params.op == PageOperation.LIST or page.page_params.op == PageOperation.TEST:
                lang_select = lang_select + page.page_params.create_url(l_id = "sel_l_id.value", \
                                                            language = "this.value",
                                                            js = True) + ")'>\n"
            
            for l in page.repository.get_config()["languages"]:
                if l == PageLanguage.toStr(page.page_params.language):
                    selected = "SELECTED"
                else:
                    selected = ""
                lang_select = lang_select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
            lang_select = lang_select + "</select>\n"
            lright = lright + lang_select

        
        page.add_lines(lright)
        page.add_lines("</div>")

        page.add_lines("\n<!-- MENU END -->\n\n")





    @staticmethod
    def render_page_edit(page):
        Design_dev.render_menu_full(page)

        style = "border:6px;padding:6px;"
        page.add_lines("""
        <div>
          <span style='float:left;display:inline;""" + style + """'>
            <form method="post" action='""" + page.page_params.root + """'>
              <input type="hidden" id="op" name="op" value="generate">
              <input type="hidden" id="q_id" name="q_id" value='""" + page.page_params.q_id + """'>
              <input type="hidden" id="language" name="language" value='""" + PageLanguage.toStr(page.page_params.language) + """'>
              <div style='""" + style + """background-color:#fafaf0;'>
                  <h3>Init code:</h3>
                  <textarea name="init_code" rows="10" cols="80">
                      """ + page.page_params.init_code + """
                  </textarea>
              </div>
              <div style='""" + style + """background-color:#faf0fa;'>
                  <h3>Iter code:</h3>
                  <textarea name="iter_code" rows="10" cols="80">
                      """ + page.page_params.iter_code + """
                  </textarea>
              </div>
              <div style='""" + style + """background-color:#f0fafa;'>
                  <h3>Question text:</h3>
                  <textarea name="text" rows="10" cols="80">
                      """ + page.page_params.text + """
                  </textarea>
              </div>
              <div style='""" + style + """background-color:#f0faf0;'>
                  <button type="submit">Test</button>
              </div>
                </form>
          </span>
        """)

        if page.question is not None:
            page.add_lines("<span style='float:left;display:inline'>")
            # Most common mogile web pages are 360 x 640 (https://www.hobo-web.co.uk/best-screen-size/)
            # but I can't seem to enforce a size in this view, so skipping for now
            #page.page.add_lines("<div style='border-style:dotted;display:table;height=360px;width=640px;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            page.add_lines("<div style='border-style:dotted;align-content:center;box-sizing:border-box;background-color:#ffffff'>")
            page.question.eval_with_exception(True)
            Design_dev.add_buttons(page)
            page.add_lines("</div>")
            page.add_lines("</span>")
            
        page.add_lines("""
        </div>
        """)
        





    @staticmethod
    def render_simple_page(page):
        if page.page_params.mobile:
            Design_dev.render_menu_simple(page)
        else:
            Design_dev.render_menu_full(page)
        
        if page.question is not None:
            page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>")
            page.question.eval_with_exception()
            Design_dev.add_buttons(page)
            page.add_lines("</div>")
                    




    @staticmethod    
    def get_login_header(page):
        login_str = ""

        login_return = page.page_params.all_state
        login_return["js"] = False
        login_return = encode_dict(login_return)


        test_users = ["Aran", "Petar", "Oren", "Thomas", "Ben", "Luke", "Leo", "Oliver", "Felix", "Darragh", "Jovana", "Zomebody"]
        test_users.sort()

    
        login_str = "<select id='sel_user_id' name='sel_user_id' " + \
                    "onchange='window.location.replace(\"" + page.page_params.root + "?op=login_test&" + "login_return=" + \
                    login_return + "&user_id=local:\" + this.value)'>\n"


        if page.page_params.user_id is None or not PageUserID.toStr(page.page_params.user_id):
            login_str = login_str + "<option value='NONE' SELECTED></option>\n"

        for sel_user in test_users:
            selected = ""

            if page.page_params.user_id is not None and PageUserID.toStr(page.page_params.user_id) == "local:"+sel_user:
                selected = "SELECTED"

            login_str = login_str + "<option value='{}' {}>{}</option>\n".format(sel_user, selected, sel_user)

        login_str = login_str + "</select>\n"


        return login_str






    @staticmethod    
    def add_buttons(page, url_next=None):
        page.add_lines("\n\n<!-- QUESTIONS START -->\n\n")
        page.add_lines("<div id='question' style='display:table; margin:0 auto;'>\n")
        page.add_lines("\n<div id='question_buttons' style='display:block;text-align:center;padding-top:20px;padding-bottom:6px'>\n")

        OKline = "\n\n<!-- CHECK NEXT BUTTON -->\n"
        OKline = OKline + "<input type='button' style='font-size: 14px;' onclick='{}' value='{}'/>\n".format(
            page.on_click(\
                operation=ResponseOperation.SUBMIT, \
                url_next=url_next, \
                record=True), page.get_messages()["check"])
        page.add_lines(OKline)

        if url_next is not None:
            NEXTline = ""
            NEXTline = "\n<input type='button' style='font-size: 14px;' onclick='{}' value='{}' />\n".format(
                page.on_click(\
                    operation=ResponseOperation.SKIP, \
                    url_next=url_next, \
                    record=True), page.get_messages()["skip"])
            page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
            page.add_lines(NEXTline)
            
        page.add_lines("\n<!-- END CHECK NEXT BUTTONS -->\n")



        page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
        
        page.add_lines("\n<!-- CLEAR BUTTON -->\n")
        page.add_lines("\n<input type='button' style='font-size: 14px;' onclick=\"clearAll()\" value='{}' />\n".format(
            page.get_messages()["clear"]))
        page.add_lines("\n<!-- END CLEAR BUTTON -->\n")

        page.add_lines("\n</div>\n")
        page.add_lines("</div>\n")
        page.add_lines("\n\n<!-- QUESTIONS END -->\n\n")

        

    @staticmethod
    def render_page_stats(page):
        Design_dev.render_menu(page)
        stats = Stats.render_question_stats(page)

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





