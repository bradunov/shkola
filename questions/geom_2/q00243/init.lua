
style = 
	{["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};	
		
point_style = {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "1"};		
							
text_style = {["font_size"] = "16"}

grid = 6
ind = math.random(10)

mycanvas = function()
	 		  
  lib.start_canvas(320, 200, "center")   
  
	w = 280/(grid-2)
	ow = 20
	v = 5

	lib.add_text(v+4*w-4*ow, 4*w-10*ow-2*v, "A", text_style, false, false)
	lib.add_text(v+4*w-6*ow, 4*w-9*ow-2*v, "B", text_style, false, false)
	lib.add_text(v+4*w-7*ow, 4*w-11*ow-2*v, "C", text_style, false, false)
	lib.add_text(v+4*w-10*ow, 4*w-11*ow, "D", text_style, false, false)
	
	--[[grid]]--  
	for i = 1,grid do
	lib.add_line(v, v+i*(w-ow), (grid-1)*w, -4*ow, grid_style, false, false)
	end
	lib.add_line(v, v, (grid-1)*w, -4*ow, grid_style, false, false)
	for i = 1,grid do
	lib.add_line(v+(i-1)*w, v, 12*ow, (grid-1)*w, grid_style, false, false)
	end  
	lib.add_line(v-w, v, 12*ow, (grid-1)*w, grid_style, false, false)	

	--[[cube]]-- 
	x = v+4*w-2*ow
	y = 2*v+4*w-7*ow

	lib.add_straight_path(x, y, {{-2*ow+2*v,-2*ow}, {0,-2*ow-2*v-2}, {3*ow,-3*v}, {2*ow-2*v,2*ow}}, style, false, false)  
	lib.add_straight_path(x, y, {{3*ow,-3*v}, {0,-2*ow-2*v}, {-3*ow,3*v}, {0,2*ow+2*v}}, style, false, false) 
	lib.add_straight_path(x, y-2*v-2*ow, {{-2*ow+2*v,-2*ow}}, style, false, false)  

	--[[points]]--

	if (ind == 1) then
	    numb = 4
		lib.add_circle(x+2*v, y-3*v, 5, point_style, false, false)
	    lib.add_circle(x+2*ow-v-2, y-2*ow+v, 5, point_style, false, false)		
	    lib.add_circle(x+2*ow+2*v, y-3*ow+v+2, 5, point_style, false, false)
		   lib.add_circle(x+ow-v, y-4*ow+v, 4, point_style, false, false)
		   lib.add_circle(x-ow-v+2, y-4*ow+2*v+v, 3, point_style, false, false)		
		   lib.add_circle(x-v-2, y-ow-v, 3, point_style, false, false)		   	   
	end		
	if (ind == 2) then
	    numb = 6		
	    lib.add_circle(x+2*ow-v-2, y-2*ow+v, 5, point_style, false, false)	   
		   lib.add_circle(x-v, y-4*ow-v, 4, point_style, false, false)	
		   lib.add_circle(x+ow-v, y-4*ow, 4, point_style, false, false)
		   lib.add_circle(x+2*ow-v, y-4*ow+v, 4, point_style, false, false)
		   lib.add_circle(x-ow-v+2, y-4*ow+2*v+2, 3, point_style, false, false)	
		   lib.add_circle(x-ow-3, y-2*ow-v+3, 3, point_style, false, false)
		   lib.add_circle(x-ow+v, y-2*ow-v, 3, point_style, false, false)
		   lib.add_circle(x-ow+2*v+3, y-2*ow-v-3, 3, point_style, false, false)	
		   lib.add_circle(x-v-2, y-ow-2, 3, point_style, false, false)		   	   
	end	
	if (ind == 3) then
	    numb = 6		
	    lib.add_circle(x+2*ow-v-2, y-2*ow+v, 5, point_style, false, false)
		   lib.add_circle(x-2*v, y-4*ow-v, 4, point_style, false, false)	
		   lib.add_circle(x+ow+v, y-5*ow+v, 4, point_style, false, false)
		   lib.add_circle(x+2*ow, y-4*ow+2+v, 4, point_style, false, false)
		   lib.add_circle(x+v, y-3*ow-v, 4, point_style, false, false)
		   lib.add_circle(x-ow, y-2*ow, 3, point_style, false, false)	
		   lib.add_circle(x-2*v, y-2*ow-2*v, 3, point_style, false, false)	 
	end
	if (ind == 4) then
	    numb = 2
		lib.add_circle(x+2*v, y-2*ow, 5, point_style, false, false)	
		lib.add_circle(x+2*ow+2*v, y-2*ow-2*v, 5, point_style, false, false)
		lib.add_circle(x+ow+2*v, y-2*ow+v+2, 5, point_style, false, false)
		lib.add_circle(x+2*ow+2*v, y-ow-v, 5, point_style, false, false)
		lib.add_circle(x+2*v, y-3*v, 5, point_style, false, false)
			lib.add_circle(x-2*v, y-4*ow-v, 4, point_style, false, false)	
			lib.add_circle(x+ow+v, y-5*ow+v, 4, point_style, false, false)
			lib.add_circle(x+2*ow, y-4*ow+2+v, 4, point_style, false, false)
			lib.add_circle(x+v, y-3*ow-v, 4, point_style, false, false)		
			lib.add_circle(x-ow+3, y-2*ow-v, 3, point_style, false, false)		
	end		
	if (ind == 5) then
	    numb = 5		
	    lib.add_circle(x+3*v-2, y-2*ow-2, 5, point_style, false, false)	    
            lib.add_circle(x+2*ow+v+2, y-ow-v-2, 5, point_style, false, false)	
			lib.add_circle(x+ow-v, y-4*ow, 4, point_style, false, false)
			lib.add_circle(x-ow-2, y-3*ow-v, 3, point_style, false, false)
			lib.add_circle(x-ow-2, y-2*ow, 3, point_style, false, false)	
			lib.add_circle(x-2*v, y-2*ow-2*v, 3, point_style, false, false)
			lib.add_circle(x-2*v, y-ow-v, 3, point_style, false, false)		
	end	
	if (ind == 6) then
	    numb = 6		
	    lib.add_circle(x+2*ow-v-2, y-2*ow+v, 5, point_style, false, false)
		   lib.add_circle(x-v, y-4*ow-v, 4, point_style, false, false)	
		   lib.add_circle(x+2*ow-v, y-4*ow+v, 4, point_style, false, false)
		   lib.add_circle(x-ow-v+2, y-4*ow+2*v+2, 3, point_style, false, false)	
		   lib.add_circle(x-ow+v, y-2*ow-v, 3, point_style, false, false)	
		   lib.add_circle(x-v-2, y-ow-2, 3, point_style, false, false)		   	   
	end	
	if (ind == 7) then
	    numb = 3		
	    lib.add_circle(x+2*v+3, y-2*ow, 5, point_style, false, false)	
	    lib.add_circle(x+2*ow+v, y-2*ow-2*v, 5, point_style, false, false)
	    lib.add_circle(x+2*ow+v+2, y-ow-3, 5, point_style, false, false)
	    lib.add_circle(x+2*v+3, y-2*v-3, 5, point_style, false, false)
		   lib.add_circle(x-2*v, y-4*ow-v, 4, point_style, false, false)	
		   lib.add_circle(x+ow-2*v-2, y-4*ow-2*v, 4, point_style, false, false)
		   lib.add_circle(x+ow+v, y-5*ow+v, 4, point_style, false, false)
		   lib.add_circle(x+2*ow, y-4*ow+2+v, 4, point_style, false, false)
		   lib.add_circle(x+ow+v-2, y-3*ow-2*v, 4, point_style, false, false)
		   lib.add_circle(x+v, y-3*ow-v, 4, point_style, false, false)
		   lib.add_circle(x-ow, y-3*ow-2, 3, point_style, false, false)	
		   lib.add_circle(x-2*v, y-ow-v-2, 3, point_style, false, false)	
	end	
	if (ind == 8) then
	    numb = 6		
	    lib.add_circle(x+2*ow-v-2, y-2*ow+v, 5, point_style, false, false)	
			lib.add_circle(x-2*v, y-4*ow-v, 4, point_style, false, false)	
			lib.add_circle(x+ow+v, y-5*ow+v, 4, point_style, false, false)
			lib.add_circle(x+ow-v, y-4*ow, 4, point_style, false, false)
			lib.add_circle(x+2*ow, y-4*ow+2+v, 4, point_style, false, false)
			lib.add_circle(x+v, y-3*ow-v, 4, point_style, false, false)
			lib.add_circle(x-ow-2, y-3*ow-v, 3, point_style, false, false)			
			lib.add_circle(x-2*v, y-2*ow-2*v, 3, point_style, false, false)
			lib.add_circle(x-2*v, y-ow-v, 3, point_style, false, false)
			lib.add_circle(x-ow-2, y-2*ow-2, 3, point_style, false, false)			
	end	
	if (ind == 9) then
	    numb = 3
		lib.add_circle(x+2*v+2, y-2*ow, 5, point_style, false, false)	
		lib.add_circle(x+2*ow+2*v-2, y-2*ow-2*v, 5, point_style, false, false)
		lib.add_circle(x+2*ow+2*v-2, y-ow-v, 5, point_style, false, false)
		lib.add_circle(x+2*v+2, y-3*v, 5, point_style, false, false)	
			lib.add_circle(x+ow+v, y-5*ow+v, 4, point_style, false, false)
			lib.add_circle(x+v, y-3*ow-v, 4, point_style, false, false)		
			lib.add_circle(x-ow+3, y-2*ow-v, 3, point_style, false, false)		
	end	
	if (ind == 10) then
	    numb = 5
		lib.add_circle(x+2*v+2, y-2*ow, 5, point_style, false, false)
		lib.add_circle(x+2*ow+v+3, y-ow-v, 5, point_style, false, false)
			lib.add_circle(x-2*v, y-4*ow-v, 4, point_style, false, false)	
			lib.add_circle(x+ow+v, y-5*ow+v, 4, point_style, false, false)
			lib.add_circle(x-2, y-4*ow+4, 4, point_style, false, false)	
			lib.add_circle(x+2*ow-v-2, y-4*ow-v, 4, point_style, false, false)
			lib.add_circle(x+2*ow, y-4*ow+2+v, 4, point_style, false, false)
			lib.add_circle(x+v, y-3*ow-v, 4, point_style, false, false)
			lib.add_circle(x-ow-v+2, y-3*ow-v, 3, point_style, false, false)			
			lib.add_circle(x-ow+v, y-2*ow-v, 3, point_style, false, false)		
			lib.add_circle(x-v-2, y-ow-3, 3, point_style, false, false)		
	end			
	
  lib.end_canvas()
end         
                   