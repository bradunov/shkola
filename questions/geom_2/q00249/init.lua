
yelow_style = 
	{["off_color"] = "ff9",
        ["on_color"] = "ff9",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
green_style = 
	{["off_color"] = "3c3",
        ["on_color"] = "3c3",
        ["line_color"] = "000",
        ["line_width"] = "1"}; 	

grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};	
							
							
meas =  {"cm", "m"}
pi = "π"


diam = {}

fct = 17 + math.random(5)
diam[1] = 4 + math.random(5)
diam[2] = fct * diam[1]
perc = lib.math.round_dec(100/ fct^2,2) 

mycanvas = function()
	 		  
  lib.start_canvas(140, 120, "center")   
  
   w = 8
   ow = 6
   v = 2
    
   lib.add_circle (v+7*w, v+7*w, 7*w, yelow_style, false, false)
   lib.add_circle (v+7*w, v+7*w, 0.5*w, green_style, false, false)
  
   for i = 1, 3 do
       lib.add_circle (v+7*w, v+7*w, 2*i*w, grid_style, false, false)
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
 