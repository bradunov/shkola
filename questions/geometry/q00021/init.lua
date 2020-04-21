style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};

yelow_style = {["off_color"] = "ff0",
               ["on_color"] = "ff0",
               ["line_color"] = "000",
               ["line_width"] = "2"};

green_style = {["off_color"] = "6f6",
                ["on_color"] = "6f6",
                ["line_color"] = "000",
                ["line_width"] = "2"};

blue_style = {["off_color"] = "0cf",
               ["on_color"] = "0cf",
               ["line_color"] = "000",
               ["line_width"] = "2"};

orange_style = {["off_color"] = "f90",
               ["on_color"] = "f90",
               ["line_color"] = "000",
               ["line_width"] = "2"};
			   
red_style = {["off_color"] = "f30",
               ["on_color"] = "f30",
               ["line_color"] = "000",
               ["line_width"] = "2"};			   
			   
violet_style = {["off_color"] = "f9c",
             ["on_color"] = "f9s",
             ["line_color"] = "000",
             ["line_width"] = "2"};	


mycanvas = function()

  lib.start_canvas(450, 200, "center", results)

  w = 20
  ow = 15

  for i = 1,9 do
    lib.add_line(ow, ow+(i-1)*w, 20*w, 0, style, false, false)
  end

  for i = 1,21 do
    lib.add_line(ow+(i-1)*w, ow, 0, 8*w, style, false, false)
  end
  
  lib.add_straight_path (ow+5*w, ow+4*w, {{w,0}, {0,w}, {w,0}, {0, w}, {-w,0}, {0, w}, {-w,0}, {0,-w}, {-w,0}, {0,-w}, {w,0}, {0,-w}}, violet_style, false, true)   
  lib.add_input(ow+5*w-5, ow+5*w+5, 30, 30, lib.check_number(5,10)) 

  lib.add_straight_path (ow+w, ow+w, {{3*w,0}, {0,w}, {-w,0}, {0, w}, {w, 0}, {0,w}, {-3*w,0}, {0,-w}, {w,0}, {0,-w}, {-w,0}, {0,-w}}, green_style, false, true)   
  lib.add_input(ow+2*w-5, ow+2*w+10, 30, 30, lib.check_number(7,10))

  lib.add_straight_path (ow+7*w, ow+w, {{3*w,0}, {0,w}, {-w,0}, {0,2*w}, {-w, 0}, {0,-2*w}, {-w,0}, {0,-w}}, yelow_style, false, true)   
  lib.add_input(ow+8*w-5, ow+w+5, 30, 30, lib.check_number(5,10))

  lib.add_straight_path (ow+9*w, ow+7*w, {{0,-w}, {w,0}, {0,-w}, {w,0}, {0,-w}, {w, 0}, {0,-w}, {w,0}, {0,w}, {w,0}, {0,w},{w,0}, {0,w}, {w,0}, {0,w}, {-7*w,0} }, orange_style, false, true)    
  lib.add_input(ow+12*w-5, ow+5*w-3, 30, 30, lib.check_number(16,15))

  lib.add_straight_path (ow+15*w, ow+w, {{4*w,0}, {0,4*w}, {-w,0}, {0,-w}, {-w, 0}, {0,-w}, {-w,0}, {0,-w}, {-w,0}, {0,-w},}, blue_style, false, true)    
  lib.add_input(ow+17*w, ow+w+10, 30, 30, lib.check_number(10,15))
 
  lib.end_canvas()
end
                                
 
        
