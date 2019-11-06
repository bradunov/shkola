style1 = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f90",
        ["line_width"] = "3"};

style2 = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "c90",
        ["line_width"] = "3"};

style3 = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "6f6",
        ["line_width"] = "3"};

style4 = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "0cf",
        ["line_width"] = "3"};

style5 = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "3"};

mycanvas = function(no)
  lib.start_canvas(500, 250, "center")
  lib.add_straight_path(50, 40, {{0, 150}}, style1, true, false)
  lib.add_text(50, 200, "1")
  lib.add_straight_path(150, 50, {{70, 0}, {10, -10}, {10, 10}, {100, 0}}, style2, true, false) 
  lib.add_text(250, 65, "2") 
  lib.add_ellipse(250, 200, 50, 30, style3, true, false)
  lib.add_circle(290, 160, 20, style3, true, false)
  lib.add_text(200, 225, "4")
  lib.add_triangle(140, 130, 40, 60, style4, true, false)
lib.add_text(140, 170, "3")
  lib.add_curved_path(380, 80, {{50, 0, 20, 50}, {-50, 0, -10, 50}, {40, 20, 20, 50}}, style5, true, false)
  lib.add_text(400, 220, "5")
  lib.end_canvas()
end

ime = {"prava", "otvorena izlomljena", "zatvorena izlomljena", "zatvorena kriva","otvorena kriva"}
index = math.random(5)
izbor = ime[index]

                  
                