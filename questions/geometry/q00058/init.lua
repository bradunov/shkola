
style = 
	{["off_color"] = "fff",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
include("shapes")

ind = math.random(2)

mycanvas = function()
  
scale = 2

  lib.start_canvas(300, 300, "center")

if (ind == 1) then 

  lib.add_straight_path(20, 40, {{20, -20}, {20, 20}, {20, -20}, {20, 20}, {20, -20}, {20, 20}, {20, -20}}, style, false, false)
  lib.add_input(70, 50, 30, 30, lib.check_number(7, 15))
  lib.add_triangle(230, 70, 70, 50, style, false, false)
  lib.add_input(215, 110, 30, 30, lib.check_number(3, 15))
  diamond(lib, 45, 160, scale, style, false, false)
  lib.add_input(70, 220, 30, 30, lib.check_number(8, 15))
  lib.add_straight_path(220, 240, {{-30, -50}, {80, 0}, {-30, 50}}, style, false, false)
  lib.add_input(215, 255, 30, 30, lib.check_number(3, 15))
  
else 

  lib.add_rectangle(40, 30, 90, 40, style, false, false)
  lib.add_input(70, 80, 30, 30, lib.check_number(4, 15))
  lib.add_straight_path(260, 40, {{-70, 30}, {70, 30}}, style, false, false)
  lib.add_input(215, 110, 30, 30, lib.check_number(2, 15))
  lib.add_straight_path(45, 150, {{0, 60}, {100, 0}, {0,-60}, {-80,0}, {0,40}, {60,0}, {0, -20}, {-40,0}}, style, false, false) 
  lib.add_input(70, 220, 30, 30, lib.check_number(8, 15))  
  cross(lib, 190, 230, scale, style, false, false)
  lib.add_input(215, 290, 30, 30, lib.check_number(12, 15))  

end

  lib.end_canvas()
end
    