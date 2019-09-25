
standard_style = 
	{["off_color"] = "fff",
        ["on_color"] = "aff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

different_style = 
	{["off_color"] = "fff",
        ["on_color"] = "faf",
        ["line_color"] = "00f",
        ["line_width"] = "4"};

red_line = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f00",
        ["line_width"] = "1"};


mycanvas = function(no)
  lib.start_canvas(500, 300, "center", "result[0] == 0 && result[1] == 1 && result[2] == 0")
  lib.add_ellipse(250, 150, 230, 140, style, "", false)
  lib.add_rectangle(200, 50, 20, 50, style, true)
  lib.add_triangle(150, 150, 20, 50, different_style)
  lib.add_circle(250, 250, 20)
  lib.add_straight_path(320, 100, {{50, 0}, {0, 50}}, red_line, "", false)
  lib.add_curved_path(320, 100, {{50, 0, 50, 50}}, style, "", false)
  lib.end_canvas()
end

