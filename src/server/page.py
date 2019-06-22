
class page(object):
    object_id = 0
    lines = []
    batch = []
    head = None
    foot = None

    def __init__(self):
        self.head = "<html>\n" + self.header() + "<body>\n"
        self.foot = "</body>\n</html>\n"

    def add_lines(self, lines):
        # For some reason Lua passes None after every call to library
        if lines is not None:
            self.lines.append(lines)

    def add_batch_lines(self, lines):
        # For some reason Lua passes None after every call to library
        if lines is not None:
            self.batch.append(lines)

    def get_lines(self):
        return self.lines
        
    def clear_lines(self):
        self.lines = []
        self.batch = []


    def header(self):
        return """
          <head>
             <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css"> -->
             <script type="text/javascript" async
               src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML" async>
             </script>
             <script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"> </script>
             <!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script> -->
          </head>
        """

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
    def process_batch(self):
        b = ""
        for l in self.batch:
            b = b + str(l)
        
        # Beutify b like markdown, but we cannot use MD here as it would destroyed inlined HTML (e.g. MathJS)
        # b = b.replace("\t", " ")
        # b = b.replace("\n", "@@@")
        # b = " ".join(b.split())
        # b = b.replace("@@@", "\n")
        # b = b.replace("\n ", "\n")
        # b = b.replace("\n\n", "\n")
        # b = b.replace("\n", "<br>\n")
            
        self.add_lines(b)
        self.batch = []

    
    def render(self):
        ret = ""
        ret = ret + str(self.head)
        ret = ret + self.scripts()
        for l in self.lines:
            ret = ret + str(l)
            
        ret = ret + "\n" + str(self.foot)
        return ret

