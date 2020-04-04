from helpers import *
from types import *


class Design_prod(object):
  


  @staticmethod
  def render_page(page):
      menu = "full"

      Design_prod.render_menu(menu)
      
      if page.question is not None:
          page.add_lines("<div style='width: auto ;margin-left: auto ;margin-right: auto ;'>")
          page.question.eval_with_exception()
          Design_prod.add_buttons()
          page.add_lines("</div>")
                  


  # Inspired by https://www.w3schools.com/w3css/w3css_sidebar.asp

  @staticmethod
  def render_menu(page):
    page.add_lines("\n\n<!-- MOBILE MENU START -->\n")

    # Temporary, for debugging:
    debug_str = ""
    if page.user_id is not None and page.user_id:
        if len(page.user_id) >= len("local:") and page.user_id[:len("local:")] == "local:":
            debug_str = debug_str + "Hi {} ".format(page.user_id[len("local:"):])
        else:
            debug_str = debug_str + "Hi {} ".format(page.user_id)
    if page.q_id is not None and page.q_id:
        debug_str = debug_str + "(Q: {})".format(page.q_id)


    page.add_lines("""
        <script>
        function myAccFunc(title) {
            var x = document.getElementById(title);
            if (x.className.indexOf("w3-show") == -1) {
            x.className += " w3-show";
            x.previousElementSibling.className += " w3-green";
            } else { 
            x.className = x.className.replace(" w3-show", "");
            x.previousElementSibling.className = 
            x.previousElementSibling.className.replace(" w3-green", "");
            }
        }
        function shm_toggle() {
            if (document.getElementById("shMenu").style.display == "none") {
                document.getElementById("shMenu").style.display = "block";
            } else {
                document.getElementById("shMenu").style.display = "none";
            }
        }
        function shl_toggle() {
            if (document.getElementById("shLang").style.display == "none") {
                document.getElementById("shLang").style.display = "block";
            } else {
                document.getElementById("shLang").style.display = "none";
            }
        }
        </script>
        <div class="w3-dark-grey">
        <button class="w3-button w3-dark-grey w3-large" onclick="shm_toggle()">☰</button>
        """ + debug_str + """
        <span style='display:block;float:right;'>
        <button class="w3-button w3-dark-grey w3-large" onclick="shl_toggle()">""" + page.get_messages()["language"] + """</button>
        </span>
        </div>
        <div class="w3-sidebar w3-bar-block w3-border-right" style="display:none" id="shMenu">
            <button class="w3-button w3-block w3-left-align" onclick="myAccFunc('accLevel')">
                """ + page.get_messages()["questions"] + """ <i class="fa fa-caret-down"></i>
            </button>
            <div id='accLevel' class="w3-hide w3-white w3-card">
    """)


    Design_prod.render_menu_drop(page, page.language, base_url("mobile") + "?op={}&language={}&menu={}&user_id={}".format(
        page.page_name, page.language, "mobile", page.user_id ), 1)



    page.add_lines("""
            </div>

            <button class="w3-button w3-block w3-left-align" onclick="myAccFunc('accUser')">
                """ + page.get_messages()["user"] + """ <i class="fa fa-caret-down"></i>
            </button>
            <div id='accUser' class="w3-hide w3-white w3-card">
    """)


    page.add_lines(Design_prod.get_login_header(page, True))


    page.add_lines("""
            </div>
        </div>
    """)

    if ("languages" in page.repository.get_config()):
        
        lang_select = """
                    <div class="w3-sidebar w3-bar-block w3-border-left" style="width:200px;right:0;display:none"  id="shLang">
                    """
        for lang in page.get_language_list():
            lang_select = lang_select + "<a href='" + \
                    create_url(page_name = page.page_name, \
                                            lang = lang, \
                                            user_id = page.user_id, \
                                            menu = "mobile", \
                                            js = False) + \
                    "' class='w3-bar-item w3-button'>" + page.get_messages(lang)["name"] + "</a>"
        
        lang_select = lang_select + """
                    </div>
                    """
        page.add_lines(lang_select)




    page.add_lines("\n<!-- MENU END -->\n\n")




    '''
  @staticmethod
  def render_content(page, language, level="Prvi"):
    content = page.repository.get_content(language)

    if level not in content.keys():
      logging.info("No level %s in content, rendering empty page", level)
      return

    for theme_name in sorted(content[level].keys()):
      theme_dict = content[level][theme_name]

      page.add_lines("\n\n<!-- NEW THEME -->\n")
      page.add_lines("  <div style='display:inline-block;font-weight:bold;font-size:18px;padding-top:6px;padding-bottom:4px;'>\n")
      page.add_lines("    {}\n".format(theme_name))
      page.add_lines("  </div>\n")
      page.add_lines("<div style='display:table;padding-top:0px;padding-bottom:0px;float:center'> </div>")

      for label in theme_dict.keys():
        page.add_lines("    <div style='display:inline-block;font-weight:bold;font-size:14px;padding-top:4px;padding-bottom:2px;'>\n")
        page.add_lines("      <div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
        page.add_lines("      <a href=''>{}</a>\n".format(label))
        page.add_lines("    </div>\n")
        page.add_lines("<div style='display:table;padding-top:0px;padding-bottom:0px;float:center'> </div>")
    '''




  @staticmethod
  def render_menu_drop(page, language, link, indent=0):
    content = page.repository.get_content(language)

    str_indent1 = ""
    for i in range(0, indent):
      str_indent1 = str_indent1 + "<div class='space'></div>"
    str_indent2 = str_indent1 + "<div class='space'></div>"

    for level in sorted(content.keys()):
      page.add_lines("""
        <button class="w3-button w3-block w3-left-align" onclick="myAccFunc('acc""" + level + """')">
          """ + str_indent1 + level + """ <i class="fa fa-caret-down"></i>
        </button>
        <div id='acc""" + level + """' class="w3-hide w3-white w3-card">
      """)

      for theme in sorted(content[level].keys()):
        page.add_lines("""
          <a href='""" + link + "&l_id=" + content[level][theme]["name"] + """' class="w3-bar-item w3-button"> """ + str_indent2 + theme + """</a>
        """)

      page.add_lines("</div>")
        




  @staticmethod    
  def get_login_header(page, mobile=False):
      login_str = ""

      if mobile:
          menu = "simple"
      else:
          menu = "full"


      login_return = {}
      login_return["page_name"] = page.page_name
      login_return["q_id"] = page.q_id
      login_return["l_id"] = page.l_id
      login_return["lang"] = page.language
      login_return["user_id"] = page.user_id
      login_return["menu"] = menu
      login_return["js"] = False
      login_return = encode_dict(login_return)


      test_users = ["Aran", "Petar", "Oren", "Thomas", "Ben", "Luke", "Leo", "Oliver", "Felix", "Darragh", "Jovana", "Zomebody"]
      test_users.sort()

  
      login_str = "<select id='sel_user_id' name='sel_user_id' " + \
                  "onchange='window.location.replace(\"" + base_url(menu) + "?op=login_test&" + "login_return=" + \
                  login_return + "&user_id=\" + this.value)'>n"


      if page.user_id is None or not page.user_id:
          login_str = login_str + "<option value='NONE' SELECTED></option>"

      for sel_user in test_users:
          selected = ""
          if page.user_id is not None and page.user_id == "local:"+sel_user:
              selected = "SELECTED"

          login_str = login_str + "<option value='{}' {}>{}</option>".format(sel_user, selected, sel_user)

      login_str = login_str + "</select>\n"


      return login_str





  @staticmethod    
  def add_buttons(page, url_next=None):
      page.add_lines("\n\n<!-- QUESTIONS START -->\n\n")
      page.add_lines("<div id='question' style='display:table; margin:0 auto;'>\n")
      page.add_lines("\n<div id='question_buttons' style='display:block;text-align:center;padding-top:20px;padding-bottom:6px'>\n")

      OKline = "\n\n<!-- CHECK NEXT BUTTON -->\n"
      OKline = OKline + "<input type='button' style='font-size: 14px;' onclick='{}' value='{}'/>\n".format(
          page.on_click(Operation.SUBMIT, url_next), page.get_messages()["check"])
      page.add_lines(OKline)

      if url_next is not None:
          NEXTline = ""
          NEXTline = "\n<input type='button' style='font-size: 14px;' onclick='{}' value='{}' />\n".format(
              page.on_click(Operation.SUBMIT, url_next), page.get_messages()["skip"])
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

      



