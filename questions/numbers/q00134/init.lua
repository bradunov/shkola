style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};

red_line = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f00",
        ["line_width"] = "1"};


text_style = {["font_size"] = "14"}

tempA = -4
tempB = -1
tempH = 3

tempAmB = tempB - tempA
tempBmH = tempH - tempB
tempAmH = tempH - tempA

tempAr = tempA + 6
tempHf = tempH - 5

mycanvas = function(no)
  lib.start_canvas(450, 80, "center")

hscale = 1.4
vscale = 5

  lib.add_straight_path(15*hscale, 9*vscale, {{270*hscale, 0}}, style, false, true)
  
  lib.add_straight_path(20*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_text(20*hscale, 6*vscale, "-5", text_style)

  lib.add_straight_path(45*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_text(45*hscale, 2*vscale, "A", text_style)
  lib.add_straight_path(45*hscale-2, 7*vscale-4, {{2, 6}, {2,-6}}, red_line, false, true)
  lib.add_straight_path(45*hscale, 4*vscale, {{0, 15}}, red_line, false, true)
  
  lib.add_straight_path(70*hscale, 8*vscale, {{0, 10}}, style, false, true)

  lib.add_straight_path(95*hscale, 8*vscale, {{0, 10}}, style, false, true) 

  lib.add_straight_path(120*hscale, 8*vscale, {{0, 10}}, style, false, true)  
  lib.add_text(120*hscale, 2*vscale, "B", text_style)
  lib.add_straight_path(120*hscale-2, 7*vscale-4, {{2, 6}, {2,-6}}, red_line, false, true)
  lib.add_straight_path(120*hscale, 4*vscale, {{0, 15}}, red_line, false, true)

  lib.add_straight_path(145*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_text(145*hscale, 6*vscale, "0", text_style)
  
  lib.add_straight_path(170*hscale, 8*vscale, {{0, 10}}, style, false, true)  

  lib.add_straight_path(195*hscale, 8*vscale, {{0, 10}}, style, false, true)

  lib.add_straight_path(220*hscale, 8*vscale, {{0, 10}}, style, false, true)
  lib.add_text(220*hscale, 2*vscale, "H", text_style)
  lib.add_straight_path(220*hscale-2, 7*vscale-4, {{2, 6}, {2,-6}}, red_line, false, true)
  lib.add_straight_path(220*hscale, 4*vscale, {{0, 15}}, red_line, false, true)

  lib.add_straight_path(245*hscale, 8*vscale, {{0, 10}}, style, false, true) 

  lib.add_straight_path(270*hscale, 8*vscale, {{0, 10}}, style, false, true)  
  lib.add_text(270*hscale, 6*vscale, "5", text_style) 
  
  lib.end_canvas()
end
            
                  