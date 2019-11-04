
style = {["off_color"] = "fff",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "2"};

mycanvas = function(no)
  lib.start_canvas(320, 200, "center", "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 1 && result[5] == 1")
 
  lib.add_rectangle(50, 150, 60, 20, style, false, true)
  lib.add_straight_path(25, 160, {{30, 20}, {0, -40}, {-30, 20}}, style, false, true)  

  lib.add_rectangle(150, 50, 20, 60, style, false, true)  
  lib.add_triangle(160, 40, 40, 32, style, false, true)

  lib.add_rectangle(210, 150, 60, 20, style, false, true)
  lib.add_straight_path(270, 180, {{0, -40}, {30, 20}, {-30, 20}}, style, false, true) 
  
  lib.end_canvas()
end

                  

