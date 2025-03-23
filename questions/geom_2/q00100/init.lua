
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

blue_style = 
	{["off_color"] = "aaf",
        ["on_color"] = "aff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

red_style = 
	{["off_color"] = "f00",
        ["on_color"] = "f00",
        ["line_color"] = "000",
        ["line_width"] = "1"};
		
green_style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};

yelow_style = 
	{["off_color"] = "ffcc80",
        ["on_color"] = "ffcc80",
        ["line_color"] = "000",
        ["line_width"] = "1"};	
	
grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};	
							
meas = {"cm", "cm²"}
	
area = {}

area[1] = {10.5, 7.5, 19, 20}
area[2] = {12, 9, 10.5, 12}
area[3] = {11.5, 15, 12, 9}
area[4] = {17, 7, 16, 14.5}


ind = {}			   
for i = 1,4 do
    ind[i] = math.random(4)
end


mycanvas = function()
	 		  
  lib.start_canvas(320, 320, "center")   
  
   w = 20
   ow = 15

  lib.add_input(ow, ow, 50, 30, lib.check_number(area[1][ind[1]], 30))
  lib.add_input(ow+7*w, ow, 50, 30, lib.check_number(area[2][ind[2]], 30))
  lib.add_input(ow, ow+7*w, 50, 30, lib.check_number(area[3][ind[3]], 30))
  lib.add_input(ow+7*w, ow+7*w, 50, 30, lib.check_number(area[4][ind[4]], 30))

  lib.add_input(2*ow+w, ow, 50, 30, meas[2])
  lib.add_input(2*ow+8*w, ow, 50, 30, meas[2])
  lib.add_input(2*ow+w, ow+7*w, 50, 30, meas[2])
  lib.add_input(2*ow+8*w, ow+7*w, 50, 30, meas[2])  
  
--[[red]]--
  if (ind[1] == 1) then          
     lib.add_straight_path(ow+w, ow+2*w, {{5*w,0}, {-w,2*w}, {w,w}, {-5*w,0}, {2*w,-w}, {-2*w,-2*w}}, red_style, true, false)     
  end
  if (ind[1] == 2) then  
     lib.add_straight_path(ow+w, ow+5*w, {{w,-3*w}, {w,3*w}, {w,-3*w}, {w,3*w}, {w,-3*w}, {0,3*w}, {-5*w,0}}, red_style, true, false)  
  end
  if (ind[1] == 3) then  
  lib.add_straight_path (ow, ow+6*w, {{0,-w}, {w,-w}, {-w,-2*w}, {2*w, 0}, {w, 3*w}, {2*w,-3*w}, {w,0}, {w,2*w}, {-2*w,2*w}, {-5*w,0}, {0,-w}  }, red_style, false, true) 
  end
  if (ind[1] == 4) then  
     lib.add_straight_path (ow+w, ow+w, {{5*w,0}, {0,5*w}, {-5*w,0}, {0,-5*w}}, red_style, false, true) 
     lib.add_straight_path (ow+3*w, ow+2*w, {{w,0}, {0,w}, {w,0}, {0,w}, {-w, 0}, {0,w}, {-w,0}, {0,-w}, {-w,0}, {0,-w}, {w,0}, {0,-w}}, style, false, true) 
  end
  
--[[blue]]--
  if (ind[2] == 1) then
     lib.add_straight_path(ow+10*w, ow+2*w, {{2*w,0}, {w,w}, {0,2*w}, {-w,w}, {-2*w, 0}, {-w,-w}, {0,-2*w}, {w,-w}}, blue_style, true, false) 
     lib.add_straight_path(ow+11*w, ow+3*w, {{w,w}, {-w,w}, {-w,-w}, {w,-w}}, style, true, false) 
  end
  if (ind[2] == 2) then  
  lib.add_straight_path (ow+7*w, ow+2*w, {{6*w,w}, {-2*w,2*w}, {-2*w,0}, {0,-w}, {-2*w, -2*w}}, blue_style, false, true)  
  end
  if (ind[2] == 3) then 
     lib.add_straight_path (ow+7*w, ow+6*w, {{6*w,-5*w}, {-w,5*w}, {-2*w,0}, {w,-2*w}, {-w,0}, {-w,2*w}, {-2*w,0}}, blue_style, false, true)
  end
  if (ind[2] == 4) then 	
     lib.add_straight_path (ow+8*w, ow+2*w, {{3*w,-w}, {3*w,2*w}, {-2*w,2*w},  {-w, -2*w}, {-w,0}, {-w,2*w},  {-w,-3*w}}, blue_style, false, true)        
  end
  
   --[[green]]--
  if (ind[3] == 1) then
     lib.add_straight_path (ow+4*w, ow+9*w, {{2*w,3*w},{0,w}, {-5*w,0}, {0,-w}, {w, -2*w}, {w,2*w}, {w,-3*w} }, green_style, true, false)   
  end
  if (ind[3] == 2) then
     lib.add_straight_path (ow+w, ow+10*w, {{w,-w}, {2*w,w}, {w,-w}, {w,w}, {0,2*w}, {-w,w}, {-w,-w}, {-w,w}, {-2*w,-w}, {0, -2*w}}, green_style, false, true)   
  end
  if (ind[3] == 3) then
    lib.add_straight_path (ow+3*w, ow+9*w, {{2*w,0}, {0,2*w},  {2*w,2*w}, {-6*w,-w}, {2*w,-3*w},}, green_style, false, true)  
  end
  if (ind[3] == 4) then
     lib.add_straight_path (ow, ow+9*w, {{2*w,0}, {w,4*w}, {w,-4*w}, {w, 4*w}, {w, -2*w}, {0, 2*w}, {-3*w, 0}, {-3*w, -4*w} }, green_style, false, true) 
  end
  
   --[[yelow]]--
  if (ind[4] == 1) then
     lib.add_straight_path (ow+12*w, ow+10*w, {{-4*w,0}, {0,-w}, {5*w,0}, {0,5*w}, {-5*w,0}, {0,-3*w}, {3*w,0}, {0, w}, {-2*w, 0}, {0, w}, {3*w,0}, {0, -3*w} }, yelow_style, false, true)  
  end
  if (ind[4] == 2) then
     lib.add_straight_path (ow+8*w, ow+11*w, {{w,-w}, {2*w,0}, {2*w,w}, {-2*w,w}, {-2*w, 0}, {-w,-w}}, yelow_style, false, true)  
  end
  if (ind[4] == 3) then
     lib.add_straight_path (ow+9*w, ow+10*w, {{2*w,-2*w}, {2*w,0}, {0,2*w},  {-2*w,5*w}, {-2*w,-5*w}}, yelow_style, false, true)      
  end
  if (ind[4] == 4) then
     lib.add_straight_path (ow+8*w, ow+9*w, {{6*w,w}, {-2*w, 3*w}, {-w,0}, {-2*w, -w}, {-w, -3*w}}, yelow_style, false, true)
  end

 for i = 1,16 do
    lib.add_line(ow, ow+(i-1)*w, 14*w, 0, grid_style, false, false)
  end

  for i = 1,15 do
    lib.add_line(ow+(i-1)*w, ow, 0, 15*w, grid_style, false, false)
  end

  lib.end_canvas()
end
