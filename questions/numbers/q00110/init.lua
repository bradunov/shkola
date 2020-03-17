
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

  lib.add_straight_path(15*hscale, 9*vscale, {{280*hscale, 0}}, style, false, true)
  
  lib.add_straight_path(20*hscale, 8*vscale, {{0, 10}}, style, false, true)
lib.add_text(20*hscale, 6*vscale, 10000, text_style) 

  lib.add_straight_path(45*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_input(30*hscale, 11*vscale, 50, 33, lib.check_number(9000,30))

  lib.add_straight_path(70*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_text(70*hscale, 6*vscale, 8000, text_style)

  lib.add_straight_path(95*hscale, 8*vscale, {{0, 10}}, style, false, true) 
  lib.add_input(75*hscale, 11*vscale, 50, 33, lib.check_number(7000,30))

  lib.add_straight_path(120*hscale, 8*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(105*hscale, 11*vscale, 50, 33, lib.check_number(6000,30))

  lib.add_straight_path(145*hscale, 8*vscale, {{0, 10}}, style, false, true)  
  lib.add_text(145*hscale, 6*vscale, 5000, text_style)

  lib.add_straight_path(170*hscale, 8*vscale, {{0, 10}}, style, false, true)  
  lib.add_input(150*hscale, 11*vscale, 50, 33, lib.check_number(4000,30))

  lib.add_straight_path(195*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_input(178*hscale, 11*vscale, 50, 33, lib.check_number(3000,30))

  lib.add_straight_path(220*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_input(205*hscale, 11*vscale, 50, 33, lib.check_number(2000,30))

  lib.add_straight_path(245*hscale, 8*vscale, {{0, 10}}, style, false, true) 
  lib.add_text(245*hscale, 6*vscale, 1000, text_style)
  
  lib.add_straight_path(270*hscale, 8*vscale, {{0, 10}}, style, false, true)  
  lib.add_text(270*hscale, 6*vscale, 0, text_style)
 
  lib.end_canvas()
end
            