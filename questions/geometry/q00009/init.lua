
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
  lib.start_canvas(300, 300, "center")
  
  lib.add_straight_path(10, 60, {{0, 150}}, style1, true, false)
  lib.add_text(10, 220, "1")
  
  lib.add_straight_path(70, 50, {{70, 0}, {10, -10}, {10, 10}, {100, 0}}, style2, true, false) 
  lib.add_text(170, 65, "2") 
  
  lib.add_ellipse(160, 220, 50, 30, style3, true, false)
  lib.add_text(115, 245, "4")
  
  lib.add_triangle(70, 130, 40, 60, style4, true, false)
  lib.add_text(70, 170, "3")
  
  lib.add_curved_path(250, 90, {{50, 0, 20, 50}, {-50, 0, -10, 50}, {40, 20, 20, 50}}, style5, true, false)
  lib.add_text(270, 230, "5")
  
  lib.end_canvas()
end

type = {"prava", "otvorena izlomljena", "zatvorena izlomljena", "zatvorena kriva","otvorena kriva"}
index = math.random(5)
choice = type[index]

    
    
                  
                
                