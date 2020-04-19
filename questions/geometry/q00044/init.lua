style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "3"};

transparent_style = 
	{["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "3"};

marker_style = 
	{["off_color"] = "fff",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};

model = {"kvadrat", "krug", "trougao", "pravougaonik"}

mycanvas = function(result)
  lib.start_canvas(300, 300, "center", result)
 
  lib.add_rectangle(30, 30, 70, 70, style, false, false)
  lib.add_input(30, 110, 70, 30, lib.check_string(model[1], 50))
  
  lib.add_circle(70, 210, 40, style, false, false)
  lib.add_input(40, 260, 60, 30, lib.check_string(model[2],40))
  
  lib.add_triangle(210, 60, 80, 60, style, false, false)
  lib.add_input(175, 100, 70, 30, lib.check_string(model[3],50))
  
  lib.add_rectangle(190, 160, 50, 90, style, false, false)
  lib.add_input(165, 260, 100, 30, lib.check_string(model[4],80))  

  lib.end_canvas()
end
                    