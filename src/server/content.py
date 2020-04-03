import logging


class Content(object):
    page = None

    def __init__(self, page):
        self.page = page



    def render_content(self, language, level="Prvi"):
      content = self.page.repository.get_content(language)

      if level not in content.keys():
        logging.info("No level %s in content, rendering empty page", level)
        return

      for theme_name in sorted(content[level].keys()):
        theme_dict = content[level][theme_name]

        self.page.add_lines("\n\n<!-- NEW THEME -->\n")
        self.page.add_lines("  <div style='display:inline-block;font-weight:bold;font-size:18px;padding-top:6px;padding-bottom:4px;'>\n")
        self.page.add_lines("    {}\n".format(theme_name))
        self.page.add_lines("  </div>\n")
        self.page.add_lines("<div style='display:table;padding-top:0px;padding-bottom:0px;float:center'> </div>")

        for label in theme_dict.keys():
          self.page.add_lines("    <div style='display:inline-block;font-weight:bold;font-size:14px;padding-top:4px;padding-bottom:2px;'>\n")
          self.page.add_lines("      <div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
          self.page.add_lines("      <a href=''>{}</a>\n".format(label))
          self.page.add_lines("    </div>\n")
          self.page.add_lines("<div style='display:table;padding-top:0px;padding-bottom:0px;float:center'> </div>")



    def render_menu_mobile(self, language, link, indent=0):
      content = self.page.repository.get_content(language)

      str_indent1 = ""
      for i in range(0, indent):
        str_indent1 = str_indent1 + "<div class='space'></div>"
      str_indent2 = str_indent1 + "<div class='space'></div>"

      for level in sorted(content.keys()):
        self.page.add_lines("""
          <button class="w3-button w3-block w3-left-align" onclick="myAccFunc('acc""" + level + """')">
            """ + str_indent1 + level + """ <i class="fa fa-caret-down"></i>
          </button>
          <div id='acc""" + level + """' class="w3-hide w3-white w3-card">
        """)

        for theme in sorted(content[level].keys()):
          self.page.add_lines("""
            <a href='""" + link + "&l_id=" + content[level][theme]["name"] + """' class="w3-bar-item w3-button"> """ + str_indent2 + theme + """</a>
          """)

        self.page.add_lines("</div>")
          


