
orange_style = {["off_color"] = "f90",
                ["on_color"] = "f90",
                ["line_color"] = "f90",
                ["line_width"] = "2"};

green_style = {["off_color"] = "6f6",
               ["on_color"] = "6f6",
               ["line_color"] = "6f6",
               ["line_width"] = "2"};
			    
  number = 10


  ow = 15
  ov = 150
  
 	
mycanvas = function(result)

  lib.start_canvas(200, 220, "center", result)

  lib.add_straight_path(3*ow, 3*ow, {{ov, 0}}, orange_style,  false, false)
  lib.add_straight_path(3*ow, 3*ow, {{0, ov}}, orange_style,  false, false)
  lib.add_straight_path(ov, ov, {{-ov-2*ow, 0}}, green_style,  false, false)
  lib.add_straight_path(ov, ov, {{0, -ov-2*ow}}, green_style,  false, false)

  lib.end_canvas()
end    
    
  
            
    