
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
green_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "6f6",
        ["line_width"] = "2"}; 	

yelow_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "f90",
        ["line_width"] = "2"}; 		

yelowfull_style = 
	{["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "f90",
        ["line_width"] = "3"}; 	

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

meas =  {"cm", "cm²", "°"}
dat = {"π", "√2", "√3"}
name = {"P\(\small_o\)", "P\(\small_u\)", "P\(\small_p\)", "P\(\small_i\)"}

numb = {} 
area = {}

root2 = lib.math.round_dec(math.sqrt(2),3)
root3 = lib.math.round_dec(math.sqrt(3),3)	
con = lib.math.round_dec(math.pi, 3)

index = {3, 4, 6, 8, 12}
ch = math.random(5)

numb[1] = 3 + math.random(11)
if (ch == 1) then
	numb[2] = lib.math.round_dec(numb[1] / root3, 3)
	numb[3] = lib.math.round_dec(0.5 * numb[2],3)
end
if (ch == 2) then
	numb[2] = 0.5 * numb[1] * root2
	numb[2] = lib.math.round_dec(numb[2],3)
	numb[3] = 0.5 *	numb[1]
end	
if (ch == 3) then
	numb[2] = numb[1] 	
	numb[3] = 0.5 * numb[1] * root3
	numb[3] = lib.math.round_dec(numb[3],3) 
end	
if (ch == 4) then
	numb[2] = numb[1] / math.sqrt(2-root2)
	numb[2] = lib.math.round_dec(numb[2],3)		
	numb[3] = math.sqrt(numb[2]^2 - 0.25*numb[1]^2) 
	numb[3] = lib.math.round_dec(numb[3],3)			
end	
if (ch == 5) then
	numb[2] = numb[1] / math.sqrt(2-root3) 
	numb[2] = lib.math.round_dec(numb[2],3)	
	numb[3] = math.sqrt(numb[2]^2 - 0.25*numb[1]^2) 
	numb[3] = lib.math.round_dec(numb[3],3)			
end	
area[1] = numb[2] * numb[2] * con
area[2] = numb[3] * numb[3] * con
area[3] = area[1] - area[2]
area[4] = area[1] / index[ch]  	
	
for i = 1,4 do
     area[i] = lib.math.round_dec(area[i] ,1)
end	 

mycanvas = function()
	 		  
  lib.start_canvas(200, 180, "center")   
  
   w = 12
   ow = 9
   v = 3

   if (ch == 1) then  
	  lib.add_curved_path (v+10.6*w, v+w, {{7*w-v, 6*w, 0, 12*w}}, yelowfull_style, false, false)
	  lib.add_straight_path(v+10.6*w, v+w, {{-3.5*w, 6*w}, {3.5*w, 6*w}}, yelowfull_style, false, false) 
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false)	   		  
	  lib.add_circle (v+7*w, v+7*w, 3.4*w, green_style, false, false)   
      lib.add_circle (v+7*w, v+7*w, 2, point_style, false, false) 
      lib.add_straight_path(v, v+7*w, {{10.5*w,-6*w},  {0,12*w}, {-10.5*w,-6*w}}, style, true, false)  
   end 
  
   if (ch == 2) then    
	  lib.add_curved_path (v+2*w, v+2*w, {{5*w, -4*w, 10*w, 0}}, yelowfull_style, false, false)
	  lib.add_straight_path(v+2*w, v+2*w, {{5*w,5*w},  {5*w, -5*w}, {-10*w,0}}, yelowfull_style, true, false)   
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false)
	  lib.add_circle (v+7*w, v+7*w, 4.9*w, green_style, false, false)
      lib.add_circle (v+7*w, v+7*w, 2, point_style, false, false)
      lib.add_straight_path(v+2*w, v+2*w, {{10*w,0}, {0,10*w}, {-10*w,0},  {0,-10*w}}, style, true, false)	
   end  
  
   if (ch == 3) then 
	  lib.add_curved_path (v+3.5*w, v+w, {{4*w, -2*w, 7*w, 0}}, yelowfull_style, false, false)
	  lib.add_straight_path(v+3.5*w, v+w, {{3.5*w, 6*w},  {3.5*w, -6*w}, {-7*w,0}}, yelowfull_style, true, false) 
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false)
	  lib.add_circle (v+7*w, v+7*w, 6*w, green_style, false, false) 
      lib.add_circle (v+7*w, v+7*w, 2, point_style, false, false)	  
      lib.add_straight_path(v, v+7*w, {{3.5*w,-6*w}, {7*w,0}, {3.5*w,6*w}, {-3.5*w,6*w}, {-7*w,0}, {-3.5*w,-6*w}}, style, true, false)      	      
   end  
   if (ch == 4) then 
	  lib.add_curved_path (v+2*w, v+2*w, {{2.5*w, -2*w, 5*w, -2*w}}, yelowfull_style, false, false)
	  lib.add_straight_path(v+2*w, v+2*w, {{5*w, -2*w},  {0, 7*w}, {-5*w,-5*w}}, yelowfull_style, true, false) 
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false)
	  lib.add_circle (v+7*w, v+7*w, 6.4*w, green_style, false, false) 
      lib.add_circle (v+7*w, v+7*w, 2, point_style, false, false)	  	  
      lib.add_straight_path(v+2*w, v+2*w, {{5*w,-2*w}, {5*w,2*w}, {2*w,5*w}, {-2*w,5*w}, {-5*w,2*w}, {-5*w,-2*w}, {-2*w,-5*w}, {2*w,-5*w}}, style, true, false)      
   end  
   if (ch == 5) then 
	  lib.add_curved_path (v+7*w, v, {{0.5*w, -0.25*w, 3.5*w, w}}, yelowfull_style, false, false)
	  lib.add_straight_path(v+7*w, v, {{0, 7*w}, {3.5*w,-6*w}, {-3.5*w,-w}}, yelowfull_style, true, false) 
	  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false)
	  lib.add_circle (v+7*w, v+7*w, 6.7*w, green_style, false, false)
      lib.add_circle (v+7*w, v+7*w, 2, point_style, false, false)	  
      lib.add_straight_path(v, v+7*w, {{0.8*w,-3.3*w}, {2.7*w,-2.7*w}, {3.5*w,-w}, {3.5*w, w}, {2.7*w, 2.7*w}, {0.8*w,3.3*w}, {-0.8*w,3.3*w}, {-2.7*w, 2.7*w}, {-3.5*w, w}, {-3.5*w, -w}, {-2.7*w, -2.7*w}, {-0.8*w,-3.3*w}}, style, true, false)      
   end    

--[[
  for i = 1,15 do
    lib.add_line(v, v+(i-1)*w, 14*w, 0, grid_style, false, false)
  end
  for i = 1,15 do
    lib.add_line(v+(i-1)*w, v, 0, 14*w, grid_style, false, false)
  end
]]--

  lib.end_canvas()
end            
                    