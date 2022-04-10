
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
green_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
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

meas =  {"cm", "cm\(\small^2\)", "\(\small^\circ\)"}
dat = {"π", "√2", "√3"}

numb = {}

root2 = lib.math.round_dec(math.sqrt(2),3)
root3 = lib.math.round_dec(math.sqrt(3),3)	
con = lib.math.round_dec(math.pi, 3)

ind = math.random(3)
ch = math.random(3+ind)
	
numb[1] = 3 + math.random(15)
if (ind == 1) then
	numb[2] = lib.math.round_dec(numb[1] / root3, 3)
	numb[3] = lib.math.round_dec(0.5 *	numb[2],3)
    if (ch == 1) then 
        value = 0.25 * numb[1] * numb[1] * (root3 - 0.5*con) 
    end	
    if (ch == 2) then 
        value = numb[1] * numb[1] * (con/3 - 0.25*root3)/3  
    end	
    if (ch == 3) then 
        value = numb[1] * numb[1] * con /12
    end	
    if (ch == 4) then 
        value = numb[1] * numb[1] * (con/6 + 0.25 * root3) / 6
    end		
end
if (ind == 2) then
	numb[2] = numb[1] 	
	numb[3] = 0.5 * numb[1] * root3
	numb[3] = lib.math.round_dec(numb[3],3) 
    if (ch == 1) then 
        value = numb[1] * numb[1] * (2*con - 3*root3) / 12
    end	
    if (ch == 2) then 
        value = numb[1] * numb[1] * (2*root3 - con) / 8
    end	
    if (ch == 3) then 
        value = numb[1] * numb[1] * con /24
    end
    if (ch == 4) then 
        value = numb[1] * numb[1] * (3*root3 - con) /24
    end	
    if (ch == 5) then 
        value = 1.5 * numb[1] * numb[1] * (root3 - con/3) 
    end		
end	
if (ind == 3) then
	numb[2] = 0.5 * numb[1] * root2
	numb[2] = lib.math.round_dec(numb[2],3)
	numb[3] = 0.5 *	numb[1]
    if (ch == 1) then 
        value = 0.25 * numb[1] * numb[1] * (0.5*con -1)  
    end	
    if (ch == 2) then 
        value = 0.25 * numb[1] * numb[1] * (1 - 0.25*con)  
    end	
    if (ch == 3) then 
        value = numb[1] * numb[1] * con / 16
    end	
    if (ch == 4) then 
        value = numb[1] * numb[1] / 8
    end	
    if (ch == 5) then 
        value = numb[1] * numb[1] * (1 - 0.25*con)
    end	
    if (ch == 6) then 
        value = 0.5 * numb[1] * numb[1] 
    end		
end	

area = lib.math.round_dec(value,1)

mycanvas = function()
	 		  
  lib.start_canvas(180, 180, "center")   
  
   w = 12
   ow = 9
   v = 3

   if (ind == 1) then  
      if (ch == 1) then   --[[prsten izmedju dva kruga, ova slika]]--
         lib.add_straight_path(v, v+7*w, {{10.5*w,-6*w},  {0,12*w}, {-10.5*w,-6*w}}, yelowfull_style, true, false) 
		  lib.add_circle (v+2, v+7*w, 6*w, green_style, false, false)
		  lib.add_circle (v+10.7*w, v+w, 6*w, green_style, false, false)
		  lib.add_circle (v+10.7*w, v+13*w, 6*w, green_style, false, false)	   
      end 
      if (ch == 2) then   --[[kalota nad stranicom]]--
          lib.add_curved_path (v+10.7*w, v+w, {{7*w-v, 6*w, 0, 12*w}}, yelowfull_style, false, false)
		  lib.add_line(v+10.6*w, v+w, 0, 12*w, yelowfull_style, false, false) 
		  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false)	  
      end 	  
      if (ch == 3) then    --[[deo prstena izmedju poluprecnika]]--
          lib.add_curved_path (v+3.9*w, v+0.8*w, {{8*w+2*v, -2*w-ow-v/2, 10.1*w, 6.2*w}}, yelowfull_style, false, false)
          lib.add_straight_path(v+3.9*w, v+0.8*w, {{10*w,6.2*w},  {-4*w, 0}, {-4.5*w,-3.1*w}, {-1.4*w,-3.1*w}}, yelowfull_style, true, false)  
		  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false)	  		  
		  lib.add_circle (v+7*w, v+7*w, 3.4*w, green_style, false, false)
      end    
      if (ch == 4) then    --[[deo prstena izmedju precnika]]-- 
          lib.add_curved_path (v+10.5*w, v+1.2*w, {{2*w+2*v, w-2*v, 3.5*w, 5.8*w}}, yelowfull_style, false, false)
          lib.add_straight_path(v+5.5*w, v+4*w, {{5*w,-3*w},  {3.4*w, 6*w}, {-3.5*w,0}, {-5.3*w,-3*w}}, yelowfull_style, true, false)   
		  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false)	  
		  lib.add_circle (v+7*w, v+7*w, 3.4*w, green_style, false, false)	  
      end     		  
      lib.add_circle (v+7*w, v+7*w, 2, point_style, false, false) 
      lib.add_straight_path(v, v+7*w, {{10.5*w,-6*w},  {0,12*w}, {-10.5*w,-6*w}}, style, true, false)  
   end 
  
   if (ind == 2) then 
      if (ch == 1) then   --[[kalota nad stranicom i opisanim krugom]]--
          lib.add_curved_path (v+3.5*w, v+w, {{2.5*w, -2*w, 7*w, 0}}, yelowfull_style, false, false)
	      lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false)
      end    
      if (ch == 2) then   --[[ugao izmedju  dve stranice i upisanim krugom]]--
          lib.add_straight_path(v+2*w, v+3.6*w, {{1.5*w,-2.6*w},  {3.5*w, 0}, {-5*w,2.5*w}}, yelowfull_style, true, false)
	      lib.add_circle (v+7*w, v+7*w, 6*w, green_style, false, false)
      end     
      if (ch == 3) then    --[[deo prstena izmedju poluprecnika]]--
         lib.add_curved_path (v+3.5*w, v+w, {{4*w, -2*w, 7*w, 0}}, yelowfull_style, false, false)
          lib.add_straight_path(v+3.5*w, v+w, {{7*w,0},  {-1.5*w, 2*w}, {-4*w,0}, {-1.5*w, -2*w}}, yelowfull_style, true, false) 
	      lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false)
	      lib.add_circle (v+7*w, v+7*w, 6*w, green_style, false, false)
      end  
      if (ch == 4) then    --[[deo prstena izmedju stranice i poluprecnika]]--
          lib.add_curved_path (v+3.5*w, v+w, {{1.5*w, -w, 3.5*w, -w}}, yelowfull_style, false, false)
          lib.add_straight_path(v+2.1*w, v+3.5*w, {{1.5*w,-2.5*w},  {3.5*w, -w}, {0,w}, {-5*w,2.5*w}}, yelowfull_style, true, false)   
	      lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false)
	      lib.add_circle (v+7*w, v+7*w, 6*w, green_style, false, false)
      end  
      if (ch == 5) then  
      lib.add_straight_path(v, v+7*w, {{3.5*w,-6*w}, {7*w,0}, {3.5*w,6*w}, {-3.5*w,6*w}, {-7*w,0}, {-3.5*w,-6*w}}, yelowfull_style, true, false) 
		  lib.add_circle (v+3.5*w, v+w, 3.5*w, green_style, false, false)
		  lib.add_circle (v+10.5*w, v+w, 3.5*w, green_style, false, false)
		  lib.add_circle (v+3.5*w, v+13*w, 3.5*w, green_style, false, false)
		  lib.add_circle (v+10.5*w, v+13*w, 3.5*w, green_style, false, false)
		  lib.add_circle (v, v+7*w, 3.5*w, green_style, false, false)
		  lib.add_circle (v+14*w, v+7*w, 3.5*w, green_style, false, false)	   
      end 	  
      lib.add_circle (v+7*w, v+7*w, 2, point_style, false, false)	  
      lib.add_straight_path(v, v+7*w, {{3.5*w,-6*w}, {7*w,0}, {3.5*w,6*w}, {-3.5*w,6*w}, {-7*w,0}, {-3.5*w,-6*w}}, style, true, false)      	 
   end  

  if (ind == 3) then    
      if (ch == 1) then   --[[kalota nad stranicom i opisanim krugom]]--
          lib.add_curved_path (v+2*w, v+2*w, {{5*w, -4*w, 10*w, 0}}, yelowfull_style, false, false)
		  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false)
      end    
      if (ch == 2) then   --[[ugao izmedju  dve stranice i upisanim krugom]]--
          lib.add_straight_path(v+2*w, v+7*w, {{0,-5*w},  {5*w, 0}, {-5*w,5*w}}, yelowfull_style, true, false)
	  	  lib.add_circle (v+7*w, v+7*w, 4.9*w, green_style, false, false)
      end     
      if (ch == 3) then    --[[deo prstena izmedju poluprecnika]]--
          lib.add_curved_path (v+2*w, v+2*w, {{5*w, -4*w, 10*w, 0}}, yelowfull_style, false, false)
          lib.add_straight_path(v+2*w, v+2*w, {{10*w,0},  {-2*w, 2*w}, {-6*w,0}, {-2*w,-2*w}}, yelowfull_style, true, false)   
		  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false)
	  	  lib.add_circle (v+7*w, v+7*w, 4.9*w, green_style, false, false)
      end  
      if (ch == 4) then    --[[deo prstena izmedju stranice i poluprecnika]]--
          lib.add_curved_path (v+2*w, v+2*w, {{3*w, -2*w, 5*w, -2*w}}, yelowfull_style, false, false)
          lib.add_straight_path(v+2*w, v+7*w, {{0,-5*w},  {5*w, -2*w}, {0,2*w}, {-5*w,5*w}}, yelowfull_style, true, false)   
		  lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false)
	  	  lib.add_circle (v+7*w, v+7*w, 4.9*w, green_style, false, false)
      end 
      if (ch == 5) then 
		  lib.add_straight_path(v+2*w, v+2*w, {{10*w,0}, {0,10*w}, {-10*w,0},  {0,-10*w}}, yelowfull_style, true, false)	 
		  lib.add_circle (v+2*w, v+2*w, 4.9*w, green_style, false, false)
		  lib.add_circle (v+2*w, v+12*w, 4.9*w, green_style, false, false)
		  lib.add_circle (v+12*w, v+2*w, 4.9*w, green_style, false, false)
		  lib.add_circle (v+12*w, v+12*w, 4.9*w, green_style, false, false)
      end 
      if (ch == 6) then  
		  lib.add_circle (v+7*w, v+7*w, 4.9*w, yelowfull_style, false, false)
		  lib.add_circle (v+2*w, v+12*w, 4.9*w, green_style, false, false)
		  lib.add_circle (v+12*w, v+12*w, 4.9*w, green_style, false, false)
      end     	  
      lib.add_circle (v+7*w, v+7*w, 2, point_style, false, false)
      lib.add_straight_path(v+2*w, v+2*w, {{10*w,0}, {0,10*w}, {-10*w,0},  {0,-10*w}}, style, true, false)	
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
          
          
            