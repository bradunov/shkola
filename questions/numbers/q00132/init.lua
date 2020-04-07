
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};

different_style = 
	{["off_color"] = "fff",
        ["on_color"] = "faf",
        ["line_color"] = "000",
        ["line_width"] = "1"};


red_line = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f00",
        ["line_width"] = "3"};


text_style = {["font_size"] = "14"}

number = {}
value = {""}

add = 1
number[0] = -5
value[0] = tostring( math.floor(number[0]))
for i = 1,10 do
    number[i] = number[i-1] + add
	value[i] = tostring( math.floor(number[i]))
end	

mycanvas = function(no)
  lib.start_canvas(420, 100, "center")

hscale = 1.4
vscale = 5

  lib.add_straight_path(15*hscale, 9*vscale, {{270*hscale, 0}}, style, false, true)
  
  lib.add_straight_path(20*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_input(4*hscale, 3*vscale, 50, 33, lib.check_number(number[0],20))

  lib.add_straight_path(45*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_text(45*hscale, 6*vscale, value[1], text_style)

  lib.add_straight_path(70*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_input(55*hscale, 3*vscale, 50, 33, lib.check_number(number[2],20))

  lib.add_straight_path(95*hscale, 8*vscale, {{0, 10}}, style, false, true) 
  lib.add_input(80*hscale, 3*vscale, 50, 33, lib.check_number(number[3],20))

  lib.add_straight_path(120*hscale, 8*vscale, {{0, 10}}, style, false, true)  
  lib.add_text(120*hscale, 6*vscale, value[4], text_style)

  lib.add_straight_path(145*hscale, 8*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(128*hscale,  3*vscale, 50, 33, lib.check_number(number[5],20))

  lib.add_straight_path(170*hscale, 8*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(155*hscale, 3*vscale, 50, 33, lib.check_number(number[6],20))

  lib.add_straight_path(195*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_text(195*hscale, 6*vscale, value[7], text_style)

  lib.add_straight_path(220*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_text(220*hscale, 6*vscale, value[8], text_style)

  lib.add_straight_path(245*hscale, 8*vscale, {{0, 10}}, style, false, true) 
  lib.add_input(230*hscale, 3*vscale, 50, 33, lib.check_number(number[9],20))

  lib.add_straight_path(270*hscale, 8*vscale, {{0, 10}}, style, false, true)  
  lib.add_text(270*hscale, 6*vscale, value[10], text_style) 
  
  lib.end_canvas()
end
    
   