
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
number = 8
  
  ow = 20
  wy = 120
	
mycanvas = function()

  lib.start_canvas(280, 280, "center")

  lib.add_straight_path(ow, ow+wy, {{2*wy, 0}}, style,  false, false)

  lib.add_straight_path(ow, ow+3*wy/2, {{2*wy, -wy}}, style,  false, false)

  lib.add_straight_path(ow+wy, ow, {{0, 2*wy}}, style,  false, false)

  lib.add_straight_path(ow+wy/2, ow, {{wy, 2*wy}}, style,  false, false)
       
  lib.end_canvas()
end   
 

			    

  