import markdown


class page(object):
    object_id = 0
    lines = []
    md_lines = []
    head = None
    foot = None

    def __init__(self):
        self.head = "<html>\n" + self.header() + "<body>\n"
        self.foot = "</body>\n</html>\n"
    
    def add_lines(self, lines):
        # For some reason Lua passes None after every call to library
        if lines is not None:
            self.lines.append(lines)

    def add_md_lines(self, lines):
        # For some reason Lua passes None after every call to library
        if lines is not None:
            self.md_lines.append(lines)

    def get_lines(self):
        return self.lines
    
    def get_md_lines(self):
        return self.lines
    
    def clear_lines(self):
        self.lines = []
        self.md_lines = []


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


    # Convert MD lines into regular lines and clear 
    def convert_md_lines(self):
        ret = ""
        for l in self.md_lines:
            ret = ret + str(l)
        html = markdown.markdown(ret)
        self.add_lines(html)
        self.md_lines = []

    def render(self):
        ret = ""
        ret = ret + str(self.head)
        for l in self.lines:
            ret = ret + str(l)
        ret = ret + "\n" + str(self.foot)
        return ret

