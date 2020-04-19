style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "00f",
        ["line_width"] = "3"};
inter_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["line_width"] = "2"};

out_style = 
	{["off_color"] = "fff",
        ["on_color"] = "0cf",
        ["line_color"] = "000",
        ["line_width"] = "2"};

include("shapes")

place = {"unutar", "van"}
ind = math.random(2)
position = place[ind]

mycanvas = function()
  
if (ind == 1) then
   results = "result[0] == 1 && result[1] == 0 && result[2] == 1 && result[3] == 0" 
else
   results = "result[0] == 0 && result[1] == 1 && result[2] == 0 && result[3] == 1" 
end   

scale = 1

  lib.start_canvas(350, 250, "center", results)

  lib.add_ellipse(150, 100, 120, 80, style, false, false)  
  lib.add_triangle(180, 80, 70, 50, inter_style, false, true)
  lib.add_rectangle(60, 190, 80, 30, out_style, false, true)
  diamond(lib, 90, 120, scale, inter_style, false, true)
  cross(lib, 250, 170, scale, out_style, false, true)
 
  lib.end_canvas()
end
   