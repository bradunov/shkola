import math
import numpy
import random
import lupa
import logging
import server.helpers as helpers
#from server.helpers import *


class LibMath(object):
    _rnd_id = 0
    def __init__(self, question):
        self.lua = question.lua
        self.page = question.page
        self.lib_id = question.q_unique_id
        self.page.add_script_lines("""
            <script> 
                var alread_shown_solutions = false;
                var rnd_val_"""+ str(self.lib_id) + """ = {};
                function sendFeedbackToServer_"""+ str(self.lib_id) + """(root, type, q_id, l_id, language, comment) {
                    var xhr = new XMLHttpRequest();
                    var url = '/' + root + '?op=feedback'
                    var feedback = {};
                    feedback['type'] = type;
                    feedback['q_id'] = q_id;
                    feedback['language'] = language;
                    feedback['l_id'] = l_id;
                    feedback['test_id'] = test_id;
                    feedback['test_order'] = test_order;
                    feedback['comment'] = comment;
                    feedback['attempt'] = attempt.toString();
                    feedback['shown_solutions'] = alread_shown_solutions;
                    feedback['rand_val'] = rnd_val_"""+ str(self.lib_id) + """;
                    xhr.open('POST', url);
                    xhr.onreadystatechange = function() {
                        console.log("Received");
                        console.log(xhr);
                        if (xhr.readyState>3 && xhr.status==200) { console.log("Success: ", xhr.responseText); }
                    };
                    xhr.setRequestHeader('Content-Type', 'application/json');
                    console.log("Sending report to " + url + ": " + JSON.stringify(feedback));
                    xhr.send(JSON.stringify(feedback));
                }
            </script>
        """)

    def eq(self, x, y, precision = 0.00001):
        return abs(x-y) < precision

    def gcd(self, x, y):
        return math.gcd(int(x), int(y))

    def _round(self, x):
        return round(float(x))

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
        self.page.add_script_lines("<script> rnd_val_{}['rnd_arr_{}'] = {};</script>".format(
            self.lib_id, self._rnd_id, parray))
        self._rnd_id = self._rnd_id + 1
        return self.lua.table_from(parray)

    def random(self, m=None, n=None):
        if n is None and m is None:
            rnd = random.random()
        elif m is not None and n is None:
            rnd = random.randint(1, m)
        elif m is not None and n is not None:
            rnd = random.randint(m, n)
        else:
            rnd = random.randint(1, n)
        self.page.add_script_lines("<script> rnd_val_{}['rnd_{}'] = {};</script>".format(
            self.lib_id, self._rnd_id, rnd))
        self._rnd_id = self._rnd_id + 1
        return rnd
    

class Library(object):
    object_id = 0
    page = None
    checks = []
    clears = []
    solutions = []
    values = []
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

    
    def __init__(self, question):
        self.page = question.page
        self.object_id = 0
        # If we have more questions on the same page make sure all use pseudo-random thus unique IDs
        self.lib_id = question.q_unique_id
        self.lua = question.lua
        self.math = LibMath(question)
        self.question_url = question.question_url()
        self.clear()

    def get_object_id(self):
        self.object_id = self.object_id+1
        return self.lib_id + "_" + str(self.object_id)

    def clear(self):
        self.checks = []
        self.clears = []
        self.solutions = []
        self.values = []
        

    def modify_input_style(self, width):
        start = self.input_style.find("width:")
        end = self.input_style.find(";", start)
        modified_style = self.input_style[0:start + len("width:")] + str(width) + self.input_style[end - len("px"):]
        return modified_style


    # str_condition: ok == <condition>
    def condition_check_script(self, item_name, str_condition, extra_condition=None):
        if extra_condition is not None:
            extra_condition_str = "is_ok = is_ok && " + extra_condition + ";"
        else:
            extra_condition_str = ""
        script = """
        <script type = "text/javascript">
        already_checked_obj_ok_""" + item_name + """ = false;
        function """ + item_name + """_cond() {
          var ok;
          """ + str_condition + """
          """ + extra_condition_str + """
          if (is_ok) {
            setOK('""" + item_name + """');
            already_checked_obj_ok_""" + item_name + """ = true;
            return true;
          } else {
            setError('""" + item_name + """');
            already_checked_obj_ok_""" + item_name + """ = false;
            return false;
          }
        }
        </script>
        """
        self.page.add_script_lines(script)





    def check_one_option(self, options, correct, vertical=False):
        qid = self.get_object_id()
        n_answer = 'check_radio_answer_{}'.format(qid)
        hspace = "<div style='display:inline-block;padding-left:6px;padding-right:6px;'> </div>"
        line = "<div id={}> ".format(n_answer)
        clear_str = "{"

        is_ok = "is_ok = (document.getElementById('{}_{}').checked);".format(n_answer, correct)
        clear_str = "if (!already_checked_obj_ok_" + n_answer + "){"

        cnt = 0

        # Have to convert to Python array explicitly
        aoptions = list(options.values())

        if vertical:
            #line = line + "<table>\n"
            line = line + "<div style='text-align: left;'>\n"
        else:
            line = line + hspace
        
        for opt in aoptions:
            if vertical:
                #line = line + "<tr><label><td><input type='radio' id='{}_{}' name='{}'/></td> <td style=\"text-align:left\">{}</td></label></tr>".format(n_answer, cnt, n_answer, opt)
                line = line + "<label><div style='display:inline-block; margin-top:6px; width:auto;'>"\
                        "<input style='display:inline-block' type='radio' id='{}_{}' name='{}'/>" \
                        "<div style='display:inline-block; margin-left:6px'>{}"\
                            "</div></div></label><br>".format(
                            n_answer, cnt, n_answer, opt.strip())
            else:
                line = line + "<label><input type='radio' id='{}_{}' name='{}'/> {}</label>".format(n_answer, cnt, n_answer, opt) + hspace
            clear_str = clear_str + "document.getElementById('{}_{}').checked=false;\n".format(n_answer, cnt)
            cnt = cnt + 1

        if vertical:
            # line = line + "</table>\n"
            line = line + "</div>\n"

        line = line + "</div>\n"
        
        self.condition_check_script(n_answer, is_ok)
        
        self.checks.append("{}_cond()".format(n_answer))
        
        self.solutions.append("document.getElementById('{}_{}').checked = true;\n".format(n_answer, correct))

        self.values.append("""
        values = { }
        for (i = 0; i < """ + str(cnt) + """; i++) {
            values[i.toString()] = document.getElementById('""" + str(n_answer) + """_' + i.toString()).checked;\n
        }
        """)
        
        clear_str = clear_str + "clearAllWBorder('{}');".format(n_answer)
        clear_str = clear_str + "}\n"
        self.clears.append(clear_str)
        
        return line

    
        

    # Inputs string/number and check that it matches <condition>
    # <condition> can be of form:
    # - answer > <correct_answer>, or any boolean with answer in it, or
    # - <correct_answer>, in which case the boolean condition is answer == <correct_answer>
    # width: width of the input box in characters
    def _check_value(self, condition, width=None, number=False, solution=None):
        qid = self.get_object_id()

        # We use '' in JS strings so make sure there is no ' character in the condition
        if isinstance(condition, str):
            condition = condition.replace("'", '"')

        n_answer = 'check_number_answer_{}'.format(qid)
        v_answer = "document.getElementById(\'" + n_answer + "\').value"
        s_answer = v_answer
        if number:
            extra_condition = v_answer + ".length > 0"
            v_answer = "Number(" + v_answer + ")"
        else:
            extra_condition = None

        str_solution = ""
        if "answer" not in str(condition):
            if number:
                str_condition = "is_ok = (" + v_answer + " == \'" + str(condition) + "\');"
                str_solution = s_answer + " = \'" + str(condition) + "\';"
            else:
                str_condition = "is_ok = (" + v_answer + ".toLowerCase().trim() == \'" + str(condition) + "\'.toLowerCase().trim());"
                str_solution = s_answer + " = \'" + str(condition) + "\'.toLowerCase().trim();"
        else:
            mod_v_answer = v_answer
            if not number:
                mod_v_answer += ".toLowerCase().trim()"
            str_condition = "is_ok = (" + condition.replace("answer", mod_v_answer) + ");"
            if solution is None:
                logging.error("Free form condition in question {} but no solution given.\n{}".format(
                    self.question_url, helpers.get_stack_trace()
                    ))
            else:
                str_solution = solution.replace("answer", s_answer) + ";"


        self.condition_check_script(n_answer, str_condition, extra_condition)

        if width is not None:
            modified_style = self.modify_input_style(width)
        else:
            modified_style = self.input_style

        line = "<input {}".format(modified_style) + "type='text' id='{}'/>".format(n_answer)

        self.checks.append("{}_cond()".format(n_answer))

        clear_value = "if (!already_checked_obj_ok_" + n_answer + "){"
        clear_value = clear_value + "document.getElementById('{}').value = '';clearAllWBorder('{}');".format(n_answer, n_answer)
        clear_value = clear_value + "}\n"
        self.clears.append(clear_value)
        
        self.solutions.append(str_solution)
        self.values.append("values = document.getElementById('" + n_answer + "').value.toString();\n")

        #self.page.add_lines( line )
        return line

    def check_number(self, condition, width=None, solution=None):
        return self._check_value(condition, width, True, solution)

    def check_string(self, condition, width=None, solution=None):
        return self._check_value(condition, width, False, solution)


    
    # Input fraction as whole + numerator / denominator and verifies whether the answer matches
    # If whole is not given, inputs only numerator and denominator
    def check_fraction_simple(self, numerator, denominator, whole = None, known = None):
        str_condition = "is_ok = (numerator == \'" + str(numerator) + "\' && " 
        str_condition = str_condition + "denominator  == \'" + str(denominator) + "\'"
        if whole is not None:
            str_condition = str_condition + " && whole == \'" + str(whole) + "\'"
        str_condition = str_condition + ")"
        solution = "numerator=" + str(numerator) + "; denominator = " + str(denominator) + ";"
        if whole is not None:
            solution = solution + "whole=" + str(whole) + ";"
        return self.check_fraction_condition(str_condition, whole is not None, known, solution)
    


    
    # Input fraction as whole + numerator / denominator and verifies whether the answer matches
    # - <condition> is a JavaScript condition with variables <numerator>, <denominator> and <whole> in it
    def check_fraction_condition(self, condition, whole=False, known=None, solution=None):
        qid = self.get_object_id()
        n_answer_numerator = 'check_fraction_answer_numerator_{}'.format(qid)
        n_answer_denominator = 'check_fraction_answer_denominator_{}'.format(qid)
        n_answer_whole = 'check_fraction_answer_whole_{}'.format(qid)
        v_answer_numerator = "Number(document.getElementById(\'" + n_answer_numerator + "\').value)"
        s_answer_numerator = "document.getElementById(\'" + n_answer_numerator + "\').value"

        #Default denominator is 0, not 1
        v_answer_denominator = "Number(document.getElementById(\'" + n_answer_denominator + "\').value)"
        v_answer_denominator = "(((" + v_answer_denominator + ") == 0)?1:(" + v_answer_denominator + "))"
        s_answer_denominator = "document.getElementById(\'" + n_answer_denominator + "\').value"
        
        v_answer_whole = "Number(document.getElementById(\'" + n_answer_whole + "\').value)"
        s_answer_whole = "document.getElementById(\'" + n_answer_whole + "\').value"

        n_answer_table = "check_fraction_answer_table_{}".format(qid)

        str_condition = condition
        clear_str = ""



        # We use '' in JS strings so make sure there is no ' character in the condition
        if isinstance(str_condition, str):
            str_condition = str_condition.replace("'", '"')


        if known is not None and "numerator" in known.keys():
            str_condition = str_condition.replace("numerator", known["numerator"])
            input_numerator = known["numerator"]
        else:
            str_condition = str_condition.replace("numerator", v_answer_numerator)
            input_numerator = "<input " + self.input_style + "type='text' size='1' id='" + n_answer_numerator + "' />"
            clear_str = clear_str + "document.getElementById('{}').value = '';".format(n_answer_numerator)
            if solution is None or not "numerator" in solution:
                logging.error("Free form fractional condition in question {} but no solution given.\n{}".format(
                    self.question_url, helpers.get_stack_trace()
                    ))

            
        if known is not None and "denominator" in known.keys():
            str_condition = str_condition.replace("denominator", known["denominator"])
            input_denominator = known["denominator"]
        else:
            str_condition = str_condition.replace("denominator", v_answer_denominator)
            input_denominator = "<input " + self.input_style + " type='text' size='1' id='" + n_answer_denominator + "' />"
            clear_str = clear_str + "document.getElementById('{}').value = '';".format(n_answer_denominator)
            if solution is None or not "denominator" in solution:
                logging.error("Free form fractional condition in question {} but no solution given.\n{}".format(
                    self.question_url, helpers.get_stack_trace()
                    ))


        input_whole = "<input " + self.input_style + " type='text' size='1' id='" + n_answer_whole + "' />"
        input_frac = "\n<table style='display:inline-table;vertical-align:middle' id='{}'>\n<tbody>\n<tr>\n".format(n_answer_table)
        if whole:
            if known is not None and "whole" in known.keys():
                str_condition = str_condition.replace("whole", known["whole"])
                input_frac = input_frac + "<td style=\"text-align:center\" rowspan=\"2\">" + known["whole"] + "</td>\n"
            else:
                str_condition = str_condition.replace("whole", v_answer_whole)
                input_frac = input_frac + "<td rowspan=\"2\">" + input_whole + "</td>\n"
                clear_str = clear_str + "document.getElementById('{}').value = '';".format(n_answer_whole)
                if solution is None or not "whole" in solution:
                    logging.error("Free form fractional condition in question {} but no solution given.\n{}".format(
                        self.question_url, helpers.get_stack_trace()
                        ))


        input_frac = input_frac + "<td style=\"border-bottom:solid 1px;text-align:center\">" + input_numerator + "</td>\n"
        input_frac = input_frac + "</tr>\n<tr>\n<td style=\"text-align:center\">" + input_denominator + "</td>\n</tr>\n</tbody>\n</table>\n"

        self.condition_check_script(n_answer_table, str_condition)
        self.checks.append("{}_cond()".format(n_answer_table))

        clear_str = "if (!already_checked_obj_ok_" + n_answer_table + "){" + clear_str
        clear_str = clear_str + "clearAllNoBorder('{}');".format(n_answer_table)
        clear_str = clear_str + "}\n"

        self.clears.append(clear_str)

        solution_str = ""
        if solution is not None:
            solution_str = solution.replace("numerator", s_answer_numerator)
            solution_str = solution_str.replace("denominator", s_answer_denominator)
            solution_str = solution_str.replace("whole", s_answer_whole)

        self.solutions.append(solution_str)

        values = "values = { 'numerator' : " + str(s_answer_numerator) + \
                 ".toString(), 'denominator' : " + str(s_answer_denominator) + ".toString() };\n"
        if whole:
            values += "values['whole'] = " + str(s_answer_whole) + ".toString();\n"
        self.values.append(values)

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
        solution = "numerator=" + str(numerator) + ";"
        if whole is not None:
            solution = solution + "whole=" + str(whole) + ";"
        return self.check_fraction_condition(str_condition, whole is not None, known, solution)


    # Input denominator of a fraction and display numerator (and whole if given) as given
    def check_fraction_denominator(self, numerator, denominator, whole = None):
        known = {"numerator" : str(numerator)}
        str_condition = "is_ok = (denominator == \'" + str(denominator) + "\'" 
        if whole is not None:
            str_condition = str_condition + " && whole == \'" + str(whole) + "\'"
            known["whole"] = str(whole) 
        str_condition = str_condition + ")"
        solution = "denominator = " + str(denominator) + ";"
        if whole is not None:
            solution = solution + "whole=" + str(whole) + ";"
        return self.check_fraction_condition(str_condition, whole is not None, known, solution)


    



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
                css = css +  "background-color: #f0f0ff;"
            else:
                css = css +  "background-color: #fff0f0;"
        
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

        #logging.debug(line)
        return line




    
    #############################################
    ### Vector graphics/animation

    
    ### Select objects
    
    def select_checks_and_clears(self, object_id, n, check):
        oid = str(object_id)

        code_clear = """
        function sel_obj_""" + oid + """_clear() {
          if (!already_checked_obj_ok_""" + oid + """) {
            for (let i=0; i<""" + str(n) + """; i++) {
                if (check_""" + oid + """[i]) {
                state_""" + oid + """[i] = false;
                sel_obj_""" + oid + """[i].attr({fill: off_color_""" + oid + """[i], stroke: off_line_color_""" + oid + """[i]});
                }
            }
            clearAllNoBorder('sel_canvas_""" + oid + """');
          }
        }
        """
        self.clears.append("sel_obj_{}_clear();".format(oid))
        code = code_clear
        
        if check is not None:

            # Special hack: JS doesn't have a sum function so we hard code it:
            modified_check = check.replace("sum(result)", "(result.reduce((a, b) => a + b, 0))")
        
            code_check = """
                already_checked_obj_ok_""" + oid + """ = false;
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
                        already_checked_obj_ok_""" + oid + """ = true;
                        return true;
                    } else {
                        setError('sel_canvas_""" + oid + """');
                        already_checked_obj_ok_""" + oid + """ = false;
                        return false;
                    }
                }
            """
            self.checks.append("sel_obj_{}_check();".format(oid))
            code = code + code_check


            code_solutions = """
                function sel_obj_""" + oid + """_solution() {
                    alread_shown_solutions = true;
                    var ind = 0;
                    for (let i=0; i<""" + str(n) + """; i++) {
                        if (check_""" + oid + """[i]) {
                            if (solution_""" + oid + """[ind] == 1) {
                                sel_obj_""" + oid + """[i].attr({fill: on_color_""" + oid + """[i], stroke: on_line_color_""" + oid + """[i]});
                                state_""" + oid + """[i] = true;
                            } else {
                                sel_obj_""" + oid + """[i].attr({fill: off_color_""" + oid + """[i], stroke: off_line_color_""" + oid + """[i]});
                                state_""" + oid + """[i] = false;
                            }
                            ind++;
                        }
                    }
                }
            """
            self.solutions.append("sel_obj_{}_solution();".format(oid))
            code = code + code_solutions

            values = """
                {
                    values = { };
                    var ind = 0;
                    for (let i=0; i<""" + str(n) + """; i++) {
                        if (check_""" + oid + """[i]) {
                            values[ind.toString()] = (state_""" + oid + """[i]).toString();
                            ind++;
                        }
                    }
                }
            """
            self.values.append(values)



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

    # - check_code is a JS expression that evaluates to true if the response is correct 
    #              or false if not. The input parameter is result[i] array where index i
    #              maps to the i-th selectable object on the canvas in the order they are created.
    #              Our JS code sets result[i] to 1 if i-th object is selected and 0 if not, and 
    #              evaluate check_code with these values.  
    #              A simple example is: check_code = "result[0] == 1 && result[1] == 0"
    #              See questions/geometry/q00045 for a more elaborate example.
    # - solutions is a JS expression that sets an array solution[i] to a valid solution to the question.
    #              It maps to selectable objects on canvas, in the same way as results above. 
    #              If object i is selected when solution[i] == 1 and deselected when solution[i] == 0.
    #              this implies a correct solution and should satisfy check_code. 
    #              A simple example maching above is: solutions = "solution[0] = 1; solution[1] = 0;"
    #              If solutions == None we try to infer it from check_code by 
    #              replacing "&&" -> ";"" and "==" -> "=" 
    #              But this is not always possible, e.g. in check_code = "sum(results) == 5"
    #              so a valide solutions string has to be entered manually
    def start_canvas(self, width, height, align=None, check_code=None, solutions=None):
        if self.canvas_id is not None:
            self.page.add_lines("Canvas should not have been started...")
            return

        self.canvas_id = str(self.get_object_id())
        self.canvas_align = align
        self.canvas_check_code = check_code
        self.canvas_items = []

        if solutions is None:
            if check_code is None:
                solutions = ""
            else: 
                solutions = check_code
                solutions = solutions.replace("==", "=")
                solutions = solutions.replace("&&", ";")
                solutions = solutions.replace("result", "solution_" + self.canvas_id)
                solutions = solutions + ";  "
        else:
            solutions = solutions.replace("solution", "solution_" + self.canvas_id)



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
            var solution_""" + self.canvas_id + """ = [];
        """
        script = script + solutions + "\n"

        self.page.add_lines(script)



    def _add_draw_object(self, string, style={}, initial_state=None, check=None):
        off_color="#fff"
        on_color="#aff"
        on_line_color = "#000"
        off_line_color = "#000"
        line_width = "2"
        opacity = "1"

        object_id = self.canvas_id

        
        if style is None or (not isinstance(style, dict) and lupa.lua_type(style) != "table"):
            style = {}

        
        if "off_color" in style.keys():
            if off_color != "none":
                off_color = "#" + style["off_color"]
            
        if "on_color" in style.keys():
            if on_color != "none":
                on_color = "#" + style["on_color"]

        if "line_color" in style.keys():
            on_line_color = "#" + style["line_color"]

        if "off_line_color" in style.keys():
            off_line_color = "#" + style["off_line_color"]
        else:
            off_line_color = on_line_color

        if "line_width" in style.keys():
            line_width = style["line_width"]

        if "opacity" in style.keys():
            opacity = style["opacity"]

            
        font_attr = ""
        
        if "font_size" in style.keys():
            font_attr = font_attr + ", \"font-size\": \"{}\"".format(style["font_size"])
        else:
            font_attr = font_attr + ", \"font-size\": \"18\""

        if "font_family" in style.keys():
            font_attr = font_attr + ", \"font-family\": \"{}\"".format(style["font_family"])

            
            
        off_attr_str = ".attr({fill: \"" + off_color + \
                       "\", stroke: \"" + off_line_color + \
                       "\", opacity: \"" + opacity + \
                       "\", \"stroke-width\": " + line_width + font_attr + "});\n"
        on_attr_str = ".attr({fill: \"" + on_color + \
                       "\", stroke: \"" + on_line_color + \
                       "\", opacity: \"" + opacity + \
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
        color_str = "on_color_{}[{}] = \"{}\";\n".format(object_id, len(self.canvas_items), on_color)\
                  + "off_color_{}[{}] = \"{}\";\n".format(object_id, len(self.canvas_items), off_color)\
                  + "on_line_color_{}[{}] = \"{}\";\n".format(object_id, len(self.canvas_items), on_line_color)\
                  + "off_line_color_{}[{}] = \"{}\";\n".format(object_id, len(self.canvas_items), off_line_color)
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


        
        
    def add_image(self, name, x, y, width, height, style={}, initial_state=None, check=None):
        obj_str = "image('{}', {}, {}, {}, {})".format(
            self.page.get_file_url(self.question_url + "/" + name), x, y, width, width)
        self._add_draw_object(obj_str, style, initial_state, check)

        

        
    def add_check_box(self, x, y, width, height, style={}, initial_state=None, check=None):

        if not "off_line_color" in style.keys():
            style["off_line_color"] = "fff"

        obj_str = "path('M {} {} l {} {} l {} {}')".format(x, y + 2*height/3, width/3, height/3, width-(width/3), -height)
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
            style["font_size"] = "18"

        if not "font_family" in style.keys():
            style["font_family"] = "ChalkboardSE-Regular"
            
        obj_str = "text({}, {}, \"{}\")".format(x, y, text)
        self._add_draw_object(obj_str, style, initial_state, check)


        
    def add_input(self, x, y, w, h, text):
        #logging.debug("add_input: {} {} {} {} {}".format(self.canvas_id, x, y, w, h))
        str = "new Infobox(paper_{}, ".format(self.canvas_id)
        str = str + "{" + "x:{},y:{}, width:{}, height:{}".format(x, y, w, h) + "})"
        str = str + ".div.html(\"{}\");\n".format(text)
        self.page.add_lines(str)

        
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
    # - solutions: JScript code to set <solution> string (e.g. "solution[0] = 1;")
    #   <solutions> is an array of size x*y which has 0 if object not checked or 1 if checked.
    # 
    def select_objects(self, x, y, otype, check_code, style = {}, solutions=None):
        width = 300
        height = 300
        ratio = 0.3
        #select = True
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

        #if "select" in style.keys():
        #    select = style["select"]

        if "initial_state" in style.keys():
            initial_state = style["initial_state"]
                        

        # Pass align style to surrounding div

        if "text-align" in style.keys():
            text_align = style["text-align"]
        else:
            text_align = None
            
        self.start_canvas(width, height, text_align, check_code, solutions)


        if otype == "table":
            self.select_add_table(x, y, width, height, ratio, on_color=color, initial_state=initial_state)
        else: # default circle, square, ...
            self.select_add_grid(otype, x, y, width, height, ratio, on_color=color, initial_state=initial_state)

        
        self.end_canvas()

        


    ### Buttons at the bottom of the page

    def add_check_button_code(self):        
        cid = 0
        vid = 0
        cond = "cond = "
        assign = ""

        report = """
            var report = {};
            report['mode'] = mode;
            report['q_id'] = q_id;
            report['l_id'] = l_id;
            report['language'] = language;
            report['test_id'] = test_id;
            report['test_order'] = test_order;
            report['start'] = question_start_time.toString();
            report['now'] = Math.floor(Date.now()/1000).toString();
            report['attempt'] = attempt.toString();
            report['shown_solutions'] = alread_shown_solutions;
            report['detailed'] = {};
            report['values'] = {};
        """
        for c in self.checks:
            assign = assign + "   c" + str(cid) + " = " + c + ";\n" + \
                "   if (operation == 'SUBMIT') {\n" \
                "      c" + str(cid) + " = " + c + ";\n" \
                "      if (c" + str(cid) + ") {q_correct++;} else {q_incorrect++;}\n" \
                "   } else {c" + str(cid) + " = false; q_incorrect++;}\n\n"
            cond = cond + "c" + str(cid) + " && "
            report = report + "report['detailed']['q_res" + str(cid) + "'] = c" + str(cid) + ".toString();\n"
            cid = cid + 1
        cond = cond + "true;"

        for v in self.values:
            report += v
            report += "\n   report['values']['q_val" + str(vid) + "'] = values;\n"
            vid = vid + 1


        check_script = """
        <script>
        question_start_time = Math.floor(Date.now()/1000);
        attempt = 0;
        q_correct = 0;
        q_incorrect = 0;
        function sendResultsToServer(report, type, root) {
            var xhr = new XMLHttpRequest();
            var url = '/' + root + '?op=register';
            report['response_type'] = type;
            xhr.open('POST', url);
            xhr.onreadystatechange = function() {
                console.log("Received");
                console.log(xhr);
                if (xhr.readyState>3 && xhr.status==200) { console.log("Success: ", xhr.responseText); }
            };
            xhr.setRequestHeader('Content-Type', 'application/json');
            console.log("Sending report to " + url + ": " + JSON.stringify(report));
            xhr.send(JSON.stringify(report));

            attempt = attempt + 1;
        }

        // operation == SUBMIT (attempted to answer) | SKIP (skipped question) | SHOWED (asked to see answers)
        // root == URL root to which to post the results
        function checkAll_""" + str(self.lib_id) + """(operation, root, mode, q_id, l_id, language) {
            q_correct=0; q_incorrect=0;
        """ + assign + "\n" \
            + cond + "\n" + """
          if (!(operation === undefined)) {
              """

        check_script = check_script + report
        check_script = check_script + "sendResultsToServer(report, operation, root);"

        check_script = check_script + """
          }
          return cond;
        }

        var checked_all = false;
        function checkAll(operation, root, mode, q_id, l_id, language) {
            checked_all = true;
            return checkAll_""" + str(self.lib_id) + """(operation, root, mode, q_id, l_id, language);
        }
        </script>
        """

        self.page.add_script_lines("\n<!-- START CHECK AND REPORT -->\n")
        self.page.add_script_lines(check_script)
        self.page.add_script_lines("\n<!-- END CHECK AND REPORT -->\n")

        self.checks = []



                

    def add_clear_button_code(self):
        script_clear = """
        <script>
        function clearAll_""" + str(self.lib_id) + """(){
        """ 
        for c in self.clears:
            script_clear = script_clear + c + "\n"        

        script_clear = script_clear + """
        }
        function clearAll(){
            clearAll_""" + str(self.lib_id) + """();
        }
        </script>
        """
        self.page.add_script_lines("\n<!-- CLEAR ALL -->\n")
        self.page.add_script_lines(script_clear)
        self.page.add_script_lines("\n<!-- END CLEAR ALL -->\n")

        self.clears = []





    def add_solution_button_code(self):
        script_solutions = """
        <script>
        function addSolutionAll_""" + str(self.lib_id) + """(){
            alread_shown_solutions = true;
        """ 
        for c in self.solutions:
            script_solutions = script_solutions + c + "\n"        

        script_solutions = script_solutions + """
        }
        function addSolutionAll(){
            addSolutionAll_""" + str(self.lib_id) + """();
        }
        </script>
        """
        self.page.add_script_lines("\n<!-- HINT ALL -->\n")
        self.page.add_script_lines(script_solutions)
        self.page.add_script_lines("\n<!-- END HINT ALL -->\n")

        self.solutions = []





    def add_error_report_button_code(self):
        script_error_report = """
        <script>
        function sendFeedbackToServer(root, type, q_id, l_id, language, comment){
            sendFeedbackToServer_"""+ str(self.lib_id) + """(root, type, q_id, l_id, language, comment);
        }
        </script>
        """
        self.page.add_script_lines("\n<!-- HINT ALL -->\n")
        self.page.add_script_lines(script_error_report)
        self.page.add_script_lines("\n<!-- END HINT ALL -->\n")





        
