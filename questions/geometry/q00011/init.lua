
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f00",
        ["off_line_color"] = "000",
        ["line_width"] = "3"};

izbor = math.random(2)


if (izbor == 1) then
   name = name_curved
   result = "result[0] == 0 && result[1] == 1 && result[2] == 1 && result[3] == 0 && result[4] == 0 && result[5] == 1"
else
   name = name_straight
   result = "result[0] == 1 && result[1] == 0 && result[2] == 0 && result[3] == 1 && result[4] == 1 && result[5] == 0"
end   

              
mycanvas = function(result)
  lib.start_canvas(320, 320, "center", result)
  
  lib.add_straight_path(10, 50, {{20, -20}, {20, 20}, {20, -20}, {20, 20}, {20, -20}, {20, 20}, {20, -20}}, style, false, true)
  lib.add_curved_path(160, 60, {{20, -20, 30, 0}, {20, 20, 30, 0}, {20, -20, 30, 0}, {20, 20, 30, 0}, {20, -20, 30, 0}}, style, false, true)

  lib.add_curved_path(10, 150, {{-10, 130, 100, -10}, {60, -100, -60, -10}, {-60, 70, 40, 10}, {70, -60, -30, -10}}, style, false, true)
  lib.add_straight_path(160, 130, {{30, -20}, {60, 0}, {50, 20}}, style, false, true)

  lib.add_straight_path(10, 260, {{25, 30}, {80, 0}}, style, false, true)  
  lib.add_curved_path(160, 260, {{-20, 80, 40, 0}, {80, -130, 40, -10}, {-20, 80, 40, -15}, {80, -130, -100, -30}}, style, false, true)

  lib.end_canvas()
end

