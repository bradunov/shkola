
include("names")

r = math.random(#zensko_ime_nom)
name = zensko_ime_nom[r]

style = 
	{["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};	
		
red_style = {["off_color"] = "f00",
        ["on_color"] = "f00",
        ["line_color"] = "000",
        ["line_width"] = "1"};		
							
text_style = {["font_size"] = "16"}

meas = "cm³"
grid = 6
ind = math.random(11)
 
total = 18
numb = 1 + math.random(3)

mycanvas = function()
	 		  
  lib.start_canvas(280, 240, "center")   
  
	w = 220/(grid-2)
	ow = 16
	v = 4

--[[grid  
	for i = 1,grid do
	lib.add_line(v, v+i*(w-ow-v), (grid-1)*w, -4*ow, grid_style, false, false)
	end
	lib.add_line(v, v, (grid-1)*w, -4*ow, grid_style, false, false)
	for i = 1,grid+1 do
	lib.add_line(v+(i-1)*(w-2*v), v, 12*ow, (grid-1)*w, grid_style, false, false)
	end  
	lib.add_line(v-w, v, 12*ow, (grid-1)*w, grid_style, false, false)	
]]--

	shx = 3*ow
	shy = 3*v
	
if (ind == 1) then
shape = total - 1 
tower = numb * shape	
	for l = 1,2 do
		for k = 1,3 do
			xb = 4*w - (4-k)*3/2*ow 
			yb = 4*w-(5+2*l-2*k)*ow-l*v
	--[[nivo l, red=3-k]]--	
			for i = 1,3 do
				x = xb - (i-1)*shx
				y = yb + (i-1)*shy
				if (l == 1 and k == 3 and i == 3) then
				else				
					lib.add_straight_path(x, y, {{3*ow,-3*v}, {0,-2*ow-2*v}, {-3*ow,3*v}, {0,2*ow+2*v}}, style, false, false)  
					lib.add_straight_path(x, y, {{-2*ow+2*v,-2*ow}, {0,-2*ow-2*v-2}, {2*ow-2*v,2*ow}, {0,2*ow+2*v+2}}, style, false, false)  
					lib.add_straight_path(x, y-2*v-2*ow, {{-2*ow+2*v,-2*ow}, {3*ow,-3*v}, {2*ow-2*v,2*ow}, {-3*ow,3*v}}, style, false, false)			   
				end
			end									
		end
	end
end

if (ind == 2) then
shape = total - 2 
tower = numb * shape	
	for l = 1,2 do
		for k = 1,3 do
			xb = 4*w - (4-k)*3/2*ow 
			yb = 4*w-(5+2*l-2*k)*ow-l*v
	--[[nivo l, red=3-k]]--	
			for i = 1,3 do
				x = xb - (i-1)*shx
				y = yb + (i-1)*shy
				if (k == 3 and i == 3) then
				else				
					lib.add_straight_path(x, y, {{3*ow,-3*v}, {0,-2*ow-2*v}, {-3*ow,3*v}, {0,2*ow+2*v}}, style, false, false)  
					lib.add_straight_path(x, y, {{-2*ow+2*v,-2*ow}, {0,-2*ow-2*v-2}, {2*ow-2*v,2*ow}, {0,2*ow+2*v+2}}, style, false, false)  
					lib.add_straight_path(x, y-2*v-2*ow, {{-2*ow+2*v,-2*ow}, {3*ow,-3*v}, {2*ow-2*v,2*ow}, {-3*ow,3*v}}, style, false, false)			   
				end
			end									
		end
	end
end

if (ind == 3) then
shape = total - 3 
tower = numb * shape		
	for l = 1,2 do
		for k = 1,3 do
			xb = 4*w - (4-k)*3/2*ow 
			yb = 4*w-(5+2*l-2*k)*ow-l*v
	--[[nivo l, red=3-k]]--	
			for i = 1,3 do
				x = xb - (i-1)*shx
				y = yb + (i-1)*shy
				if ((l == 2  and k == 2 and i == 3) or (k == 3 and i == 3)) then
				else				
					lib.add_straight_path(x, y, {{3*ow,-3*v}, {0,-2*ow-2*v}, {-3*ow,3*v}, {0,2*ow+2*v}}, style, false, false)  
					lib.add_straight_path(x, y, {{-2*ow+2*v,-2*ow}, {0,-2*ow-2*v-2}, {2*ow-2*v,2*ow}, {0,2*ow+2*v+2}}, style, false, false)  
					lib.add_straight_path(x, y-2*v-2*ow, {{-2*ow+2*v,-2*ow}, {3*ow,-3*v}, {2*ow-2*v,2*ow}, {-3*ow,3*v}}, style, false, false)			   
				end
			end									
		end
	end
end

if (ind == 4) then
shape = total - 4 
tower = numb * shape	
	for l = 1,2 do
		for k = 1,3 do
			xb = 4*w - (4-k)*3/2*ow 
			yb = 4*w-(5+2*l-2*k)*ow-l*v
	--[[nivo l, red=3-k]]--	
			for i = 1,3 do
				x = xb - (i-1)*shx
				y = yb + (i-1)*shy
				if (k > 1 and i == 3) then
				else				
					lib.add_straight_path(x, y, {{3*ow,-3*v}, {0,-2*ow-2*v}, {-3*ow,3*v}, {0,2*ow+2*v}}, style, false, false)  
					lib.add_straight_path(x, y, {{-2*ow+2*v,-2*ow}, {0,-2*ow-2*v-2}, {2*ow-2*v,2*ow}, {0,2*ow+2*v+2}}, style, false, false)  
					lib.add_straight_path(x, y-2*v-2*ow, {{-2*ow+2*v,-2*ow}, {3*ow,-3*v}, {2*ow-2*v,2*ow}, {-3*ow,3*v}}, style, false, false)			   
				end
			end									
		end
	end
end

if (ind == 5) then
shape = total - 2 
tower = numb * shape		
	for l = 1,2 do
		for k = 1,3 do
			xb = 4*w - (4-k)*3/2*ow 
			yb = 4*w-(5+2*l-2*k)*ow-l*v
	--[[nivo l, red=3-k]]--	
			for i = 1,3 do
				x = xb - (i-1)*shx
				y = yb + (i-1)*shy
				if (k == 2 and i == 3) then
				else				
					lib.add_straight_path(x, y, {{3*ow,-3*v}, {0,-2*ow-2*v}, {-3*ow,3*v}, {0,2*ow+2*v}}, style, false, false)  
					lib.add_straight_path(x, y, {{-2*ow+2*v,-2*ow}, {0,-2*ow-2*v-2}, {2*ow-2*v,2*ow}, {0,2*ow+2*v+2}}, style, false, false)  
					lib.add_straight_path(x, y-2*v-2*ow, {{-2*ow+2*v,-2*ow}, {3*ow,-3*v}, {2*ow-2*v,2*ow}, {-3*ow,3*v}}, style, false, false)			   
				end
			end									
		end
	end
end

if (ind == 6) then
shape = total - 4 
tower = numb * shape		
	for l = 1,2 do
		for k = 1,3 do
			xb = 4*w - (4-k)*3/2*ow 
			yb = 4*w-(5+2*l-2*k)*ow-l*v
	--[[nivo l, red=3-k]]--	
			for i = 1,3 do
				x = xb - (i-1)*shx
				y = yb + (i-1)*shy
				if ((k == 1 and i == 3) or (l == 2 and k == 3 and i > 1)) then
				else				
					lib.add_straight_path(x, y, {{3*ow,-3*v}, {0,-2*ow-2*v}, {-3*ow,3*v}, {0,2*ow+2*v}}, style, false, false)  
					lib.add_straight_path(x, y, {{-2*ow+2*v,-2*ow}, {0,-2*ow-2*v-2}, {2*ow-2*v,2*ow}, {0,2*ow+2*v+2}}, style, false, false)  
					lib.add_straight_path(x, y-2*v-2*ow, {{-2*ow+2*v,-2*ow}, {3*ow,-3*v}, {2*ow-2*v,2*ow}, {-3*ow,3*v}}, style, false, false)			   
				end
			end									
		end
	end
end
	
if (ind == 7) then
shape = total - 8 
tower = numb * shape	
	for l = 1,2 do
		for k = 1,3 do
			xb = 4*w - (4-k)*3/2*ow 
			yb = 4*w-(5+2*l-2*k)*ow-l*v
	--[[nivo l, red=3-k]]--	
			for i = 1,3 do
				x = xb - (i-1)*shx
				y = yb + (i-1)*shy
				if ((k == 2 and (i == 1 or i == 3)) or (i == 2 and (k == 1 or k == 3))) then
				else				
					lib.add_straight_path(x, y, {{3*ow,-3*v}, {0,-2*ow-2*v}, {-3*ow,3*v}, {0,2*ow+2*v}}, style, false, false)  
					lib.add_straight_path(x, y, {{-2*ow+2*v,-2*ow}, {0,-2*ow-2*v-2}, {2*ow-2*v,2*ow}, {0,2*ow+2*v+2}}, style, false, false)  
					lib.add_straight_path(x, y-2*v-2*ow, {{-2*ow+2*v,-2*ow}, {3*ow,-3*v}, {2*ow-2*v,2*ow}, {-3*ow,3*v}}, style, false, false)			   
				end
			end									
		end
	end
end	

if (ind == 8) then
shape = total - 8 
tower = numb * shape	
	for l = 1,2 do
		for k = 1,3 do
			xb = 4*w - (4-k)*3/2*ow 
			yb = 4*w-(5+2*l-2*k)*ow-l*v
	--[[nivo l, red=3-k]]--	
			for i = 1,3 do
				x = xb - (i-1)*shx
				y = yb + (i-1)*shy
				if (k > 1 and i > 1) then
				else				
					lib.add_straight_path(x, y, {{3*ow,-3*v}, {0,-2*ow-2*v}, {-3*ow,3*v}, {0,2*ow+2*v}}, style, false, false)  
					lib.add_straight_path(x, y, {{-2*ow+2*v,-2*ow}, {0,-2*ow-2*v-2}, {2*ow-2*v,2*ow}, {0,2*ow+2*v+2}}, style, false, false)  
					lib.add_straight_path(x, y-2*v-2*ow, {{-2*ow+2*v,-2*ow}, {3*ow,-3*v}, {2*ow-2*v,2*ow}, {-3*ow,3*v}}, style, false, false)			   
				end
			end									
		end
	end
end	

if (ind == 9) then
shape = total - 3 
tower = numb * shape	
	for l = 1,2 do
		for k = 1,3 do
			xb = 4*w - (4-k)*3/2*ow 
			yb = 4*w-(5+2*l-2*k)*ow-l*v
	--[[nivo l, red=3-k]]--	
			for i = 1,3 do
				x = xb - (i-1)*shx
				y = yb + (i-1)*shy
				if ((l == 2 and k == 3 and i == 3) or (l == 2  and k == 2 and i == 3) or (l == 2  and k == 3 and i == 2)) then
				else				
					lib.add_straight_path(x, y, {{3*ow,-3*v}, {0,-2*ow-2*v}, {-3*ow,3*v}, {0,2*ow+2*v}}, style, false, false)  
					lib.add_straight_path(x, y, {{-2*ow+2*v,-2*ow}, {0,-2*ow-2*v-2}, {2*ow-2*v,2*ow}, {0,2*ow+2*v+2}}, style, false, false)  
					lib.add_straight_path(x, y-2*v-2*ow, {{-2*ow+2*v,-2*ow}, {3*ow,-3*v}, {2*ow-2*v,2*ow}, {-3*ow,3*v}}, style, false, false)			   
				end
			end									
		end
	end
end

if (ind == 10) then
shape = total - 4 
tower = numb * shape	
	for l = 1,2 do
		for k = 1,3 do
			xb = 4*w - (4-k)*3/2*ow 
			yb = 4*w-(5+2*l-2*k)*ow-l*v
	--[[nivo l, red=3-k]]--	
			for i = 1,3 do
				x = xb - (i-1)*shx
				y = yb + (i-1)*shy
				if ((l == 1 and k == 3 and i == 3) or (l == 2 and k == 3 and i == 3) or (l == 2  and k == 2 and i == 3) or (l == 2  and k == 3 and i == 2)) then
				else				
					lib.add_straight_path(x, y, {{3*ow,-3*v}, {0,-2*ow-2*v}, {-3*ow,3*v}, {0,2*ow+2*v}}, style, false, false)  
					lib.add_straight_path(x, y, {{-2*ow+2*v,-2*ow}, {0,-2*ow-2*v-2}, {2*ow-2*v,2*ow}, {0,2*ow+2*v+2}}, style, false, false)  
					lib.add_straight_path(x, y-2*v-2*ow, {{-2*ow+2*v,-2*ow}, {3*ow,-3*v}, {2*ow-2*v,2*ow}, {-3*ow,3*v}}, style, false, false)			   
				end
			end									
		end
	end
end

if (ind == 11) then
shape = total - 4 
tower = numb * shape	
	for l = 1,2 do
		for k = 1,3 do
			xb = 4*w - (4-k)*3/2*ow 
			yb = 4*w-(5+2*l-2*k)*ow-l*v
	--[[nivo l, red=3-k]]--	
			for i = 1,3 do
				x = xb - (i-1)*shx
				y = yb + (i-1)*shy
				if (l == 2 and ((k == 2 and (i == 1 or i == 3)) or (i == 2 and (k == 1 or k == 3)))) then
				else				
					lib.add_straight_path(x, y, {{3*ow,-3*v}, {0,-2*ow-2*v}, {-3*ow,3*v}, {0,2*ow+2*v}}, style, false, false)  
					lib.add_straight_path(x, y, {{-2*ow+2*v,-2*ow}, {0,-2*ow-2*v-2}, {2*ow-2*v,2*ow}, {0,2*ow+2*v+2}}, style, false, false)  
					lib.add_straight_path(x, y-2*v-2*ow, {{-2*ow+2*v,-2*ow}, {3*ow,-3*v}, {2*ow-2*v,2*ow}, {-3*ow,3*v}}, style, false, false)			   
				end
			end									
		end
	end
end	
		
  lib.end_canvas()
end          
            