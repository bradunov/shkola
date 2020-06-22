
style = 
       {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["opacity"] = "0.5",
        ["line_width"] = "1"};

text_style = {["font_size"] = "14"}

term = {}
sign = {}
value = {}

number1 = math.random(490) + 510;
number2 = math.random(490) + 510;
multipl = math.random(7) + 2;
devide = math.random(7) + 2;

indm = math.random(2)
inds = math.random(2)

w = 25
ow = 60

mycanvas = function(no)
  lib.start_canvas(350, 280, "center")

    if (indm == 1) then 
	    sign[1] = "*"
        term[1] = number1 
        term[2] = multipl
		value[1] = number1 * multipl		
	    sign[2] = ":"
        term[3] = number2 * devide
        term[4] = devide
		value[2] = number2
	else	
	    sign[1] = ":"
        term[1] = number1 * devide
        term[2] = devide
		value[1] = number1		
	    sign[2] = "*"
        term[3] = number2 
        term[4] = multipl
		value[2] = number2 * multipl
	end	

    if (value[1] < value[2]) then       
	    sign[3] = "+"
	    result = value[1] + value[2]	
	else
        if (inds == 1) then	
	        sign[3] = "+"
	        result = value[1] + value[2]
		else
	        sign[3] = "-"	
	        result = value[1] - value[2]
        end
    end		

    grad = 1
    for i=1,4 do
        lib.add_rectangle ((3*i-2)*w, w, ow, w, style, false, false)
        lib.add_text((3*i-1)*w, 3*w/2, term[i])
        lib.add_straight_path ((3*i-1)*w, 5*w/2, {{grad*w, w}}, style, false, false) 		
        grad = -grad
	end	

    grad = 1
    for i=1,2 do	
        lib.add_text(i*ow+(i^2+i-1)*w, 4*w, sign[i])	
        lib.add_input(i*ow+(i^2+i-2)*w, 2*ow-5, 60, 60, lib.check_number(value[i],40))		
        lib.add_straight_path (i*(ow+2*w), 6*w, {{grad*w, w}}, style, false, false) 
        grad = -grad
	end	

    lib.add_text(2*(ow+w), 8*w, sign[3])
    lib.add_input(2*ow+w, 9*w, 70, 60, lib.check_number(result,50))		

answ1 = lib.check_number(term[1],30) .. " " .. lib.check_string(sign[1],10) .. " " .. lib.check_number(term[2],30) .. " " .. lib.check_string(sign[3],10) .. " " .. lib.check_number(term[3],30) .. " " .. lib.check_string(sign[2],10) .." ".. lib.check_number(term[4],30) 
answ2 = " = " .. lib.check_number(value[1],30) .. " " .. lib.check_string(sign[3],10) .. " " .. lib.check_number(value[2],30) .. " = " .. lib.check_number(result,30)   
 
                 
  lib.end_canvas()
end
   
   



        