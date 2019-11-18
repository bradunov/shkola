style = {["off_color"] = "fff",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "2"};

mycanvas = function(no)
  lib.start_canvas(320, 200, "center", "result[0] == 0 && result[1] == 0 && result[2] == 1")
 
  lib.add_straight_path (50, 150, {{60, 0}, {0, 20}, {-60,0}, {0, 10}, {-30, -20}, {30, -20}, {0, 10}}, style, false, true) 
  lib.add_straight_path (150, 50, {{0, 60}, {20, 0}, {0, -60}, {10, 0}, {-20, -30}, {-20, 30}, {10, 0}}, style, false, true)  
  lib.add_straight_path (270, 170, {{-60, 0}, {0, -20}, {60,0}, {0, -10}, {30, 20}, {-30, 20}, {0, -10}}, style, false, true)
  
  lib.end_canvas()
end
