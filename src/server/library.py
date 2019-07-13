import math
import numpy
import lupa



class LibMath(object):
    lua = None
    def __init__(self, lua):
        self.lua = lua
        
    def eq(self, x, y, precision = 0.00001):
        return abs(x-y) < precision

    def gcd(self, x, y):
        return math.gcd(x, y)

    # Returns indeices in array sorted according to values in array
    def argsort(self, array):
        # Have to convert to Python array explicitly
        parray = list(array.values())
        sarray = numpy.argsort(parray).tolist()
        # Lua arrays start from 1 and python from 0
        return self.lua.table_from([a + 1 for a in sarray])


    
    

class library(object):
    object_id = 0
    page = None
    checks = []
    clears = []
    table_row = 0
    lua = None

    input_style = "style='padding:3px;width:33px;border:1px solid #ccc!important;border-radius:8px'"


    
    def __init__(self, lua, page):
        self.page = page
        self.checks = []
        self.object_id = 0
        self.lua = lua
        self.math = LibMath(lua)
    
    def get_object_id(self):
        self.object_id = self.object_id+1
        return self.object_id

    def clear(self):
        self.checks = []
        self.clears = []
        

        
    # str_condition: ok == <condition>
    def condition_check_script(self, item_name, str_condition):
        script = """
        <script type = "text/javascript">
        function """ + item_name + """_cond() {
          var ok;
          """ + str_condition + """
          if (is_ok) {
            setOK('""" + item_name + """');
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
    def _check_value(self, condition, width=3, number=False):
        qid = self.get_object_id()
        n_answer = 'check_number_answer_{}'.format(qid)
        n_correct = 'check_number_correct_{}'.format(qid)
        v_answer = "document.getElementById(\'" + n_answer + "\').value"
        if number:
            v_answer = "Number(" + v_answer + ")"
        if "answer" not in str(condition):
            str_condition = "is_ok = (" + v_answer + " == \'" + str(condition) + "\');"
        else:
            str_condition = condition.replace("answer", v_answer)


        self.condition_check_script(n_answer, str_condition)

        line = "<input {}".format(self.input_style) + \
	   "type='text' id='{}'/>".format(n_answer)

        self.checks.append("{}_cond()".format(n_answer))
        self.clears.append("document.getElementById('{}').value = '';clearAllWBorder('{}');".format(n_answer, n_answer))
        
        #self.page.add_lines( line )
        return line

    def check_number(self, condition, width=3):
        return self._check_value(condition, width, True)

    def check_string(self, condition, width=3):
        return self._check_value(condition, width, False)


    
    # Input fraction as whole + numerator / denominator and verifies whether the answer matches
    # If whole is not given, inputs only numerator and denominator
    def check_fraction_simple(self, numerator, denominator, whole = None):
        str_condition = "is_ok = (numerator == \'" + str(numerator) + "\' && " 
        str_condition = str_condition + "denominator  == \'" + str(denominator) + "\'"
        if whole is not None:
            str_condition = str_condition + " && whole == \'" + str(whole) + "\'"
        str_condition = str_condition + ")"
        return self.check_fraction_condition(str_condition, whole is not None)
    


    
    # Input fraction as whole + numerator / denominator and verifies whether the answer matches
    # - <condition> is a JavaScript condition with variables <numerator>, <denominator> and <whole> in it
    def check_fraction_condition(self, condition, whole = False):
        qid = self.get_object_id()
        n_answer_numerator = 'check_fraction_answer_numerator_{}'.format(qid)
        n_answer_denominator = 'check_fraction_answer_denominator_{}'.format(qid)
        n_answer_whole = 'check_fraction_answer_whole_{}'.format(qid)
        n_correct = 'check_fraction_correct_{}'.format(qid)
        v_answer_numerator = "Number(document.getElementById(\'" + n_answer_numerator + "\').value)"

        #Default denominator is 0, not 1
        v_answer_denominator = "Number(document.getElementById(\'" + n_answer_denominator + "\').value)"
        v_answer_denominator = "(((" + v_answer_denominator + ") == 0)?1:(" + v_answer_denominator + "))"
        
        v_answer_whole = "Number(document.getElementById(\'" + n_answer_whole + "\').value)"

        n_answer_table = "check_fraction_answer_table_{}".format(qid)

        str_condition = condition.replace("numerator", v_answer_numerator)\
                                 .replace("denominator", v_answer_denominator)\
                                 .replace("whole", v_answer_whole)

        self.condition_check_script(n_answer_table, str_condition)

        
        input_numerator = "<input " + self.input_style + "type='text' size='1' id='" + n_answer_numerator + "' />" 
        input_denominator = "<input " + self.input_style + " type='text' size='1' id='" + n_answer_denominator + "' />"
        input_whole = "<input " + self.input_style + " type='text' size='1' id='" + n_answer_whole + "' />"
        input_frac = "\n<table style='display:inline-table;vertical-align:middle' id='{}'>\n<tbody>\n<tr>\n".format(n_answer_table)
        if whole:
            input_frac = input_frac + "<td rowspan=\"2\">" + input_whole + "</td>\n"
        input_frac = input_frac + "<td style=\"border-bottom:solid 1px\">" + input_numerator + "</td>\n"
        input_frac = input_frac + "</tr>\n<tr>\n<td>" + input_denominator + "</td>\n</tr>\n</tbody>\n</table>\n"

        self.checks.append("{}_cond()".format(n_answer_table))
        self.clears.append("clearAllNoBorder('{}');".format(n_answer_table))
        self.clears.append("document.getElementById('{}').value = '';".format(n_answer_numerator))
        self.clears.append("document.getElementById('{}').value = '';".format(n_answer_denominator))
        if whole:
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
    # - style["text-align"] == "inline": display table as inline
    # - style["text-align"] != "inline": display table as div paragraph with given text-align
    def start_table(self, style = {}):

        css = ""
        for k,v in style.items():
            if (k != "align"):
                css = css + "{}:{};".format(k,v)

        # default border
        if "border" not in style:
            css = css + "border:0px solid #ddd;"

        # Pass align style to surrounding div
        inline = False
        if "text-align" in style.keys():
            if style["text-align"] == "inline":
                inline = True
            else:
                div_ccs = "style='text-align:{}'".format(style["text-align"])
                css = css + "margin:auto;"
        else:
            # default align is center
            div_ccs = "style='text-align:{center}'"
            css = css + "margin:auto;"

        if inline:
            line = "<span>\n<table style='display:inline-table;vertical-align:middle'>\n"
        else:
            line = "<div {}>\n<table style='{}'>\n".format(div_ccs, css)

        self.table_row = 0
        return line

    # End HTML table
    def end_table(self):
        #return "</table>\n</div>\n"
        return "</table>\n</span>\n"

    
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




    ### Code that implements select objects animation

    def select_object_onmouse(self, object_id, n, color):
        oid = str(object_id)
        code = """
  	for (let i=0; i<""" + str(n) + """; i++) {
  	  sel_obj_""" + oid + """[i].mousedown( function() {
	    if (sel_obj_""" + oid + """[i].attrs["fill"] == "#fff")
  	      sel_obj_""" + oid + """[i].attr({fill: "#""" + color + """"});
	    else
  	      sel_obj_""" + oid + """[i].attr({fill: "#fff"});
	  });
        }
        """
        return code


    def select_add_object(self, object_id, otype, x, y, width, height, ratio, \
                          off_color = "fff", on_color = "aff", initial_state = None):
        radiusx = width / (2*x* + 4*ratio)
        radiusy = height / (2*y + 4*ratio)
        r = min(radiusx, radiusy)
        stepx = (width - 2*r*x) / (x+1)
        stepy = (width - 2*r*x) / (x+1)

        if otype == "square":
            obj_str = "sel_obj_{}[{}] = paper_{}.rect({}, {}, {}, {})"
        elif otype == "triangle":
            obj_str = "sel_obj_{}[{}] = paper_{}.path('M {} {} l {} {} l {} {} l {} {}')"
        else:  # Default: otype == "circle":
            obj_str = "sel_obj_{}[{}] = paper_{}.circle({}, {}, {})"
            
        off_attr_str = ".attr({fill: \"#" + off_color + "\", stroke: \"#000\", \"stroke-width\": 2});\n"
        on_attr_str = ".attr({fill: \"#" + on_color + "\", stroke: \"#000\", \"stroke-width\": 2});\n"

        code = ""
        for iy in range(0, y):
            for ix in range(0, x):
                lx = stepx*(ix+1) + r*(2*ix+1)
                ly = stepx*(iy+1) + r*(2*iy+1)

                ind = iy * x + ix
                if initial_state is not None and len(initial_state) > ind and initial_state[ind+1] == 1:
                    attr_str = on_attr_str
                else:
                    attr_str = off_attr_str

                if otype == "square":
                    code = code + obj_str.format(object_id, iy*x+ix, object_id, lx-r, ly-r, 2*r, 2*r) + attr_str
                elif otype == "triangle":
                    code = code + obj_str.format(object_id, iy*x+ix, object_id, lx-r, ly+r, r, -2*r, r, 2*r, -2*r, 0) + attr_str
                else: # Default otype == "circle":
                    code = code + obj_str.format(object_id, iy*x+ix, object_id, lx, ly, r) + attr_str

        return code


    def select_add_table(self, object_id, x, y, width, height, ratio, \
                         off_color = "fff", on_color = "aff", initial_state = None):
        swidth = width / x
        sheight = height / y

        obj_str = "sel_obj_{}[{}] = paper_{}.rect({}, {}, {}, {})"
        off_attr_str = ".attr({fill: \"#" + off_color + "\", stroke: \"#000\", \"stroke-width\": 2});\n"
        on_attr_str = ".attr({fill: \"#" + on_color + "\", stroke: \"#000\", \"stroke-width\": 2});\n"

        code = ""
        for iy in range(0, y):
            for ix in range(0, x):
                lx = swidth * ix
                ly = sheight * iy
                ind = iy * x + ix
                
                if initial_state is not None and len(initial_state) > ind and initial_state[ind+1] == 1:
                    attr_str = on_attr_str
                else:
                    attr_str = off_attr_str
                code = code + obj_str.format(object_id, iy*x+ix, object_id, lx, ly, swidth, sheight) + \
                       attr_str

        return code


    def select_checks_and_clears(self, object_id, n, check):
        oid = str(object_id)

        # Special hack: JS doesn't have a sum function so we hard code it:
        modified_check = check.replace("sum(result)", "(result.reduce((a, b) => a + b, 0))")
        
        code_clear = """
        function sel_obj_""" + oid + """_clear() {
     	  for (let i=0; i<""" + str(n) + """; i++) {
  	    sel_obj_""" + oid + """[i].attr({fill: "#fff"});
          }
          clearAllNoBorder('sel_canvas_""" + oid + """');
        }
        """
        code_check = """
        function sel_obj_""" + oid + """_check() {
          var result = []
     	  for (let i=0; i<""" + str(n) + """; i++) {
            if (sel_obj_""" + oid + """[i].attrs['fill'] == '#fff') {
  	      result[i] = 0;
            } else {
  	      result[i] = 1;
            }
          }
          if (""" + modified_check + """) {
            setOK('sel_canvas_""" + oid + """');
            return true;
          } else {
            setError('sel_canvas_""" + oid + """');
            return false;
          }
        }
        """
        self.checks.append("sel_obj_{}_check();".format(oid))
        self.clears.append("sel_obj_{}_clear();".format(oid))
        return code_clear + code_check;
        


    # Parameters:
    # - x, y: size in number of objects
    # - otype: circles, ...
    # - check_code: JScript code to check <result> string (e.g. "(result[0] == 1)")
    #   <result> is an array of size x*y which has 0 if object not checked or 1 if checked.
    # - style:
    #   - height, width: canvas size
    #   - ratio: spacing_between_object / object_radius
    #   - select: true (default) if the user is expected to enter input by selecting elements)
    #             false if it is used only for visualisation
    def select_objects(self, x, y, otype, check_code, style = {}):
        object_id = str(self.get_object_id())
        width = 300
        height = 300
        ratio = 0.3
        select = True
        color = "aaa"
        initial_state = None

        if "width" in style.keys():
            width = style["width"]
            
        if "height" in style.keys():
            height = style["height"]

        if "ratio" in style.keys():
            ratio = style["ratio"]
            
        if "color" in style.keys():
            color = style["color"]

        if "select" in style.keys():
            select = style["select"]

        if "initial_state" in style.keys():
            initial_state = style["initial_state"]
            
        if otype == "table":
            object_code = self.select_add_table(object_id, x, y, width, height, ratio, on_color=color, initial_state=initial_state)
        else: # default circle, square, ...
            object_code = self.select_add_object(object_id, otype, x, y, width, height, ratio, on_color=color, initial_state=initial_state)
            

        # Pass align style to surrounding div
        inline = False
        if "text-align" in style.keys():
            if style["text-align"] == "inline":
                inline = True
            else:
                div_ccs = "style='text-align:{}'".format(style["text-align"])
        else:
            # default align is center
            div_ccs = "style='text-align:center'"

        if inline:
            script = "<span style='vertical-align:middle;display:inline-block' id = 'sel_canvas_{}'>".format(object_id)
        else:
            script = "<div {} id = 'sel_canvas_{}'>".format(div_ccs,  object_id)
            
        script = script + """
        <script type = "text/javascript">
	var paper_""" + object_id +\
            """ = Raphael("sel_canvas_""" + object_id + """", """ + \
            str(width) + ", " + str(height) + """);
	var sel_obj_""" + object_id + """ = [];
        """ + object_code
        if select:
            script = script + \
                     self.select_checks_and_clears(object_id, x*y, check_code) + \
                     self.select_object_onmouse(object_id, x*y, color)
        script = script + "\n</script>\n"
        if inline:
            script = script + "</span>"
        else:
            script = script + "</div>"
            

        self.page.add_lines(script)

        


    ### Buttons at the bottom of the page

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
        line = line + "' value='Proveri' />\n"
        #print(line)
        self.page.add_lines(line)
        
    def add_clear_button(self):
        line = "\n<input type='button' onclick=\""
        for c in self.clears:
            line = line + c
        line = line + "\" value='Obriši' />\n"
        #print(line)
        self.page.add_lines(line)

    def add_buttons(self):
        self.page.add_lines("\n<div id='question_buttons' style='display:block;text-align:center;'>\n")
        self.add_check_button()
        self.add_clear_button()
        self.page.add_lines("\n</div>\n")




        
