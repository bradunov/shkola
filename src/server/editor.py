import json
import sys
import cherrypy
import math
import lupa
from lupa import LuaRuntime
from page import page
from question import question

import pprint
pp = pprint.PrettyPrinter(indent=4)



# B: why this doesn't work if we don't put global?
global page


class editor(object):
    page = None
    
    def render(self, text = "", code = ""):
        return """
            <div class="row">
              <div class="column">
                <form method="post" action="generate">
                  <textarea name="code" rows="10" cols="80">
""" + code + """
                  </textarea>
                  <br>
                  <textarea name="text" rows="10" cols="80">
""" + text + """
                  </textarea>
                  <br>
                  <button type="submit">Test</button>
                </form>
              </div>
            </div>
"""


        
    @cherrypy.expose
    def index(self):
        page.clear_lines()
        page.add_lines(self.render())
        return page.render()

    
    @cherrypy.expose
    def generate(self, code = ""):
        page.clear_lines()
        page.add_lines(self.render(code))
        return page.render()



                
if __name__ == '__main__':
    lua = LuaRuntime(unpack_returned_tuples=True)

    page=page()
    #cherrypy.config.update({'server.socket_host': '192.168.137.2', 'server.socket_port': 8080})
    #cherrypy.quickstart(editor())

    q = question(lua)
    q.set_init_code("""
      result = 5
      coef = 2
    """)
    
    q.set_iter_code("""
        iter_text = coef * ITEM
    """)
    
    q.set_text("""
      Test @result@ here and then repeat:
      @repeat(3)@
         iteration @iter_text@ ends
      @end@ 
      final
    """)

    code = q.eval_with_exception(page)

    print(page.render())
    
    #editor = editor()
    #print(editor.generate())
