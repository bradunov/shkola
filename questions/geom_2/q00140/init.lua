
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
green_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "6f6",
        ["line_width"] = "3"}; 	

yelow_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "f90",
        ["line_width"] = "1"}; 		

point_style = 
	{["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};		

grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};	
							
text_style = {["font_size"] = "16"}

meas =  {"cm", "°"}
dat = {"R", "φ", "l" }
pi = "π"
con = lib.math.round_dec(math.pi, 3)

numb = {}
pol = {3, 4, 5, 6, 8, 10, 12}

ind = math.random(7)

numb[1] = 3 + math.random(15)
numb[2] = math.floor(360 / pol[ind])	
numb[3] =  2 * con * numb[1] / pol[ind]    
numb[3] = lib.math.round_dec(numb[3],2)

mycanvas = function()
	 		  
  lib.start_canvas(200, 180, "center")   
  
   w = 12
   ow = 9
   v = 3

   if (ind == 1) then 	                     	 
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false) 
	  lib.add_line(v, v+7*w, 7*w, 0, green_style, false, false)
	  lib.add_line(v+7*w, v+7*w, 3.4*w, 6*w, green_style, false, false) 
      lib.add_input(v+2*w, ow+5*w, 40, 30, dat[1])	  
      lib.add_input(v+5*w, v+7*w, 40, 30, dat[2]) 	  
      lib.add_input(v, v+12*w, 40, 30, dat[3])
      lib.add_circle (v+7*w, v+7*w, 2, point_style, false, false) 
      lib.add_curved_path (v, v+7*w, {{w+4, 9*w+2, 10.6*w, 6*w+2}}, green_style, false, false)
      lib.add_straight_path(v, v+7*w, {{10.5*w,-6*w},  {0,12*w}, {-10.5*w,-6*w}}, style, true, false)  
   end  
   if (ind == 2) then          	   	  
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false) 
	  lib.add_line(v+7*w, v+7*w, 5*w, -5*w, green_style, false, false)
	  lib.add_line(v+7*w, v+7*w, 5*w, 5*w, green_style, false, false)	  
      lib.add_input(v+7*w, v+3*w, 40, 30, dat[1]) 
      lib.add_input(ow+6*w, v+6*w, 40, 30, dat[2]) 
      lib.add_input(v+13*w, v+6*w, 40, 30, dat[3]) 
      lib.add_circle (v+7*w, v+7*w, 2, point_style, false, false)
      lib.add_curved_path (v+12*w, v+2*w, {{5*w-ow, v+5*w, 0, 10*w}}, green_style, false, false)	  
      lib.add_straight_path(v+2*w, v+2*w, {{10*w,0}, {0,10*w}, {-10*w,0},  {0,-10*w}}, style, true, false)	
   end 
   if (ind == 3) then 	   	  
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false) 
	  lib.add_line(v+7*w, v+7*w, 0, -7*w, green_style, false, false)
	  lib.add_line(v+7*w, v+7*w, ow+6*w, -2*w-2, green_style, false, false)	  
	  lib.add_input(5*w, v+2*w, 40, 30, dat[1]) 
      lib.add_input(v+6*w, v+5*w, 40, 30, dat[2]) 
      lib.add_input(v+11*w, v+w, 40, 30, dat[3]) 
      lib.add_circle (v+7*w, v+7*w, 2, point_style, false, false)
      lib.add_curved_path (v+7*w, v, {{5*w-ow, -v, 6.8*w, 4.8*w}}, green_style, false, false)  
      lib.add_straight_path(v+0.3*w, v+4.7*w, {{6.7*w,-4.7*w}, {6.7*w,4.7*w}, {-2.5*w,8*w}, {-8.3*w,0}, {-2.5*w,-8*w}}, style, true, false)      
   end
   if (ind == 4) then          	   	  
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false) 
	  lib.add_line(v+7*w, v+7*w, 3.5*w, -6*w, green_style, false, false)
	  lib.add_line(v+7*w, v+7*w, 7*w, 0, green_style, false, false)
      lib.add_input(v+7*w, v+2*w, 40, 30, dat[1]) 
      lib.add_input(v+7*w, v+5*w, 40, 30, dat[2]) 
      lib.add_input(ow+12*w, v+3*w, 40, 30, dat[3]) 
      lib.add_circle (v+7*w, v+7*w, 2, point_style, false, false)
      lib.add_curved_path (v+10.3*w, v+w, {{2*w+ow+2, 2*v, 3.7*w, 6*w}}, green_style, false, false)  	  
      lib.add_straight_path(v, v+7*w, {{3.5*w,-6*w}, {7*w,0}, {3.5*w,6*w}, {-3.5*w,6*w}, {-7*w,0}, {-3.5*w,-6*w}}, style, true, false)     	 
   end  
   if (ind == 5) then  	   
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false) 
	  lib.add_line(v+7*w, v+7*w, 5*w, -5*w, green_style, false, false)
	  lib.add_line(v+7*w, v+7*w, 7*w, 0, green_style, false, false)
      lib.add_input(v+8*w, v+2*w, 40, 30, dat[1]) 
      lib.add_input(v+7*w, v+5*w, 40, 30, dat[2]) 	  
      lib.add_input(ow+12*w, v+3*w, 40, 30, dat[3]) 
      lib.add_circle (v+7*w, v+7*w, 2, point_style, false, false) 
      lib.add_curved_path (v+12*w, v+2*w, {{w+ow, w+ow, 2*w, 5*w}}, green_style, false, false)  	  	  
      lib.add_straight_path(v+2*w, v+2*w, {{5*w,-2*w}, {5*w,2*w}, {2*w,5*w}, {-2*w,5*w}, {-5*w,2*w}, {-5*w,-2*w}, {-2*w,-5*w}, {2*w,-5*w}}, style, true, false)      
   end 
   if (ind == 6) then    	  
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false) 
	  lib.add_line(v+7*w, v+7*w, 4*w+v, -ow-5*w, green_style, false, false)
	  lib.add_line(v+7*w, v+7*w, 7*w-v, -2*w, green_style, false, false)
      lib.add_input(ow+7*w, ow+2*w, 40, 30, dat[1]) 
      lib.add_input(v+7*w, v+5*w, 40, 30, dat[2]) 
      lib.add_input(v+12*w, v+2*w, 40, 30, dat[3]) 
      lib.add_circle (v+7*w, v+7*w, 2, point_style, false, false)
      lib.add_curved_path (v+11*w, v+1.3*w, {{w+2, v, 2.8*w, 3.7*w}}, green_style, false, false)	  
      lib.add_straight_path(v+0.3*w, v+4.9*w, {{2.5*w,-3.5*w}, {4.2*w,-1.4*w}, {4.2*w, 1.4*w}, {2.5*w, 3.5*w}, {0, 4.3*w}, {-2.5*w, 3.5*w}, {-4.2*w, 1.4*w}, {-4.2*w,-1.4*w}, {-2.5*w,-3.5*w}, {0, -4.3*w}}, style, true, false)    
   end
   if (ind == 7) then 	   	  
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false) 
	  lib.add_line(v+7*w, v+7*w, 7*w, 0, green_style, false, false)
	  lib.add_line(v+7*w, v+7*w, 6.2*w, ow-4*w, green_style, false, false)
      lib.add_input(ow+8*w, v+3*w, 40, 30, dat[1])
      lib.add_input(v+7*w, ow+5*w, 50, 40, dat[2]) 
      lib.add_input(ow+12*w, v+4*w, 40, 30, dat[3]) 
      lib.add_circle (v+7*w, v+7*w, 2, point_style, false, false)	
      lib.add_curved_path (v+13.1*w, v+3.8*w, {{ow, v, 0.9*w, 3.2*w}}, green_style, false, false)	  
      lib.add_straight_path(v, v+7*w, {{0.8*w,-3.3*w}, {2.7*w,-2.7*w}, {3.5*w,-w}, {3.5*w, w}, {2.7*w, 2.7*w}, {0.8*w,3.3*w}, {-0.8*w,3.3*w}, {-2.7*w, 2.7*w}, {-3.5*w, w}, {-3.5*w, -w}, {-2.7*w, -2.7*w}, {-0.8*w,-3.3*w}}, style, true, false)      
   end 
  
--[[
  for i = 1,15 do
    lib.add_line(v, v+(i-1)*w, 14*w, 0, grid_style, false, false)
  end
  for i = 1,15 do
    lib.add_line(v+(i-1)*w, v, 0, 14*w, grid_style, false, false)
  end
  
 polukrugovi 
  lib.add_curved_path (v+2*w, v+3*w, {{-4*w, 2*w, 0, 4*w}}, style, false, false) 
  lib.add_curved_path (v+4*w, v+3*w, {{4*w, 2*w, 0, 4*w}}, style, false, false)
  lib.add_curved_path (v+8*w, v+5*w, {{2*w, -2*w, 4*w, 0}}, style, false, false) 
  lib.add_curved_path (v+14*w, v+5*w, {{2*w, 4*w, 4*w, 0}}, style, false, false)
]]--   

  lib.end_canvas()
end
              
      