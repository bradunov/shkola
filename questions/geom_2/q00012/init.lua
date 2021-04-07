
style = 
	{["off_color"] = "fff",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["line_width"] = "2"};

include("shapes")

ind = math.random(2)


mycanvas = function()
  
if (ind == 1) then
   results = "result[0] == 1 && result[1] == 1 && result[2] == 1 && result[3] == 0 && result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0" 
else
   results = "result[0] == 1 && result[1] == 1 && result[2] == 1 && result[3] == 1 && result[4] == 0 && result[5] == 0 && result[6] == 0" 
end   

scale = 2

  lib.start_canvas(320, 350, "center", results)

  if (ind == 1) then
      lib.add_ellipse(100, 60, 60, 30, style, false, true)  
      lib.add_rectangle(50, 190, 100, 50, style, false, true)	  
      diamond(lib, 140, 140, scale, style, false, true)
      lib.add_triangle(250, 60, 60, 60, style, false, true)	  
      lib.add_straight_path (150, 280, {{-30, 30}, {30, 30},{90, -30},{-90, -30}, }, style, false, true)	
      leaf(lib, 250, 160, scale, style, false, true) 	  
  else
      lib.add_circle(240, 60, 40, style, false, true)
      cross(lib, 50, 170, scale, style, false, true) 
      lib.add_straight_path (300, 150, {{-100, 0}, {-50, 60}, {100, 0},{50,-60 }}, style, false, true)	
      lib.add_rectangle(50, 30, 70, 70, style, false, true)
      lib.add_straight_path (100, 270, {{-50, 50}, {150, 0},{-50, -50},{-50, 0}}, style, false, true)	
      heart(lib, 250, 320, scale, style, false, true)	  
  end
  
  lib.end_canvas()
end  