
include("terms")

blue_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "00f",
        ["line_width"] = "3"};

red_style = 
	{["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "3"};

check_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f9c",
        ["line_color"] = "000",
        ["line_width"] = "2"};

include("shapes")


ind = math.random(6)
position = place[ind]

mycanvas = function()
  
if (ind == 1) then
   results = "result[0] == 1 && result[1] == 0 && result[2] == 1 && result[3] == 0" 
end
if (ind == 2) then
   results = "result[0] == 1 && result[1] == 0 && result[2] == 0 && result[3] == 0" 
end
if (ind == 3) then
   results = "result[0] == 0 && result[1] == 0 && result[2] == 1 && result[3] == 1" 
end
if (ind == 4) then
   results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 1" 
end
if (ind == 5) then
   results = "result[0] == 0 && result[1] == 0 && result[2] == 1 && result[3] == 0" 
end
if (ind == 6) then
   results = "result[0] == 0 && result[1] == 1 && result[2] == 0 && result[3] == 0" 
end

scale = 1.2

  lib.start_canvas(330, 300, "center", results)

  lib.add_ellipse(150, 100, 120, 80, blue_style, false, false) 
  lib.add_circle (210, 180, 100, red_style, false, false) 
  lib.add_triangle(100, 80, 60, 40, check_style, false, true)
  lib.add_rectangle(50, 190, 30, 80, check_style, false, true)
  diamond(lib, 170, 120, scale, check_style, false, true)
  cross(lib, 200, 210, scale, check_style, false, true)
 
  lib.end_canvas()
end
         