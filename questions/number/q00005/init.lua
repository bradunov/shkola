
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


mycanvas = function(no)
  lib.start_canvas(310, 50, "center")

  lib.add_straight_path(20, 10, {{280, 0}}, style, false, true)
  lib.add_straight_path(20, 5, {{0, 10}}, style, false, true)
  lib.add_straight_path(45, 5, {{0, 10}}, style, false, true)
  lib.add_straight_path(70, 5, {{0, 10}}, style, false, true)
  lib.add_straight_path(95, 5, {{0, 10}}, red_line, false, true) 
  lib.add_straight_path(120, 5, {{0, 10}}, style, false, true)  
  lib.add_straight_path(145, 5, {{0, 10}}, style, false, true)  
  lib.add_straight_path(170, 5, {{0, 10}}, style, false, true)  
  lib.add_straight_path(195, 5, {{0, 10}}, style, false, true)
  lib.add_straight_path(220, 5, {{0, 10}}, red_line, false, true)
  lib.add_straight_path(245, 5, {{0, 10}}, style, false, true) 
  lib.add_straight_path(270, 5, {{0, 10}}, style, false, true)  
  
  lib.add_straight_path(95, 15, {{0, 15}}, different_style, false, true)  
  lib.add_straight_path(90, 30, {{5, 10}, {5, -10}}, style, false, true)  

  lib.add_straight_path(220, 15, {{0, 15}}, different_style, false, true)  
  lib.add_straight_path(215, 30, {{5, 10}, {5, -10}}, style, false, true)     
  
  lib.end_canvas()
end
   
        