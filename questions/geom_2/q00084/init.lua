
style = 
	{["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.1"};

blue_style = {["off_color"] = "fff",
               ["on_color"] = "0cf",
               ["line_color"] = "000",
               ["line_width"] = "3"};
			   
red_style = {["off_color"] = "f30",
               ["on_color"] = "f30",
               ["line_color"] = "000",
               ["line_width"] = "3"};			   

ind = math.random(3)

if (ind == 1) then
results = "result[0] == 1 && result[1] == 0 && result[2] == 1 && result[3] == 0 && result[4] == 1 && result[5] == 1"
end

if (ind == 2) then
results = "result[0] == 0 && result[1] == 1 && result[2] == 1 && result[3] == 1 && result[4] == 0 && result[5] == 1"
end

if (ind == 3) then
results = "result[0] == 0 && result[1] == 1 && result[2] == 0 && result[3] == 1 && result[4] == 1 && result[5] == 1 && result[6] == 1 "
end

mycanvas = function()

  lib.start_canvas(300, 350, "center", results)

  w = 20
  ow = 15

  lib.add_rectangle (ow+w, ow+w, 6*w, 4*w, red_style,  false, false)

if (ind == 1) then
  lib.add_straight_path (ow+9*w, ow+w, {{4*w,0}, {0,4*w}, {-w,0}, {0,-w}, {-w, 0}, {0,-w}, {-w,0}, {0,-w}, {-w,0}, {0,-w}}, blue_style, false, true)    
  lib.add_straight_path (ow+3*w, ow+7*w, {{w,0}, {0,w}, {w,0}, {0, 2*w}, {-3*w,0}, {0,-w}, {w,0}, {0,-2*w}}, blue_style, false, true)   
  lib.add_straight_path (ow+9*w, ow+6*w, {{2*w,0}, {0,w}, {-2*w,0}, {0,-w}}, blue_style, false, true)  
  lib.add_straight_path (ow+9*w, ow+9*w, {{4*w,0}, {0,2*w}, {-w,0}, {0,-w}, {-w, 0}, {0,w}, {-2*w,0}, {0,-2*w}}, blue_style, false, true)    
  lib.add_straight_path (ow+2*w, ow+15*w, {{0,-w}, {w,0}, {0,-w}, {w, 0}, {0,-w}, {w,0}, {0,w}, {w,0}, {0,w}, {w,0}, {0,w}, {-5*w,0}  }, blue_style, false, true)  
  lib.add_straight_path (ow+10*w, ow+13*w, {{2*w,0}, {0,w}, {-w,0}, {0,w}, {-w, 0}, {0,-2*w}}, blue_style, false, true)      
end 

if (ind == 2) then
  lib.add_straight_path (ow+9*w, ow+w, {{2*w,0}, {0,w}, {2*w,0}, {0,2*w}, {-3*w, 0}, {0,-w}, {-w,0}, {0,-2*w}}, blue_style, false, true)    
  lib.add_straight_path (ow+3*w, ow+7*w, {{w,0}, {0,w}, {w,0}, {0, 2*w}, {-3*w,0}, {0,-w}, {w,0}, {0,-2*w}}, blue_style, false, true)   
  lib.add_straight_path (ow+9*w, ow+6*w, {{2*w,0}, {0,-w}, {w,0}, {0,2*w}, {-w,0}, {0, w}, {-w,0}, {0,-w}, {-w,0}, {0,-w}}, blue_style, false, true)   
  lib.add_straight_path (ow+9*w, ow+9*w, {{4*w,0}, {0,2*w}, {-w,0}, {0,-w}, {-w, 0}, {0,w}, {-2*w,0}, {0,-2*w}}, blue_style, false, true)    
  lib.add_straight_path (ow+2*w, ow+12*w, {{2*w,0}, {0,w}, {w,0}, {0,w}, {2*w, 0}, {0,w}, {-5*w,0}, {0,-3*w}}, blue_style, false, true)  
  lib.add_straight_path (ow+9*w, ow+13*w, {{4*w,0}, {0,w}, {-w,0}, {0,w}, {-2*w, 0}, {0,-w}, {-w,0}, {0,-w}}, blue_style, false, true)      
end 

if (ind == 3) then
  lib.add_straight_path (ow+9*w, ow+w, {{4*w,0}, {0,4*w}, {-w,0}, {0,-w}, {-w, 0}, {0,-w}, {-w,0}, {0,-w}, {-w,0}, {0,-w}}, blue_style, false, true)    
  lib.add_straight_path (ow+11*w, ow+7*w, {{2*w,0}, {0,3*w}, {-2*w,0}, {0, -3*w}}, blue_style, false, true)   
  lib.add_straight_path (ow+2*w, ow+7*w, {{w,0}, {0,5*w}, {-w,0}, {0, -5*w}}, blue_style, false, true)     
  lib.add_straight_path (ow+6*w, ow+7*w, {{2*w,0}, {0,2*w}, {-2*w,0}, {0,-2*w}}, blue_style, false, true)  
  lib.add_straight_path (ow+10*w, ow+13*w, {{3*w,0}, {0,w}, {-w,0}, {0,w}, {-2*w,0}, {0,-2*w}}, blue_style, false, true)    
  lib.add_straight_path (ow+2*w, ow+15*w, {{0,-w}, {2*w,0}, {0,-w}, {w, 0}, {0,w}, {2*w,0}, {0,w}, {-5*w,0}  }, blue_style, false, true)  
  lib.add_straight_path (ow+7*w, ow+11*w, {{2*w,0}, {0,w}, {-w,0}, {0,w}, {-w, 0}, {0,-2*w}}, blue_style, false, true)      
end 

  for i = 1,17 do
    lib.add_line(ow, ow+(i-1)*w, 14*w, 0, style, false, false)
  end

  for i = 1,15 do
    lib.add_line(ow+(i-1)*w, ow, 0, 16*w, style, false, false)
  end
   
  lib.end_canvas()
end
  
            