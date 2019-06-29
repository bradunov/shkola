import math

class library(object):
    object_id = 0
    page = None
    checks = []
    clears = []
    table_row = 0

    input_style = "style='padding:3px;width:33px;border:1px solid #ccc!important;border-radius:8px'"


    
    def __init__(self, page):
        self.page = page
        self.checks = []
    
    def get_object_id(self):
        self.object_id = self.object_id+1
        return self.object_id

    def clear(self):
        self.checks = []
        self.clears = []

    def condition_check_script(self, item_name, str_condition):
        script = """
        <script type = "text/javascript">
        function """ + item_name + """_cond() {
          if (""" + str_condition + """) {
            clearError('""" + item_name + """');
            return true;
          } else {
            setError('""" + item_name + """');
            return false;
          }
        }
        </script>
        """
        self.page.add_lines(script)

        
    def fraction_circle(self, sizes):
        object_id = str(self.get_object_id())
        size = 105
        r = 50
        xc = (size - 2 * r) / 2 + r
        line = "<div id=\"circle_" + object_id + "\"></div>\n"
        line = line + "<script>\n"
        line = line + "var paper_" + object_id + " = Raphael(\"circle_" + object_id + "\", " + str(size) + "," + str(size) + ");\n"
        line = line + "var dot_" + object_id + " = paper_" + object_id + ".circle(" + str(xc) + ", " + str(xc) + ", " + str(r) + ").attr({fill: \"#fff\", stroke: \"#000\", \"stroke-width\": 2});\n"
        a = 2 * math.pi / sizes
        for i in range(sizes):
            x = str(xc + math.sin(i*a) * r)
            y = str(xc + math.cos(i*a) * r)
            line = line + "var line_" + object_id + "_" + str(i) + " = paper_" + object_id + ".path( [\"M\", " + str(xc) + ", " + str(xc) + \
                   " , \"L\", " + x + ", " + y + " ] ).attr({\"stroke-width\": 2});\n"
        line = line + "</script>\n"

        #self.page.add_lines( line )
        return line


    # Inputs string/number and check that it matches <condition>
    # <condition> can be of form:
    # - answer > <correct_answer>, or any boolean with answer in it, or
    # - <correct_answer>, in which case the boolean condition is answer == <correct_answer>
    # width: width of the input box in characters
    def check_value(self, condition, width=3):
        qid = self.get_object_id()
        n_answer = 'check_number_answer_{}'.format(qid)
        n_correct = 'check_number_correct_{}'.format(qid)
        v_answer = "document.getElementById(\'" + n_answer + "\').value"
        if "answer" not in str(condition):
            str_condition = v_answer + " == \'" + str(condition) + "\'"
        else:
            str_condition = condition.replace("answer", v_answer)


        self.condition_check_script(n_answer, str_condition)

        line = "<input {}".format(self.input_style) + \
	   "type='text' id='{}'/>".format(n_answer)

        self.checks.append("{}_cond()".format(n_answer))
        self.clears.append("document.getElementById('{}').value = '';".format(n_answer))
        
        #self.page.add_lines( line )
        return line


    # Input fraction as whole + numerator / denominator and verifies whether the answer matches
    def check_fraction(self, numerator, denominator, whole = None):
        qid = self.get_object_id()
        n_answer_numerator = 'check_fraction_answer_numerator_{}'.format(qid)
        n_answer_denominator = 'check_fraction_answer_denominator_{}'.format(qid)
        n_answer_whole = 'check_fraction_answer_whole_{}'.format(qid)
        n_correct = 'check_fraction_correct_{}'.format(qid)
        v_answer_numerator = "document.getElementById(\'" + n_answer_numerator + "\').value"
        v_answer_denominator = "document.getElementById(\'" + n_answer_denominator + "\').value"
        v_answer_whole = "document.getElementById(\'" + n_answer_whole + "\').value"

        n_answer_table = "check_fraction_answer_table_{}".format(qid)

        str_condition = "(" + v_answer_numerator + " == \'" + str(numerator) + "\' && " 
        str_condition = str_condition + v_answer_denominator + " == \'" + str(denominator) + "\'"


        if whole is not None:
            str_condition = str_condition + " && " + v_answer_whole + " == \'" + str(whole) + "\'"
        str_condition = str_condition + ")"

        self.condition_check_script(n_answer_table, str_condition)

        
        input_numerator = "<input " + self.input_style + "type='text' size='1' id='" + n_answer_numerator + "' />" 
        input_denominator = "<input " + self.input_style + " type='text' size='1' id='" + n_answer_denominator + "' />"
        input_whole = "<input " + self.input_style + " type='text' size='1' id='" + n_answer_whole + "' />"
        input_frac = "\n<table style='display:inline-table;vertical-align:middle' id='{}'>\n<tbody>\n<tr>\n".format(n_answer_table)
        if whole is not None:
            input_frac = input_frac + "<td rowspan=\"2\">" + input_whole + "</td>\n"
        input_frac = input_frac + "<td style=\"border-bottom:solid 1px\">" + input_numerator + "</td>\n"
        input_frac = input_frac + "</tr>\n<tr>\n<td>" + input_denominator + "</td>\n</tr>\n</tbody>\n</table>\n"

        # button = "\n<input type=\"button\" onclick=\"document.getElementById(\'" + n_correct + \
        #     "\').innerHTML = ((" + str_condition + ")?\'OK\':\'NOT OK\')\" value=\"Proveri\" />" + \
        #     "\n<p id=\"" + n_correct + "\"></p>\n"
        # line = input_frac + button
        

        self.checks.append("{}_cond()".format(n_answer_table))
        self.clears.append("document.getElementById('{}').value = '';".format(n_answer_numerator))
        self.clears.append("document.getElementById('{}').value = '';".format(n_answer_denominator))
        if whole is not None:
            self.clears.append("document.getElementById('{}').value = '';".format(n_answer_whole))

        #self.page.add_lines( input_frac )
        return input_frac




    
    #############
    # Table
    #
    # Style parameter: We use Lua/Python table/dict to pass keyword arguments to the table.
    # They can be passed to any element of the table: a cell, a row or a table itself.
    # There are custom parameters (such as row_span and column_span) which are implemented in the code,
    # and generic CSS parameters which are just passed as CSS to table elements. 
            
    
    # Start HTML table with <width> columns
    def start_table(self, style = {}):

        css = ""
        for k,v in style.items():
            if (k != "align"):
                css = css + "{}:{};".format(k,v)

        # default border
        if "border" not in style:
            css = css + "border:0px solid #ddd;"

        # Pass align style to surrounding div
        if "text-align" in style.keys():
            div_ccs = "style='text-align:{}'".format(style["text-align"])
            css = css + "margin:auto;"
        else:
            div_ccs = ""
            
        line = "<div {}>\n<table style='{}'>\n".format(div_ccs, css)

        self.table_row = 0
        return line

    # End HTML table
    def end_table(self):
        return "</table>\n</div>\n"

    
    def start_row(self, style = {}):

        css = "".join("{}:{};".format(k,v) for k,v in style.items())

        # default background color
        if "background-color" not in style:
            if self.table_row % 2 == 0:
                css = css +  "background-color: #f0f0ff;padding: 8px;"
            else:
                css = css +  "background-color: #fff0f0;padding: 8px;"
        
        return "  <tr style='{}'>\n".format(css) 
        
    def end_row(self):
        self.table_row = self.table_row + 1
        return( "  </tr>\n" )

    
    def add_cell(self, content, style = {}):
        css = ""
        for k,v in style.items():
            if (k != "rowspan" and k!= "colspan"):
                css = css + "{}:{};".format(k,v)

        td_arg = ""
        if "rowspan" in style and style["rowspan"] > 1:
            td_arg = td_arg + " rowspan=\"{}\"".format(style["rowspan"])
        if "colspan" in style and style["colspan"] > 1:
            td_arg = td_arg + " colspan=\"{}\"".format(style["colspan"])


            
        #default padding
        if "padding" not in style:
            css = css + "padding: 8px;"

        line = "<td {} style='{}'>".format(td_arg, css)
        line = line + str(content)
        line = line + "    </td>\n"

        #print(line)
        return line


    def add_check_button(self):
        line = "\n<input type='button' onclick='"
        cid = 0
        cond = "cond = "
        for c in self.checks:
            line = line + "c" + str(cid) + " = " + c + "; "
            cond = cond + "c" + str(cid) + " && "
            cid = cid + 1
        cond = cond + "true;"
        line = line + cond
        line = line + "if (cond) alert(\"All OK\")' value='Check' />\n"
        #print(line)
        self.page.add_lines(line)
        
    def add_clear_button(self):
        line = "\n<input type='button' onclick=\""
        for c in self.clears:
            line = line + c
        line = line + "\" value='Clear' />\n"
        #print(line)
        self.page.add_lines(line)

    def add_buttons(self):
        self.page.add_lines("\n<div id='question_buttons' style='display:block;text-align:center;'>\n")
        self.add_check_button()
        self.add_clear_button()
        self.page.add_lines("\n</div>\n")




    ### Code that implements select objects animation

    def select_object_onmouse(self, object_id, n, color):
        oid = str(object_id)
        code = """
  	for (let i=0; i<""" + str(n) + """; i++) {
  	  sel_obj_""" + oid + """[i].mousedown( function() {
	    console.log(sel_obj_""" + oid + """[i].attrs["fill"]);
	    if (sel_obj_""" + oid + """[i].attrs["fill"] == "#fff")
  	      sel_obj_""" + oid + """[i].attr({fill: "#""" + color + """"});
	    else
  	      sel_obj_""" + oid + """[i].attr({fill: "#fff"});
	  });
        }
        """
        return code


    def select_add_circles(self, object_id, x, y, width, height, ratio):
        radiusx = width / (2*x* + 4*ratio)
        radiusy = height / (2*y + 4*ratio)
        r = min(radiusx, radiusy)
        stepx = (width - 2*r*x) / (x+1)
        stepy = (width - 2*r*x) / (x+1)

        obj_str = "sel_obj_{}[{}] = paper_{}.circle({}, {}, {})"
        attr_str = ".attr({fill: \"#fff\", stroke: \"#000\", \"stroke-width\": 2});\n"

        code = ""
        for iy in range(0, y):
            for ix in range(0, x):
                lx = stepx*(ix+1) + r*(2*ix+1)
                ly = stepx*(iy+1) + r*(2*iy+1)
                code = code + obj_str.format(object_id, iy*x+ix, object_id, lx, ly, r) + attr_str

        return code

        


    # style:
    # - height, width: canvas size
    # - ratio: spacing_between_object / object_radius
    def select_objects(self, x, y, otype, style = {}):
        object_id = str(self.get_object_id())
        width = 300
        height = 300
        ratio = 0.3
        color = "aaa"

        if "width" in style.keys():
            width = style["width"]
            
        if "height" in style.keys():
            height = style["height"]

        if "ratio" in style.keys():
            ratio = style["ratio"]
            
        if "color" in style.keys():
            color = style["color"]
            
        script = """
        <div id = "sel_canvas_""" + object_id + """">
        <script type = "text/javascript">
	var paper_""" + object_id +\
            """ = Raphael("sel_canvas_""" + object_id + """", """ + \
            str(width) + ", " + str(height) + """);
	var sel_obj_""" + object_id + """ = [];
        """ + self.select_add_circles(object_id, x, y, width, height, ratio) + \
            self.select_object_onmouse(object_id, x*y, color) + """
        </script>
        </div>
        """

        self.page.add_lines(script)

        
