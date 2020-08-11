
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};

blue_style = {["off_color"] = "0cf",
               ["on_color"] = "0cf",
               ["line_color"] = "000",
               ["line_width"] = "2"};
			   
red_style = {["off_color"] = "f30",
               ["on_color"] = "f30",
               ["line_color"] = "000",
               ["line_width"] = "2"};			   

mycanvas = function()

  lib.start_canvas(300, 300, "center", results)

  w = 20
  ow = 15

  for i = 1,13 do
    lib.add_line(ow, ow+(i-1)*w, 14*w, 0, style, false, false)
  end

  for i = 1,15 do
    lib.add_line(ow+(i-1)*w, ow, 0, 12*w, style, false, false)
  end
  
  lib.add_rectangle (ow+w, ow+w, 6*w, 2*w, red_style,  false, true)

  lib.add_straight_path (ow+9*w, ow+w, {{2*w,0}, {0,w}, {2*w,0}, {0,2*w}, {-3*w, 0}, {0,-w}, {-w,0}, {0,-2*w}}, blue_style, false, true)   
  lib.add_input(ow+11*w-10, ow+2*w+10, 30, 30, lib.check_number(3,10))
  
  lib.add_straight_path (ow+3*w, ow+8*w, {{2*w,0}, {0,w}, {-w,0}, {0, w}, {w, 0}, {0,w}, {-3*w,0}, {0,-w}, {w,0}, {0,-2*w}}, blue_style, false, true)   
  lib.add_input(ow+3*w-5, ow+9*w+10, 30, 30, lib.check_number(6,10))

  lib.add_straight_path (ow+9*w, ow+6*w, {{2*w,0}, {0,-w}, {w,0}, {0,2*w}, {-w,0}, {0, w}, {-w,0}, {0,-w}, {-w,0}, {0,-w}}, blue_style, false, true)   
  lib.add_input(ow+10*w-5, ow+6*w+5, 30, 30, lib.check_number(7,10)) 

  lib.add_straight_path (ow+2*w, ow+5*w, {{5*w,0}, {0,w}, {-w,0}, {0,w}, {-3*w, 0}, {0,-w}, {-w,0}, {0,-w}}, blue_style, false, true)    
  lib.add_input(ow+3*w-5, ow+5*w+5, 30, 30, lib.check_number(4,10))

  lib.add_straight_path (ow+8*w, ow+9*w, {{4*w,0}, {0,2*w}, {-w,0}, {0,-w}, {-w, 0}, {0,w}, {-2*w,0}, {0,-2*w}}, blue_style, false, true)    
  lib.add_input(ow+9*w-10, ow+9*w+5, 30, 30, lib.check_number(5,10))
 
  lib.end_canvas()
end
 
        
      