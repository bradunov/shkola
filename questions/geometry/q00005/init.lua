

style = {["off_color"] = "fff",
        ["on_color"] = "aff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

different_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f9c",
        ["line_color"] = "00f",
        ["line_width"] = "4"};

mycanvas = function(no)
  lib.start_canvas(350, 260, "center", "result[0] == 0 && result[1] == 0 && result[2] == 1 && result[3] == 1")
   
  lib.add_straight_path(30, 80, {{50, 0}, {0, 50}, {80, 0}, {0, 50}, {80, 0}, {0, 50}, {80, 0}, {0, 50}, {40, 0}}, style, false, false)

  lib.add_triangle(125, 92, 40, 70, different_style, false, true)
  lib.add_circle(125, 40, 12, different_style, false, true)

  lib.add_triangle(280, 148, 70, 160, different_style, false, true)
  lib.add_circle(280, 45, 20, different_style, false, true)

  lib.end_canvas()
end


