from helpers import *


class Design_test(object):
  

  @staticmethod
  def render_menu(page):
    Design_test.render_menu_full(page)



  @staticmethod
  def render_menu_full(page):
    page.add_lines("\n\n<!-- FULL MENU START -->\n")
    # Edit or view question
    if page.page_name == "edit" or page.page_name == "view" or page.page_name == "generate" :
        if page.page_name == "generate":
            page_name = "edit"
        else:
            page_name = page.page_name
        select="<select id='sel_q_id' name='sel_q_id' onchange='window.location.replace(" + \
                            create_url(page_name = encap_str(page_name), \
                                            q_id = "this.value", \
                                            lang = "sel_lang.value", \
                                            user_id = encap_str(page.user_id), \
                                            menu = encap_str("full"), \
                                            js = True) + ")'>\n"
        qs = page.get_all_questions(page.language)
    
        for q in qs:
            if q == page.q_id:
                selected = "SELECTED"
            else:
                selected = ""
            select = select + "<option value='{}' {}> {} </option>\n".format(q, selected, q)
        select = select + "</select>\n"

    # View list
    elif page.page_name == "list" or page.page_name == "test":
        select="<select id='sel_l_id' name='sel_l_id' onchange='window.location.replace(" + \
                            create_url(page_name = encap_str(page.page_name), \
                                            l_id = "this.value", \
                                            lang = "sel_lang.value", \
                                            user_id = encap_str(page.user_id), \
                                            menu = encap_str("full"), \
                                            js = True) + ")'>\n"
        ls = page.get_all_lists()
    
        for l in ls:
            if l == page.l_id:
                selected = "SELECTED"
            else:
                selected = ""
            select = select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
        select = select + "</select>\n"
    else:
        select = ""

    log_header = page.get_login_header()
    
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

        if page.page_name == "edit" or page.page_name == "view":
            lang_select = lang_select + create_url(page_name = encap_str(page.page_name), \
                                                        q_id = "sel_q_id.value", \
                                                        lang = "this.value", \
                                                        user_id = encap_str(page.user_id), \
                                                        menu = encap_str("full"), \
                                                        js = True) + ")'>\n"
        # View list
        elif page.page_name == "list" or page.page_name == "test":
            lang_select = lang_select + create_url(page_name = encap_str(page.page_name), \
                                                        l_id = "sel_l_id.value", \
                                                        lang = "this.value",
                                                        user_id = encap_str(page.user_id), \
                                                        menu = encap_str("full"), \
                                                        js = True) + ")'>\n"
        # Generate? 
        else:
            lang_select = lang_select + create_url(page_name = encap_str(page.page_name), \
                                                        q_id = "sel_q_id.value", \
                                                        lang = "this.value", \
                                                        user_id = encap_str(page.user_id), \
                                                        menu = encap_str("full"), \
                                                        js = True) + ")'>\n"
        
        for l in page.repository.get_config()["languages"]:
            if l == page.language:
                selected = "SELECTED"
            else:
                selected = ""
            lang_select = lang_select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
        lang_select = lang_select + "</select>\n"
        lright = lright + lang_select


    op_select = "Operacija: <select id='sel_op' name='sel_op' onchange='window.location.replace(" + \
                                        create_url(page_name = "sel_op.value", \
                                                        q_id = encap_str(page.q_id), \
                                                        l_id = encap_str(page.l_id), \
                                                        lang = encap_str(page.language), \
                                                        user_id = encap_str(page.user_id), \
                                                        menu = encap_str("full"), \
                                                        js = True) + ")'>\n"

    options = ["view", "edit", "list", "test"]

    for o in options:
        if o == page.page_name:
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
    if page.page_name == "edit" or page.page_name == "view":
        select="<select id='sel_q_id' name='sel_q_id' onchange='window.location.replace(" + \
                            create_url(page_name = encap_str(page.page_name), \
                                            q_id = "this.value", \
                                            lang = "sel_lang.value", \
                                            user_id = encap_str(page.user_id), \
                                            menu = encap_str("simple"), \
                                            js = True) + ")'>\n"

        qs = page.get_all_questions(page.language)
    
        for q in qs:
            if q == page.q_id:
                selected = "SELECTED"
            else:
                selected = ""
            select = select + "<option value='{}' {}> {} </option>\n".format(q, selected, q)
        select = select + "</select>\n"

    # View list
    elif page.page_name == "list" or page.page_name == "test":
        select="<select id='sel_l_id' name='sel_l_id' onchange='window.location.replace(" + \
                            create_url(page_name = encap_str(page.page_name), \
                                            l_id = "this.value", \
                                            lang = "sel_lang.value", \
                                            user_id = encap_str(page.user_id), \
                                            menu = encap_str("simple"), \
                                            js = True) + ")'>\n"
        ls = page.get_all_lists()
    
        for l in ls:
            if l == page.l_id:
                selected = "SELECTED"
            else:
                selected = ""
            select = select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
        select = select + "</select>\n"

    
    log_header = page.get_login_header()

    # Not sure why I have to put explicit height here, otherwise it is zero!
    page.add_lines("<div style='display:block;width=100%;height:25px;background-color:#f0f0f0'>\n")
    page.add_lines("<span style='display:block;float:left;'>\n" + select + log_header + "\n</span>\n")
    lright = "<span style='display:block;float:right;'>\n"

    if ("languages" in page.repository.get_config()):
        lang_select="<select id='sel_lang' name='sel_lang' onchange='window.location.replace("

        if page.page_name == "edit" or page.page_name == "view":
            #lang_select = lang_select + "?q_id=\" + sel_q_id.value + \"&"
            lang_select = lang_select + create_url(page_name = encap_str(page.page_name), \
                                                        q_id = "sel_q_id.value", \
                                                        lang = "this.value", \
                                                        user_id = encap_str(page.user_id), \
                                                        menu = encap_str("simple"), \
                                                        js = True) + ")'>\n"
        # View list
        elif page.page_name == "list" or page.page_name == "test":
            lang_select = lang_select + create_url(page_name = encap_str(page.page_name), \
                                                        l_id = "sel_l_id.value", \
                                                        lang = "this.value",
                                                        user_id = encap_str(page.user_id), \
                                                        menu = encap_str("simple"), \
                                                        js = True) + ")'>\n"
        
        for l in page.repository.get_config()["languages"]:
            if l == page.language:
                selected = "SELECTED"
            else:
                selected = ""
            lang_select = lang_select + "<option value='{}' {}> {} </option>\n".format(l, selected, l)
        lang_select = lang_select + "</select>\n"
        lright = lright + lang_select

    
    page.add_lines(lright)
    page.add_lines("</div>")

    page.add_lines("\n<!-- MENU END -->\n\n")



