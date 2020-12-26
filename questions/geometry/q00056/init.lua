include("terms")

line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["off_line_color"] = "000",
        ["line_width"] = "3"}; 

		
include("shapes")

index = math.random(2)

ind = math.random(2)
name = place[ind]

mycanvas = function()

if (index == 1) then  
   if (ind == 1) then
       results = "result[0] == 0 && result[1] == 1 && result[2] == 1 && result[3] == 0" 
   else
       results = "result[0] == 1 && result[1] == 0 && result[2] == 0 && result[3] == 1"
   end
else
   if (ind == 1) then
       results = "result[0] == 1 && result[1] == 0 && result[2] == 0 && result[3] == 1 "
   else
       results = "result[0] == 0 && result[1] == 1 && result[2] == 1 && result[3] == 0 " 
   end   
end

scale = 2

  lib.start_canvas(300, 300, "center", results)

if(index == 1) then

  lib.add_straight_path(20, 40, {{20, -20}, {20, 20}, {20, -20}, {20, 20}, {20, -20}, {20, 20}, {20, -20}}, line_style, false, true)
  lib.add_triangle(230, 70, 70, 50, line_style, false, true)
  diamond(lib, 45, 160, scale, line_style, false, true)
  lib.add_straight_path(220, 240, {{-30, -50}, {80, 0}, {-30, 50}}, line_style, false, true)
  
else 

  lib.add_rectangle(40, 30, 90, 40, line_style, false, true)
  lib.add_straight_path(260, 40, {{-70, 30}, {70, 30}}, line_style, false, true)
  lib.add_straight_path(45, 150, {{0, 60}, {100, 0}, {0,-60}, {-80,0}, {0,40}, {60,0}, {0, -20}, {-40,0}}, line_style, false, true)  
  cross(lib, 190, 230, scale, line_style, false, true)  

end

  lib.end_canvas()
end  
          
                
            