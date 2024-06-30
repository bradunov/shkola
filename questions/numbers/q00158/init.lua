
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

number1 = math.random(8) + 1;
number2 = math.random(8) + 1;
multipl = math.random(7) + 2;
devide = math.random(7) + 2;

indm = math.random(2)


w = 20
ow = 60
y = ow + w

mycanvas = function(no)
  lib.start_canvas(350, 200, "center")

    if (indm == 1) then 
	    sign[1] = "·"
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
	    sign[2] = "·"
        term[3] = number2 
        term[4] = multipl
		value[2] = number2 * multipl
	end	

    if (value[1] < value[2]) then       
	    sign[3] = "+"
	    result = value[1] + value[2]	
	else
	    sign[3] = "-"
	    result = value[1] - value[2]
    end		

    grad = 1
    for i=1,4 do
	    x = i*3*w
        lib.add_rectangle (x-w-10, w-5, w+15, w, style, false, false)
        lib.add_text(x-15, 2*w-15, term[i])
        lib.add_straight_path (x-w+10, 2*w, {{grad*w, w}}, style, false, false) 		
        grad = -grad
	end	

    grad = 1
    for i=1,2 do
	    x = i*w
        lib.add_text(i*(y+x-w), ow+w-10, sign[i])
        lib.add_input(i*(ow+i*w)-w-5, y, 50, 50, lib.check_number(value[i]))		
        lib.add_straight_path (i*(ow+i*w), 2*ow-10, {{grad*w, w}}, style, false, false) 
        grad = -grad
	end	

    lib.add_text(2*y-w, y+ow, sign[3])
    lib.add_input(2*ow-5, y+ow+15, 50, 50, lib.check_number(result))		

answ = lib.check_number(term[1],25) .. " " .. sign[1] .. " " .. lib.check_number(term[2],20) .. " " .. sign[3] .. " " .. lib.check_number(term[3],25) .. " " .. sign[2] .." ".. lib.check_number(term[4],20) .. " = " .. lib.check_number(value[1],25) .. " " .. sign[3] .. " " .. lib.check_number(value[2],25) .. " = " .. lib.check_number(result,25)   
                  
  lib.end_canvas()
end
   