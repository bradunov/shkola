
class page(object):
    object_id = 0
    lines = []
    on_loaded_script = ""
    title = ""

    def __init__(self, title="Shkola"):
        self.title = title

    def add_lines(self, lines):
        # For some reason Lua passes None after every call to library
        if lines is not None:
            self.lines.append(lines)

    def get_lines(self):
        return self.lines
        
    def clear_lines(self):
        self.lines = []

    def add_on_loaded_script_lines(self, code):
        self.on_loaded_script = self.on_loaded_script + code
        

    def header(self):
        head = "<!DOCTYPE html>"
        head = head + "<html>\n"
        head = head + "  <head>\n"
        head = head + "    <title>{}</title>\n".format(self.title)
        head = head + "    <meta name='viewport' content='width=device-width, initial-scale=1'>\n"
        head = head + """
             <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css"> -->
             <script type="text/javascript" async
               src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML" async>
             </script>
             <script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"> </script>
             <!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script> -->
        """
        if self.on_loaded_script:
            head = head + """
              <script type="text/javascript">
                function page_init() {
                  """ + self.on_loaded_script + """
                }
                window.onload = page_init;
              </script>
            """
            
        head = head + "  </head>\n"
        head = head + "  <body>\n"

        return head
    

    def footer(self):
        return "</body>\n</html>\n"
        

    def scripts(self):
        return """
        <script type = "text/javascript">
        function setError(id) {
          console.log("setError");
          document.getElementById(id).style.border = "3px solid red";
        }
        function clearError(id) {
          console.log("clearError");
          document.getElementById(id).style.border = "1px solid #ccc";
        }
        </script>  
        """    

    
    def render(self):
        ret = ""
        ret = ret + self.header()
        ret = ret + self.scripts()
        for l in self.lines:
            ret = ret + str(l)
            
        ret = ret + "\n" + self.footer()
        return ret

