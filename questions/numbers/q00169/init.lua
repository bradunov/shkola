
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

mycanvas = function(no)
  lib.start_canvas(500, 100, "center")

hscale = 1.5
vscale = 5

  lib.add_straight_path(15*hscale, 9*vscale, {{270*hscale, 0}}, style, false, true)
  
  lib.add_straight_path(20*hscale, 8*vscale, {{0, 10}}, style, false, true)
lib.add_text(20*hscale, 6*vscale, 0, text_style) 

  lib.add_straight_path(45*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_text(45*hscale, 6*vscale, 10, text_style)

  lib.add_straight_path(70*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_text(70*hscale, 6*vscale, 20, text_style)

  lib.add_straight_path(95*hscale, 8*vscale, {{0, 10}}, style, false, true) 
  lib.add_input(80*hscale, 11*vscale, 50, 33, lib.check_number(30,20))

  lib.add_straight_path(120*hscale, 8*vscale, {{0, 10}}, style, false, true)  
  lib.add_text(120*hscale, 6*vscale, 40, text_style)

  lib.add_straight_path(145*hscale, 8*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(128*hscale, 11*vscale, 50, 33, lib.check_number(50,20))

  lib.add_straight_path(170*hscale, 8*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(155*hscale, 11*vscale, 50, 33, lib.check_number(60,20))

  lib.add_straight_path(195*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_text(195*hscale, 6*vscale, 70, text_style)

  lib.add_straight_path(220*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_input(202*hscale, 11*vscale, 50, 33, lib.check_number(80,20))

  lib.add_straight_path(245*hscale, 8*vscale, {{0, 10}}, style, false, true) 
  lib.add_input(230*hscale, 11*vscale, 50, 33, lib.check_number(90,20))

  lib.add_straight_path(270*hscale, 8*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(258*hscale, 11*vscale, 50, 33, lib.check_number(100,25))
  
  lib.end_canvas()
end
   
   