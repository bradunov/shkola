
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
point_style = 
	{["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};		

grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.1"};	
							
text_style = {["font_size"] = "16"}

ind = {}			   
for i = 1,2 do
    ind[i] = math.random(8)
end

chp = math.random(2)
chq = math.random(2)

mycanvas = function()
	 		  
  lib.start_canvas(320, 140, "center")   
  
   w = 24
   ow = 18
   v = 5

  if (ind[1] == 1) then          
     lib.add_straight_path(ow, v, {{5*w,0}, {-w,2*w}, {w,w}, {-5*w,0}, {2*w,-w}, {-2*w,-2*w}}, style, true, false)     
     con1 = msg[2]
	 edge1 = numb[3]
	 if (chp == 1) then
	     ptp = point[2]
	 else
	 	 ptp = point[1]
	 end	 
  end
  if (ind[1] == 2) then  
     lib.add_straight_path(ow, v+3*w, {{w,-2*w}, {w,-w}, {2*w,0}, {2*w,2*w},  {0,w}, {-w,2*w}, {-2*w,0}, {-3*w,-w}, {0,-w}}, style, true, false)  
     con1 = msg[1] 
	 edge1 = numb[6]
	 if (chp == 1) then
	     ptp = point[1]
	 else
	 	 ptp = point[1]
	 end	 
  end
  if (ind[1] == 3) then  
  lib.add_straight_path (ow, v+4*w, {{0,-w}, {w,-w}, {-w,-2*w}, {w, 0}, {w, 3*w}, {2*w,-3*w}, {w,0}, {w,2*w}, {-2*w,2*w}, {-4*w,0}, {0,-w}  }, style, false, true) 
     con1 = msg[2]
	 edge1 = numb[7]
	 if (chp == 1) then
	     ptp = point[1]
	 else
	 	 ptp = point[2]
	 end	 
  end
  if (ind[1] == 4) then  
     lib.add_straight_path (ow, v, {{5*w,0}, {0,2*w}, {-w, 0}, {0,-w}, {-w,0}, {0,w}, {-2*w,0}, {0,w}, {2*w,0}, {0,w}, {w,0}, {0,-w},{w,0}, {0,2*w}, {-5*w,0}, {0,-5*w}}, style, false, true) 
     con1 = msg[2]
	 edge1 = numb[9]
	 if (chp == 1) then
	     ptp = point[1]
	 else
	 	 ptp = point[2]
	 end	 
  end
  if (ind[1] == 5) then
     lib.add_straight_path (ow+3*w, v, {{2*w,3*w},{0,w}, {-3*w,w}, {-2*w,-w},{0,-w}, {w, -2*w}, {2*w,-w}}, style, true, false)   
     con1 = msg[1]
	 edge1 = numb[4]
	 if (chp == 1) then
	     ptp = point[1]
	 else
	 	 ptp = point[1]
	 end	 
  end
  if (ind[1] == 6) then
     lib.add_straight_path (ow, v+2*w, {{w,-w}, {2*w,-w}, {w,0}, {2*w,w}, {0,w}, {-w,2*w}, {-2*w,w}, {-w,0}, {-2*w,-w}, {0, -2*w}}, style, false, true)   
     con1 = msg[1]
	 edge1 = numb[7]
	 if (chp == 1) then
	     ptp = point[1]
	 else
	 	 ptp = point[1]
	 end	 
  end
  if (ind[1] == 7) then
     lib.add_straight_path (ow+4*w, v, {{0,2*w},  {2*w,2*w}, {-6*w,-w}, {4*w,-3*w},}, style, false, true)  
     con1 = msg[2]
	 edge1 = numb[1]
	 if (chp == 1) then
	     ptp = point[2]
	 else
	 	 ptp = point[1]
	 end	 
  end
  if (ind[1] == 8) then
     lib.add_straight_path (ow, v, {{w,0}, {w,2*w}, {w,-2*w}, {w, 3*w}, {w, -w}, {0, 2*w}, {-3*w, 0}, {-2*w, -4*w} }, style, false, true) 
     con1 = msg[2]
	 edge1 = numb[5]
	 if (chp == 1) then
	     ptp = point[2]
	 else
	 	 ptp = point[1]
	 end	 
  end
    
  if (ind[2] == 1) then
     lib.add_straight_path(ow+9*w, v, {{2*w,0}, {w,w}, {0,2*w}, {-w,w}, {-2*w, 0}, {-w,-w}, {0,-2*w}, {w,-w}}, style, true, false) 
     con2 = msg[1]
	 edge2 = numb[5]
	 if (chq == 1) then
	     ptq = point[1]
	 else
	 	 ptq = point[1]
	 end	 
  end
  if (ind[2] == 2) then  
     lib.add_straight_path (ow+6*w, v, {{6*w,w}, {-2*w,2*w}, {-2*w,0}, {0,-w}, {-2*w, -2*w}}, style, false, true)  
     con2 = msg[2]
	 edge2 = numb[2]
	 if (chq == 1) then
	     ptq = point[2]
	 else
	 	 ptq = point[1]
	 end	 
  end
  if (ind[2] == 3) then 
     lib.add_straight_path (ow+7*w, v+4*w, {{0,-3*w}, {2*w,-w}, {w,0}, {2*w,w}, {0,3*w}, {-w,0}, {-w,-2*w},  {-w,2*w}, {-2*w,0}}, style, false, true)
     con2 = msg[2]
	 edge2 = numb[6]
	 if (chq == 1) then
	     ptq = point[2]
	 else
	 	 ptq = point[1]
	 end	 
  end
  if (ind[2] == 4) then 	
     lib.add_straight_path (ow+6*w, v+w, {{3*w,-w}, {3*w,2*w}, {-2*w,2*w},  {-w, -2*w}, {-w,0}, {-w,2*w},  {-w,-3*w}}, style, false, true)        
     con2 = msg[2]
	 edge2 = numb[4]
	 if (chq == 1) then
	     ptq = point[1]
	 else
	 	 ptq = point[2]
	 end	 
  end
  if (ind[2] == 5) then
     lib.add_straight_path (ow+11*w, v+w, {{-4*w,0}, {0,-w}, {5*w,0}, {0,5*w}, {-5*w,0}, {0,-3*w}, {3*w,0}, {0, w}, {-2*w, 0}, {0, w}, {3*w,0}, {0, -3*w} }, style, false, true)  
     con2 = msg[2]
	 edge2 = numb[8]
	 if (chq == 1) then
	     ptq = point[2]
	 else
	 	 ptq = point[1]
	 end	 
  end
  if (ind[2] == 6) then
     lib.add_straight_path (ow+7*w, v+2*w, {{w,-w}, {2*w,0}, {2*w,w}, {-2*w,w}, {-2*w, 0}, {-w,-w}}, style, false, true)  
     con2 = msg[1]
	 edge2 = numb[3]
	 if (chq == 1) then
	     ptq = point[2]
	 else
	 	 ptq = point[1]
	 end	 
  end
  if (ind[2] == 7) then
     lib.add_straight_path (ow+8*w, v+2*w, {{2*w,-2*w}, {2*w,0}, {0,2*w},  {-2*w,3*w}, {-2*w,-3*w}}, style, false, true)      
     con2 = msg[1]
	 edge2 = numb[2]
	 if (chq == 1) then
	     ptq = point[1]
	 else
	 	 ptq = point[1]
	 end	 
  end
  if (ind[2] == 8) then
     lib.add_straight_path (ow+7*w, v, {{5*w,w}, {-3*w, 3*w}, {-w,0}, {-w, -4*w}}, style, false, true)
     con2 = msg[1]
	 edge2 = numb[1]
	 if (chq == 1) then
	     ptq = point[2]
	 else
	 	 ptq = point[1]
	 end	 
  end

  if (chp == 1) then
      lib.add_circle (3*w-ow, ow+3*w, 2, point_style, true, false)
      lib.add_text(3*w-v, ow+3*w, "P", text_style, false, false) 
  else
      lib.add_circle (3*w-v, ow+2*w, 2, point_style, true, false)
      lib.add_text(v+3*w, ow+2*w, "P", text_style, false, false) 
  end  

  if (chq == 1) then
      lib.add_circle (11*w-v, ow+3*w, 2, point_style, true, false)
      lib.add_text(11*w+v, ow+3*w, "Q", text_style, false, false)  
  else
      lib.add_circle (10*w-v, ow+2*w, 2, point_style, true, false)
      lib.add_text(10*w+v, ow+2*w, "Q", text_style, false, false)  
  end

  
--[[
 for i = 1,6 do
    lib.add_line(ow, ow+(i-1)*w, 12*w, 0, grid_style, false, false)
  end
  for i = 1,13 do
    lib.add_line(ow+(i-1)*w, ow, 0, 5*w, grid_style, false, false)
 end
 ]]--

  lib.end_canvas()
end
            