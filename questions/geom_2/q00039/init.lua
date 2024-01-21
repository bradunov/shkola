
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.1"};
		
line_style = 
	{["off_color"] = "000",
        ["on_color"] = "f00",
        ["line_color"] = "f00",
        ["off_line_color"] = "000",
        ["line_width"] = "3"};

diff_style = 
	{["off_color"] = "ff9",
        ["on_color"] = "ff9",
        ["line_color"] = "000",
        ["line_width"] = "2"};
				

ind = math.random(6)

mycanvas = function()

  lib.start_canvas(300, 300, "center", "result[0] == 0 && result[1] == 0 && result[2] == 1")

  w = 100
  ow = 25
  v = 10

  if(ind == 1) then
     lib.add_triangle (v+ow+w, 2*ow+w-3, 2*w-ow, 2*w-ow, diff_style, false, false)
     lib.add_line(v+ow, w+v, 2*w, w+ow+v, line_style, false, true)	
     lib.add_line(ow, 2*ow+w-2, 2*w+ow, 0, line_style, false, true)
     lib.add_line(v+ow+w, ow/2, 0, 2*(w+ow), line_style, false, true)	 
  end

  if(ind == 2) then

     lib.add_triangle(v+2*ow+w, w+2*ow-3, w, 2*w-ow, diff_style, false, false)
     lib.add_circle (v+2*ow+w, v+2*ow, ow, diff_style, false, false )
     lib.add_line(w-ow, v+ow, w+2*ow, 2*w+ow, line_style, false, true) 
     lib.add_line(v+2*ow, v+3*ow, 2*w, 0, line_style, false, true)	
     lib.add_line(2*(w-ow)+v, ow, 0, 2*(w+ow), line_style, false, true) 
 end
  
  if(ind == 3) then
     lib.add_straight_path (v+3*ow, v+3*ow, {{w, 0}, {2*ow, 4*ow}, { -2*w, 0}, {2*ow, -4*ow} }, diff_style, false, false)
     lib.add_line(v+ow, w+v+ow, 2*w, 0, line_style, false, true)	
     lib.add_line(2*w+ow, 2*ow+7, -2*w, w+2*ow-v-3, line_style, false, true)
     lib.add_line(v+ow+w, ow, 0, 2*w+ow, line_style, false, true) 	 
  end
  
  if(ind == 4) then  
     lib.add_rectangle (v+2*ow, v+2*ow, 2*w, w+2*ow, diff_style, false, false)  
     lib.add_line(w, ow, w+v, 2*w, line_style, false, true)
     lib.add_line(ow, ow+v, 2*(w+ow), 2*w-v-3, line_style, false, true)	
     lib.add_line(ow, v+ow+w, 2*(w+ow), 0, line_style, false, true)	 
  end
  
  if(ind == 5) then  
     lib.add_ellipse(v+2*ow+w, v+ow+w, 4*ow, 2*ow, diff_style, false, false )
     lib.add_line(v+2*ow, v+ow, 2*w, 2*w, line_style, false, true)
     lib.add_line(v+ow/2, 2*ow+w+2*v, 2*(w+ow)+v, -3*ow+v, line_style, false, true)
     lib.add_line(v+2*ow+w, ow/2, 0, 2*w+ow, line_style, false, true)	 
  end

  if(ind == 6) then  
     lib.add_straight_path (v+ow+w, 2*(ow+w)+ow, {{-3*ow, -w-3*ow+v}, {3*ow, -3*ow}, { 3*ow, 3*ow}, {-3*ow, w+3*ow-v} }, diff_style, false, false)
     lib.add_line(ow/2, w+v, 2*w+ow, 0, line_style, false, true)
     lib.add_line(3*ow+v, 2*ow, w+ow-v, w+3*ow, line_style, false, true)
     lib.add_line(v+ow+w, ow/2, 0, 2*w+3*ow, line_style, false, true)	 
  end

--[[
  for i = 1,12 do
    lib.add_line(v, v+(i-1)*ow, 11*ow, 0, style, false, false)
  end

  for i = 1,12 do
    lib.add_line(v+(i-1)*ow, v, 0, 11*ow, style, false, false)
  end
]]--  
  lib.end_canvas()
end