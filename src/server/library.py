import math
import numpy
import random
import lupa

class LibMath(object):
    lua = None
    def __init__(self, lua):
        self.lua = lua
        
    def eq(self, x, y, precision = 0.00001):
        return abs(x-y) < precision

    def gcd(self, x, y):
        return math.gcd(x, y)

    # Returns indices in array sorted according to values in array
    def argsort(self, array):
        # Have to convert to Python array explicitly
        parray = list(array.values())
        sarray = numpy.argsort(parray).tolist()
        # Lua arrays start from 1 and python from 0
        return self.lua.table_from([a + 1 for a in sarray])

    # Returns randomly shuffled input array
    def random_shuffle(self, array):
        # Have to convert to Python array explicitly
        parray = list(array.values())
        random.shuffle(parray)
        return self.lua.table_from(parray)

    
    

class library(object):
    object_id = 0
    page = None
    checks = []
    clears = []
    table_row = 0
    lua = None
    lib_id = None

    input_style = "style='padding:3px;width:33px;border:1px solid #ccc!important;border-radius:8px'"

    # Table related
    table_inline = False

    # Canvas relates
    canvas_id = None
    canvas_align = None
    canvas_check_code = None
    canvas_items = []

    
    def __init__(self, lua, page):
        self.page = page
        self.checks = []
        self.clears = []
        self.object_id = 0
        self.lua = lua
        self.math = LibMath(lua)
        # If we have more questions on the same page make sure all use pseudo-random thus unique IDs
        self.lib_id = str(int(random.random() * 1000000000))
    
    def get_object_id(self):
        self.object_id = self.object_id+1
        return self.lib_id + "_" + str(self.object_id)

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

        


    # Inputs string/number and check that it matches <condition>
    # <condition> can be of form:
    # - answer > <correct_answer>, or any boolean with answer in it, or
    # - <correct_answer>, in which case the boolean condition is answer == <correct_answer>
    # width: width of the input box in characters
    def _check_value(self, condition, width=3, number=False):
        qid = self.get_object_id()
        n_answer = 'check_number_answer_{}'.format(qid)
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
    def check_fraction_simple(self, numerator, denominator, whole = None, known = None):
        str_condition = "is_ok = (numerator == \'" + str(numerator) + "\' && " 
        str_condition = str_condition + "denominator  == \'" + str(denominator) + "\'"
        if whole is not None:
            str_condition = str_condition + " && whole == \'" + str(whole) + "\'"
        str_condition = str_condition + ")"
        return self.check_fraction_condition(str_condition, whole is not None, known)
    


    
    # Input fraction as whole + numerator / denominator and verifies whether the answer matches
    # - <condition> is a JavaScript condition with variables <numerator>, <denominator> and <whole> in it
    def check_fraction_condition(self, condition, whole = False, known = None):
        qid = self.get_object_id()
        n_answer_numerator = 'check_fraction_answer_numerator_{}'.format(qid)
        n_answer_denominator = 'check_fraction_answer_denominator_{}'.format(qid)
        n_answer_whole = 'check_fraction_answer_whole_{}'.format(qid)
        v_answer_numerator = "Number(document.getElementById(\'" + n_answer_numerator + "\').value)"

        #Default denominator is 0, not 1
        v_answer_denominator = "Number(document.getElementById(\'" + n_answer_denominator + "\').value)"
        v_answer_denominator = "(((" + v_answer_denominator + ") == 0)?1:(" + v_answer_denominator + "))"
        
        v_answer_whole = "Number(document.getElementById(\'" + n_answer_whole + "\').value)"

        n_answer_table = "check_fraction_answer_table_{}".format(qid)

        str_condition = condition


        if known is not None and "numerator" in known.keys():
            str_condition = str_condition.replace("numerator", known["numerator"])
            input_numerator = known["numerator"]
        else:
            str_condition = str_condition.replace("numerator", v_answer_numerator)
            input_numerator = "<input " + self.input_style + "type='text' size='1' id='" + n_answer_numerator + "' />"
            self.clears.append("document.getElementById('{}').value = '';".format(n_answer_numerator))
            
        if known is not None and "denominator" in known.keys():
            str_condition = str_condition.replace("denominator", known["denominator"])
            input_denominator = known["denominator"]
        else:
            str_condition = str_condition.replace("denominator", v_answer_denominator)
            input_denominator = "<input " + self.input_style + " type='text' size='1' id='" + n_answer_denominator + "' />"
            self.clears.append("document.getElementById('{}').value = '';".format(n_answer_denominator))
            
        input_whole = "<input " + self.input_style + " type='text' size='1' id='" + n_answer_whole + "' />"
        input_frac = "\n<table style='display:inline-table;vertical-align:middle' id='{}'>\n<tbody>\n<tr>\n".format(n_answer_table)
        if whole:
            if known is not None and "whole" in known.keys():
                str_condition = str_condition.replace("whole", known["whole"])
                input_frac = input_frac + "<td style=\"text-align:center\" rowspan=\"2\">" + known["whole"] + "</td>\n"
            else:
                str_condition = str_condition.replace("whole", v_answer_whole)
                input_frac = input_frac + "<td rowspan=\"2\">" + input_whole + "</td>\n"
                self.clears.append("document.getElementById('{}').value = '';".format(n_answer_whole))

        input_frac = input_frac + "<td style=\"border-bottom:solid 1px;text-align:center\">" + input_numerator + "</td>\n"
        input_frac = input_frac + "</tr>\n<tr>\n<td style=\"text-align:center\">" + input_denominator + "</td>\n</tr>\n</tbody>\n</table>\n"

        self.condition_check_script(n_answer_table, str_condition)
        self.checks.append("{}_cond()".format(n_answer_table))
        self.clears.append("clearAllNoBorder('{}');".format(n_answer_table))

        #self.page.add_lines( input_frac )
        return input_frac



    
    # Input numerator of a fraction and display denominator (and whole if given) as given
    def check_fraction_numerator(self, numerator, denominator, whole = None):
        known = {"denominator" : str(denominator)}
        str_condition = "is_ok = (numerator == \'" + str(numerator) + "\'" 
        if whole is not None:
            str_condition = str_condition + " && whole == \'" + str(whole) + "\'"
            known["whole"] = str(whole) 
        str_condition = str_condition + ")"
        return self.check_fraction_condition(str_condition, whole is not None, known)


    # Input denominator of a fraction and display numerator (and whole if given) as given
    def check_fraction_denominator(self, numerator, denominator, whole = None):
        known = {"numerator" : str(numerator)}
        str_condition = "is_ok = (denominator == \'" + str(denominator) + "\'" 
        if whole is not None:
            str_condition = str_condition + " && whole == \'" + str(whole) + "\'"
            known["whole"] = str(whole) 
        str_condition = str_condition + ")"
        return self.check_fraction_condition(str_condition, whole is not None, known)


    



    #######################################
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

        self.table_inline = inline
            
        self.table_row = 0
        return line

    # End HTML table
    def end_table(self):
        if self.table_inline:
            return "</table>\n</span>\n"
        else:
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




    
    #############################################
    ### Vector graphics/animation

    
    ### Select objects
    
    def select_checks_and_clears(self, object_id, n, check):
        oid = str(object_id)

        code_clear = """
        function sel_obj_""" + oid + """_clear() {
     	  for (let i=0; i<""" + str(n) + """; i++) {
            if (check_""" + oid + """[i]) {
              state_""" + oid + """[i] = false;
     	      sel_obj_""" + oid + """[i].attr({fill: off_color_""" + oid + """[i], stroke: off_line_color_""" + oid + """[i]});
            }
          }
          clearAllNoBorder('sel_canvas_""" + oid + """');
        }
        """
        self.clears.append("sel_obj_{}_clear();".format(oid))
        code = code_clear
        
        if check is not None:
            # Special hack: JS doesn't have a sum function so we hard code it:
            modified_check = check.replace("sum(result)", "(result.reduce((a, b) => a + b, 0))")
        
            code_check = """
        function sel_obj_""" + oid + """_check() {
          var result = [];
          var ind = 0;
     	  for (let i=0; i<""" + str(n) + """; i++) {
            if (check_""" + oid + """[i]) {
              if (state_""" + oid + """[i]) {
    	        result[ind] = 1;
              } else {
  	        result[ind] = 0;
              }
              ind++;
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
            code = code + code_check
        
        return code



    def select_object_onmouse(self, object_id, n):
        oid = str(object_id)
        code = """
  	for (let i=0; i<""" + str(n) + """; i++) {
          if (check_""" + oid + """[i]) {
  	    sel_obj_""" + oid + """[i].mousedown( function() {
	      if (state_""" + oid + """[i]) {
  	        sel_obj_""" + oid + """[i].attr({fill: off_color_""" + oid + """[i], stroke: off_line_color_""" + oid + """[i]});
                state_""" + oid + """[i] = false;
	      } else {
  	        sel_obj_""" + oid + """[i].attr({fill: on_color_""" + oid + """[i], stroke: on_line_color_""" + oid + """[i]});
                state_""" + oid + """[i] = true;
              }
	    });
          }
        }
        """
        return code




    ### General drawing

    def start_canvas(self, width, height, align=None, check_code=None):
        if self.canvas_id is not None:
            self.page.add_lines("Canvas should not have been started...")
            return

        self.canvas_id = str(self.get_object_id())
        self.canvas_align = align
        self.canvas_check_code = check_code
        self.canvas_items = []

        
        # Pass align style to surrounding div
        inline = False
        if align is not None:
            if align == "inline":
                inline = True
            else:
                div_ccs = "style='text-align:{}'".format(align)
        else:
            # default align is center
            div_ccs = "style='text-align:center'"

        if inline:
            script = "<span style='vertical-align:middle;display:inline-block' id = 'sel_canvas_{}'>".format(self.canvas_id)
        else:
            script = "<div {} id = 'sel_canvas_{}'>".format(div_ccs,  self.canvas_id)
            
        script = script + """
        <script type = "text/javascript">
	var paper_""" + self.canvas_id +\
            """ = Raphael("sel_canvas_""" + self.canvas_id + """", """ + \
            str(width) + ", " + str(height) + """);
        var on_color_""" + self.canvas_id + """ = [];
        var off_color_""" + self.canvas_id + """ = [];
        var on_line_color_""" + self.canvas_id + """ = [];
        var off_line_color_""" + self.canvas_id + """ = [];
        var check_""" + self.canvas_id + """ = [];
        var state_""" + self.canvas_id + """ = [];
	var sel_obj_""" + self.canvas_id + """ = [];
        """

        self.page.add_lines(script)



    def _add_draw_object(self, string, style={}, initial_state=None, check=None):
        off_color="fff"
        on_color="aff"
        on_line_color = "000"
        off_line_color = "000"
        line_width = "2"

        object_id = self.canvas_id

        
        if style is None or (not isinstance(style, dict) and lupa.lua_type(style) != "table"):
            style = {}

        
        if "off_color" in style.keys():
            off_color = style["off_color"]
            
        if "on_color" in style.keys():
            on_color = style["on_color"]

        if "line_color" in style.keys():
            on_line_color = style["line_color"]

        if "off_line_color" in style.keys():
            off_line_color = style["off_line_color"]
        else:
            off_line_color = on_line_color

        if "line_width" in style.keys():
            line_width = style["line_width"]


        font_attr = ""
        
        if "font_size" in style.keys():
            font_attr = font_attr + ", \"font-size\": \"{}\"".format(style["font_size"])

        if "font_family" in style.keys():
            font_attr = font_attr + ", \"font-family\": \"{}\"".format(style["font_family"])

            
            
        off_attr_str = ".attr({fill: \"#" + off_color + \
                       "\", stroke: \"#" + off_line_color + \
                       "\", \"stroke-width\": " + line_width + font_attr + "});\n"
        on_attr_str = ".attr({fill: \"#" + on_color + \
                       "\", stroke: \"#" + on_line_color + \
                       "\", \"stroke-width\": " + line_width + font_attr + "});\n"

        if check is None:
            check = (self.canvas_check_code is not None and self.canvas_check_code)
            
        if initial_state:
            attr_str = on_attr_str
            state_str = "state_{}[{}] = {};\n".format(object_id, len(self.canvas_items), "true")
        else:
            attr_str = off_attr_str
            state_str = "state_{}[{}] = {};\n".format(object_id, len(self.canvas_items), "false")

        code = "sel_obj_{}[{}] = paper_{}.".format(\
                        object_id, len(self.canvas_items), object_id) + string + attr_str
        color_str = "on_color_{}[{}] = \"#{}\";\n".format(object_id, len(self.canvas_items), on_color)\
                  + "off_color_{}[{}] = \"#{}\";\n".format(object_id, len(self.canvas_items), off_color)\
                  + "on_line_color_{}[{}] = \"#{}\";\n".format(object_id, len(self.canvas_items), on_line_color)\
                  + "off_line_color_{}[{}] = \"#{}\";\n".format(object_id, len(self.canvas_items), off_line_color)
        check_str = "check_{}[{}] = {};\n".format(object_id, len(self.canvas_items), \
                                                  "true" if check else "false")

        self.canvas_items.append(
            {"off_color": off_color,
             "on_color": on_color,
             "on_line_color": on_line_color,
             "off_line_color": off_line_color
            })
        self.page.add_lines(color_str + check_str + state_str + code)

        

    def add_rectangle(self, x, y, width, height, style={}, initial_state=None, check=None):

        obj_str = "rect({}, {}, {}, {})".format(x, y, width, height)
        self._add_draw_object(obj_str, style, initial_state, check)

    

        
    def add_triangle(self, x, y, width, height, style={}, initial_state=None, check=None):

        obj_str = "path('M {} {} l {} {} l {} {} l {} {}')".format(\
                   x-width/2, y+height/2, width/2, -height, width/2, height, -width, 0)
        self._add_draw_object(obj_str, style, initial_state, check)

        
    
        
    def add_circle(self, x, y, radius, style={}, initial_state=None, check=None):

        obj_str = "circle({}, {}, {})".format(x, y, radius)
        self._add_draw_object(obj_str, style, initial_state, check)



        
    def add_ellipse(self, x, y, width, height, style={}, initial_state=None, check=None):

        obj_str = "ellipse({}, {}, {}, {})".format(x, y, width, height)
        self._add_draw_object(obj_str, style, initial_state, check)



        
    def add_line(self, x, y, width, height, style={}, initial_state=None, check=None):

        obj_str = "path('M {} {} l {} {}')".format(x, y, width, height)
        self._add_draw_object(obj_str, style, initial_state, check)



        
    def add_straight_path(self, x, y, path, style={}, initial_state=None, check=None):

        obj_str = "path('M {} {} ".format(x, y)
        for i in range(0, len(path)):
            obj_str = obj_str + "l {} {} ".format(path[i+1][1], path[i+1][2])
        obj_str = obj_str + "')"
        self._add_draw_object(obj_str, style, initial_state, check)
        

        
        
    def add_curved_path(self, x, y, path, style={}, initial_state=None, check=None):

        obj_str = "path('M {} {} ".format(x, y)
        for i in range(0, len(path)):
            obj_str = obj_str + "q {} {} {} {} ".format(path[i+1][1], path[i+1][2], path[i+1][3], path[i+1][4])
        obj_str = obj_str + "')"
        self._add_draw_object(obj_str, style, initial_state, check)
        


        
    def add_check_box(self, x, y, width, height, style={}, initial_state=None, check=None):

        if not "off_line_color" in style.keys():
            style["off_line_color"] = "fff"

        obj_str = "path('M {} {} l {} {} l {} {}')".format(x, y + 2*width/3, width/3, width/3, width-(width/3), -width)
        self._add_draw_object(obj_str, style, initial_state, check)
        

        
                
    def add_text(self, x, y, text, style={}, initial_state=None, check=None):

        if not "off_color" in style.keys():
            style["off_color"] = "000"
            
        if not "on_color" in style.keys():
            style["on_color"] = "000"

        if not "line_color" in style.keys():
            style["line_color"] = "000"

        if not "off_line_color" in style.keys():
            style["off_line_color"] = "000"

        if not "line_width" in style.keys():
            style["line_width"] = "1"

        if not "font_size" in style.keys():
            style["font_size"] = "16"

        if not "font_family" in style.keys():
            style["font_family"] = "Arial, Helvetica, sans-serif"
            
        obj_str = "text({}, {}, \"{}\")".format(x, y, text)
        self._add_draw_object(obj_str, style, initial_state, check)



        
    def end_canvas(self):
        if self.canvas_id is None:
            self.page.add_lines("Canvas should have been started...")
            return

        if self.canvas_check_code is not None and self.canvas_check_code:
            self.page.add_lines(self.select_checks_and_clears(self.canvas_id, len(self.canvas_items), self.canvas_check_code))
            self.page.add_lines(self.select_object_onmouse(self.canvas_id, len(self.canvas_items)))


        script = "\n</script>\n"
        if self.canvas_align == "inline":
            script = script + "</span>"
        else:
            script = script + "</div>"
        self.page.add_lines(script)
        self.canvas_id = None



    
    ### Pie chart
    
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


    
    
    ### Code that implements select objects in grid animation
    
    def select_add_grid(self, otype, x, y, width, height, ratio, \
                          off_color = "fff", on_color = "aff", initial_state = None):
        radiusx = width / (2*x* + 4*ratio)
        radiusy = height / (2*y + 4*ratio)
        r = min(radiusx, radiusy)
        stepx = (width - 2*r*x) / (x+1)

        for iy in range(0, y):
            for ix in range(0, x):
                lx = stepx*(ix+1) + r*(2*ix+1)
                ly = stepx*(iy+1) + r*(2*iy+1)

                ind = iy * x + ix
                if initial_state is not None and len(initial_state) > ind and initial_state[ind+1] == 1:
                    inits = True
                else:
                    inits = False

                style = {"off_color" : off_color, "on_color" : on_color}
                if otype == "square":
                    self.add_rectangle(lx-r, ly-r, 2*r, 2*r, style, inits)
                elif otype == "triangle":
                    self.add_triangle(lx, ly, 2*r, 2*r, style, inits)
                else: # Default otype == "circle":
                    self.add_circle(lx, ly, r, style, inits)



    def select_add_table(self, x, y, width, height, ratio, \
                         off_color = "fff", on_color = "aff", initial_state = None):
        swidth = width / x
        sheight = height / y

        for iy in range(0, y):
            for ix in range(0, x):
                lx = swidth * ix
                ly = sheight * iy
                
                ind = iy * x + ix
                if initial_state is not None and len(initial_state) > ind and initial_state[ind+1] == 1:
                    inits = True
                else:
                    inits = False
                style = {"off_color" : off_color, "on_color" : on_color}
                self.add_rectangle(lx, ly, swidth, sheight, style, inits)


        


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
                        

        # Pass align style to surrounding div

        if "text-align" in style.keys():
            text_align = style["text-align"]
        else:
            text_align = None
            
        self.start_canvas(width, height, text_align, check_code)


        if otype == "table":
            self.select_add_table(x, y, width, height, ratio, on_color=color, initial_state=initial_state)
        else: # default circle, square, ...
            self.select_add_grid(otype, x, y, width, height, ratio, on_color=color, initial_state=initial_state)

        
        self.end_canvas()

        


    ### Buttons at the bottom of the page

    def add_check_button(self, q_id, l_id, user_id, url_next=None):
        
        cid = 0
        cond = "cond = "
        assign = ""
        report = "\"q_id=" + q_id + "&l_id=" + l_id + "&user_id=" + user_id + "&\" + "
        for c in self.checks:
            assign = assign + "c" + str(cid) + " = " + c + "; "
            cond = cond + "c" + str(cid) + " && "
            report = report + "\"q_res" + str(cid) + "=\" + c" + str(cid) + ".toString() + \"&\" + " 
            cid = cid + 1
        cond = cond + "true;"
        report = "report = " + report + \
                 "\"start=\" + question_start_time.toString() + " + \
                 "\"&now=\" + Math.floor(Date.now()/1000).toString();"


        ajax_results_script = """
        <script>
        question_start_time = Math.floor(Date.now()/1000);
        function sendResultsToServer(str, type) {
          var xhr = new XMLHttpRequest();
          xhr.open('POST', '/results/register');
          xhr.onreadystatechange = function() {
            console.log("Received");
            console.log(xhr);
            if (xhr.readyState>3 && xhr.status==200) { console.log("Success: ", xhr.responseText); }
          };
          xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
          xhr.send(str + '&response_type=' + type);
        }
        function checkAll(){
        """ + assign + "\n" \
            + cond + "\n" \
            + report + """
          return [cond, report];
        }
        </script>
        """

        self.page.add_lines("\n<!-- CHECK NEXT BUTTON -->\n")
        self.page.add_lines(ajax_results_script)

        OKline = "\n<input type='button' style='font-size: 14px;' onclick='[cond, report] = checkAll();"
        OKline = OKline + "console.log(report);"
        if url_next is not None:
            # Only send results to server if next_url specified (i.e. we are in the test mode)
            OKline = OKline + "sendResultsToServer(report, \"SUBMIT\");"
            OKline = OKline + "if (cond) {window.location.replace(\"" + url_next + "\")}"
        OKline = OKline + "' value='Proveri' />\n"
        self.page.add_lines(OKline)

        if url_next is not None:
            NEXTline = ""
            NEXTline = "\n<input type='button' style='font-size: 14px;' onclick='[cond, report] = checkAll();"
            NEXTline = NEXTline + report
            NEXTline = NEXTline + "console.log(report);"
            NEXTline = NEXTline + "sendResultsToServer(report, \"SKIP\");"
            NEXTline = NEXTline + "window.location.replace(\"" + url_next + "\");"
            NEXTline = NEXTline + "' value='Preskoci' />\n"
            self.page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
            self.page.add_lines(NEXTline)
            
        self.page.add_lines("\n<!-- END CHECK NEXT BUTTONS -->\n")
            
        self.checks = []
        
    def add_clear_button(self):
        line = "\n<input type='button' style='font-size: 14px;' onclick=\""
        for c in self.clears:
            line = line + c
        line = line + "\" value='Obriši' />\n"
        #print(line)
        self.page.add_lines("\n<!-- CLEAR BUTTON -->\n")
        self.page.add_lines(line)
        self.page.add_lines("\n<!-- END CLEAR BUTTON -->\n")
        self.clears = []

    def add_buttons(self, q_id, l_id, user_id, url_next=None):
        self.page.add_lines("\n<div id='question_buttons' style='display:block;text-align:center;padding-top:20px;padding-bottom:6px'>\n")
        self.add_check_button(q_id, l_id, user_id, url_next)
        self.page.add_lines("<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>")
        self.add_clear_button()
        self.page.add_lines("\n</div>\n")




        
