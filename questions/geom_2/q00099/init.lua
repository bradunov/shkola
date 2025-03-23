
style = 
	{["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};

dif_style = 
	{["off_color"] = "fff",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};

blue_style = {["off_color"] = "cff",
               ["on_color"] = "cff",
               ["line_color"] = "000",
               ["line_width"] = "0.5"};
			   
red_style = {["off_color"] = "f30",
               ["on_color"] = "f30",
               ["line_color"] = "000",
               ["line_width"] = "1"};		

text_style = {["font_size"] = "14"}

meas = {"cm", "cm²"}

ind = {}			   
for i = 1,3 do
    ind[i] = math.random(3)
end

dig = math.sqrt(2) 

mycanvas = function()

  lib.start_canvas(320, 340, "center")

  w = 20
  ow = 15

  lib.add_straight_path (ow+w, ow+3*w, {{2*w,-2*w}, {2*w,2*w}, {-2*w,2*w}, {-2*w,-2*w}}, red_style, true, false)
  lib.add_line(ow+2*w, ow+2*w, 2*w, 0, dif_style, true, false)
  lib.add_line(ow+w, ow+3*w, 4*w, 0, dif_style, true, false)
  lib.add_line(ow+3*w, ow+2*w, 0, 3*w, dif_style, true, false)
  lib.add_line(ow+2*w, ow+2*w, 0, w, dif_style, true, false)
  lib.add_line(ow+3*w, ow+2*w, w, w, dif_style, true, false)
  lib.add_input(1, ow, 40, 30, lib.check_number(2, 15))
  lib.add_input(3+w, ow, 50, 30, meas[2])

--[[1]]--
  if (ind[1] == 1) then
 --[[nema 1]]-- 
  lib.add_straight_path (ow+8*w, ow+3*w, {{w,-w}, {0,w}, {-w,0}}, blue_style, true, false)  --[[2]]--  
  lib.add_straight_path (ow+9*w, ow+3*w, {{0,-w}, {w,0}, {0,w}, {-w,0}}, blue_style, true, false)  --[[3]]--   
  lib.add_straight_path (ow+10*w, ow+3*w, {{0, -w}, {w,w}, {-w,0}}, blue_style, true, false)  --[[4]]--
  lib.add_straight_path (ow+11*w, ow+3*w, {{-w,-w}, {w,0}, {w,w}, {-w, 0}}, blue_style, true, false)   --[[5]]--  
  lib.add_straight_path (ow+9*w, ow+3*w, {{2*w,2*w}, {0,-2*w}, {-2*w, 0}}, blue_style, true, false)    --[[6]]-- 
  lib.add_straight_path (ow+9*w, ow+3*w, {{0, 2*w}, {2*w,0}, {-2*w,-2*w}}, blue_style, true, false)  --[[7]]--    
  lib.add_input(ow+11*w, ow, 50, 30, lib.check_number(1.75, 30))
  lib.add_input(ow+13*w-5, ow, 50, 30, meas[2])
  end

  if (ind[1] == 2) then
 --[[nema 3, dodato 2 x 6&7]]--  
  lib.add_straight_path (ow+10*w, ow+3*w, {{w,w}, {w,-w}, {-2*w,0}}, blue_style, true, false)  --[[1]]-- 
  lib.add_straight_path (ow+9*w, ow+2*w, {{w,-w}, {0,w}, {-w,0}}, blue_style, true, false)  --[[2]]--    
  lib.add_straight_path (ow+10*w, ow+4*w, {{0, -w}, {w,w}, {-w,0}}, blue_style, true, false)  --[[4]]--
  lib.add_straight_path (ow+10*w, ow+3*w, {{-w,-w}, {w,0}, {w,w}, {-w, 0}}, blue_style, true, false)   --[[5]]--  
  lib.add_straight_path (ow+10*w, ow+4*w, {{2*w,2*w}, {0,-2*w}, {-2*w, 0}}, blue_style, true, false)    --[[6]]-- 
 lib.add_straight_path (ow+10*w, ow+4*w, {{0,2*w}, {2*w,0}, {-2*w, -2*w}}, blue_style, true, false)    --[[6]]--
  lib.add_straight_path (ow+12*w, ow+4*w, {{0, 2*w}, {2*w,0}, {-2*w,-2*w}}, blue_style, true, false)  --[[7]]--    
  lib.add_straight_path (ow+10*w, ow+4*w, {{-2*w, 2*w}, {2*w,0}, {0,-2*w}}, blue_style, true, false)  --[[7]]--    


  lib.add_input(ow+11*w, ow, 50, 30, lib.check_number(2.75, 30))
  lib.add_input(ow+13*w-5, ow, 50, 30, meas[2])
  end

  if (ind[1] == 3) then
  --[[sve]]--
  lib.add_straight_path (ow+10*w, ow+2*w, {{w,w}, {-w,w}, {0,-2*w}}, blue_style, true, false)  --[[1]]--   
  lib.add_straight_path (ow+10*w, ow+2*w, {{w,w}, {0,-w}, {-w,0}}, blue_style, true, false)  --[[2]]--   
  lib.add_straight_path (ow+10*w, ow+2*w, {{0,-w}, {w,0}, {0,w}, {-w,0}}, blue_style, true, false)  --[[3]]--   
  lib.add_straight_path (ow+11*w, ow+2*w, {{w,w}, {-w, 0}, {0,-w}}, blue_style, true, false)  --[[4]]-- 
  lib.add_straight_path (ow+11*w, ow+2*w, {{w,w}, {w,0}, {-w,-w}, {-w,0}}, blue_style, true, false)   --[[5]]--       
  lib.add_straight_path (ow+9*w, ow+5*w, {{2*w,0}, {0, -2*w}, {-2*w, 2*w}}, blue_style, true, false)    --[[6]]-- 
  lib.add_straight_path (ow+11*w, ow+5*w, {{0, -2*w}, {2*w,0}, {-2*w,2*w}}, blue_style, true, false)  --[[7]]--      
  lib.add_input(ow+11*w, ow, 50, 30, lib.check_number(2, 30))
  lib.add_input(ow+13*w-5, ow, 50, 30, meas[2])   
  end  
  
--[[2]]-- 
  if (ind[2] == 1) then
  --[[nema 1]]--
  lib.add_straight_path (ow+4*w, ow+8*w, {{0,-w}, {w,0}, {0,w}, {-w,0}}, blue_style, true, false)  --[[3]]--   
  lib.add_straight_path (ow+4*w, ow+8*w, {{0, 2*w}, {2*w,0}, {-2*w,-2*w}}, blue_style, true, false)  --[[7]]--    
  lib.add_straight_path (ow+4*w, ow+11*w, {{-w,w}, {0, -w}, {w,-w}, {0,w}}, blue_style, true, false)   --[[5]]--    
  lib.add_straight_path (ow+4*w, ow+11*w, {{0,2*w}, {-2*w,0}, {2*w, -2*w}}, blue_style, true, false)    --[[6]]-- 
  lib.add_straight_path (ow+2*w, ow+13*w, {{-w,0}, {0,w}, {w,-w}}, blue_style, true, false)  --[[2]]-- 
  lib.add_straight_path (ow+4*w, ow+13*w, {{0,w}, {w,0}, {-w,-w}}, blue_style, true, false)  --[[4]]-- 
  lib.add_input(ow, ow+15*w, 50, 30, lib.check_number(1.75, 30))
  lib.add_input(2*w+ow-5, ow+15*w, 50, 30, meas[2])
  end

 if (ind[2] == 2) then
  --[[nema 6]]--
  lib.add_straight_path (ow+w, ow+9*w, {{2*w,0}, {-w,-w}, {-w,w}}, blue_style, true, false)  --[[1]]--   
  lib.add_straight_path (ow+4*w, ow+8*w, {{w,0}, {0,-w}, {-w,w}}, blue_style, true, false)  --[[2]]--   
  lib.add_straight_path (ow+5*w, ow+9*w, {{0,-w}, {w,0}, {0,w}, {-w,0}}, blue_style, true, false)  --[[3]]--   
  lib.add_straight_path (ow+6*w, ow+8*w, {{0,w}, {w,0}, {-w,-w}}, blue_style, true, false)  --[[4]]-- 
  lib.add_straight_path (ow+3*w, ow+12*w, {{-w,w}, {0, -w}, {w,-w}, {0,w}}, blue_style, true, false)   --[[5]]--    

  lib.add_straight_path (ow+3*w, ow+11*w, {{0, -2*w}, {2*w,0}, {-2*w,2*w}}, blue_style, true, false)  --[[7]]--   
  lib.add_input(ow, ow+15*w, 50, 30, lib.check_number(1.5, 30))
  lib.add_input(2*w+ow-5, ow+15*w, 50, 30, meas[2])   
  end  

  if (ind[2] == 3) then
  --[[sve]]--
  lib.add_straight_path (ow+2*w, ow+9*w, {{dig*w,0}, {-dig*w,dig*w}, {0,-dig*w}}, blue_style, true, false)  --[[1]]--   
  lib.add_straight_path (ow+(1+dig)*w+5, ow+14*w, {{dig*w/2,-dig*w/2}, {dig*w/2,dig*w/2}, {-dig*w,0}}, blue_style, true, false)  --[[2]]--   
  lib.add_straight_path (ow+2*w, ow+(12+dig)*w-3, {{dig*w/2,-dig*w/2}, {dig*w/2,dig*w/2}, {-dig*w/2,dig*w/2}, {-dig*w/2,-dig*w/2}}, blue_style, true, false)  --[[3]]--   
  lib.add_straight_path (ow+3*w, ow+9*w, {{w,0}, {0,-w}, {-w,w}}, blue_style, true, false)  --[[4]]-- 
  lib.add_straight_path (ow+2*w, ow+9*w, {{w,0}, {w, -w}, {-w,0}, {-w,w}}, blue_style, true, false)   --[[5]]--    
  lib.add_straight_path (ow+2*w, ow+(9+dig)*w, {{dig*w,-dig*w}, {0, 2*dig*w}, {-dig*w, -dig*w}}, blue_style, true, false)    --[[6]]-- 
  lib.add_straight_path (ow+2*w, ow+(9+dig)*w, {{0,2*dig*w}, {dig*w,-dig*w}, {-dig*w,-dig*w}}, blue_style, true, false)  --[[7]]--   
  lib.add_input(ow, ow+15*w, 50, 30, lib.check_number(2, 30))
  lib.add_input(2*w+ow-5, ow+15*w, 50, 30, meas[2])     
  end    
  
--[[3]]--
  if (ind[3] == 1) then 
 --[[nema 3 i 5 ]]-- 
  lib.add_straight_path (ow+9*w, ow+10*w, {{2*w,0}, {-w,-w}, {-w,w}}, blue_style, true, false)  --[[1]]-- 
  lib.add_straight_path (ow+8*w, ow+12*w, {{w,0}, {0,w}, {-w,-w}}, blue_style, true, false)  --[[2]]--  
    
  lib.add_straight_path (ow+11*w, ow+12*w, {{0, w}, {w,-w}, {-w,0}}, blue_style, true, false)  --[[4]]--

  lib.add_straight_path (ow+9*w, ow+12*w, {{0, -2*w}, {2*w,0}, {-2*w,2*w }}, blue_style, true, false)    --[[6]]-- 
  lib.add_straight_path (ow+9*w, ow+12*w, {{2*w,0}, {0, -2*w}, {-2*w,2*w}}, blue_style, true, false)  --[[7]]--   
  lib.add_input(ow+11*w, ow+15*w, 50, 30, lib.check_number(1.5, 30))
  lib.add_input(ow+13*w-5, ow+15*w, 50, 30, meas[2])    
  end 

  if (ind[3] == 2) then
 --[[nema 5]]--   
  lib.add_straight_path (ow+9*w, ow+9*w, {{2*w,0}, {-w,-w}, {-w,w}}, blue_style, true, false)  --[[1]]-- 
  lib.add_straight_path (ow+8*w, ow+13*w, {{w,0}, {0,w}, {-w,-w}}, blue_style, true, false)  --[[2]]--  
  lib.add_straight_path (ow+9.5*w, ow+10*w, {{0,-w}, {w,0}, {0,w}, {-w,0}}, blue_style, true, false)  --[[3]]--   
  lib.add_straight_path (ow+11*w, ow+13*w, {{0, w}, {w,-w}, {-w,0}}, blue_style, true, false)  --[[4]]--
  lib.add_straight_path (ow+(10-dig)*w, ow+10*w, {{2*dig*w, 0}, {-dig*w,dig*w+2}, {-dig*w-2,-dig*w-2}}, blue_style, true, false)    --[[6]]-- 
  lib.add_straight_path (ow+10*w-2, ow+(13-dig)*w-2, {{dig*w+2,dig*w+2}, { -2*dig*w,0}, {dig*w+2,-dig*w-2}}, blue_style, true, false)  --[[7]]-- 
  lib.add_input(ow+11*w, ow+15*w, 50, 30, lib.check_number(1.75, 30))
  lib.add_input(ow+13*w-5, ow+15*w, 50, 30, meas[2])       
  end 

  if (ind[3] == 3) then 
 --[[ima 2x5]]-- 
  lib.add_straight_path (ow+10*w, ow+10*w, {{2*w,0}, {-w,-w}, {-w,w}}, blue_style, true, false)  --[[1]]--   
  lib.add_straight_path (ow+(11-dig/2)*w, ow+(9-dig/2)*w-2, {{dig*w,0}, {-dig*w/2,-dig*w/2}, {-dig*w/2,dig*w/2}}, blue_style, true, false)  --[[2]]-- 
  lib.add_straight_path (ow+10.5*w, ow+14*w, {{0,-w}, {w,0}, {0,w}, {-w,0}}, blue_style, true, false)  --[[3]]--  
  lib.add_straight_path (ow+(11-dig/2)*w, ow+9*w-1, {{dig*w,0}, {-dig*w/2,-dig*w/2}, {-dig*w/2,dig*w/2}}, blue_style, true, false)  --[[4]]--  
  lib.add_straight_path (ow+11*w, ow+14*w, {{w,0}, {w,w}, {-w,0}, {-w,-w}}, blue_style, true, false)   --[[5]]--  
  lib.add_straight_path (ow+11*w, ow+14*w, {{-w,0}, {-w,w}, {w,0}, {w,-w}}, blue_style, true, false)   --[[5]]--  
  lib.add_straight_path (ow+(9+dig/2)*w-2, ow+(10+dig)*w+2, {{2*dig*w, 0}, {-dig*w,-dig*w}, {-dig*w,dig*w}}, blue_style, true, false)    --[[6]]-- 
  lib.add_straight_path (ow+(9+dig/2)*w-2, ow+13*w, {{2*dig*w, 0}, {-dig*w,-dig*w}, {-dig*w,dig*w}}, blue_style, true, false)  --[[7]]--  
  lib.add_input(ow+11*w, ow+15*w, 50, 30, lib.check_number(2.25, 30))
  lib.add_input(ow+13*w-5, ow+15*w, 50, 30, meas[2])         
  end   


  for i = 1,7 do
    lib.add_line(ow, ow+(i-1)*w, 6*w, 0, style, false, false)
  end

  for i = 1,7 do
    lib.add_line(ow+(i-1)*w, ow, 0, 6*w, style, false, false)
  end
   
  lib.end_canvas()
end  
            