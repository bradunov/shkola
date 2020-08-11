
style = 
	{["off_color"] = "000",
        ["on_color"] = "f00",
        ["line_color"] = "f00",
        ["off_line_color"] = "000",
        ["line_width"] = "2"};

diff_style = 
	{["off_color"] = "ff9",
        ["on_color"] = "ff9",
        ["line_color"] = "000",
        ["line_width"] = "1"};
				

ind = math.random(6)

mycanvas = function()

  lib.start_canvas(300, 300, "center", "result[0] == 0 && result[1] == 0 && result[2] == 1")

  w = 100
  ow = 25
  v = 10

  if(ind == 1) then
     lib.add_triangle (ow+w, ow+w, 2*(w-v), 2*(w-v), diff_style, false, false)
     lib.add_line(ow, w-ow+v, 2*w, w+2*ow-v, style, false, true)	
     lib.add_line(ow, ow+w, 2*w+ow, 0, style, false, true)
     lib.add_line(ow+w, ow/2, 0, 2*w+ow, style, false, true)	 
  end

  if(ind == 2) then
     lib.add_circle (ow+w, ow+w, w, diff_style, false, false )
     lib.add_line(2*(w-ow)+5, ow/2, 0, 2*w+ow, style, false, true)
     lib.add_line(ow/2, ow+w, 3*w/2, w, style, false, true) 
     lib.add_line(ow, (w+v)/2, 2*w, w+2*ow-v-2, style, false, true)	 
 end
  
  if(ind == 3) then
     lib.add_rectangle (ow+v, ow+v, 2*(w-v), 2*(w-v), diff_style, false, false)
     lib.add_line(ow, (w+v)/2, 2*w, w+2*ow-v, style, false, true)	
     lib.add_line(w, ow/2, 0, 2*w+ow, style, false, true) 
     lib.add_line(2*w+ow, ow, -2*w, 2*w, style, false, true)	 
  end
  
  if(ind == 4) then  
     lib.add_rectangle (2*ow, 2*ow, 2*w, w+2*ow, diff_style, false, false)  
     lib.add_line(w, ow, w, 2*w, style, false, true)
     lib.add_line(ow, ow+v/2, 2*(w+ow), 2*w-v, style, false, true)	
     lib.add_line(ow, ow+w, 2*(w+ow), 0, style, false, true)	 
  end
  
  if(ind == 5) then  
     lib.add_ellipse(2*ow+w, ow+w, w+ow, (w+ow)/2, diff_style, false, false )
     lib.add_line(2*ow, ow, 2*w, 2*w, style, false, true)
     lib.add_line(ow/2, 2*ow+w+v, 2*(w+ow)+v, -3*ow+v, style, false, true)
     lib.add_line(2*ow+w, ow/2, 0, 2*w+ow, style, false, true)	 
  end

  if(ind == 6) then  
     lib.add_straight_path (ow+w, 2*(ow+w)+ow, {{-3*ow, -w-3*ow}, {3*ow, -3*ow}, { 3*ow, 3*ow}, {-3*ow, w+3*ow} }, diff_style, false, false)
     lib.add_line(ow/2, w, 2*w+ow, 0, style, false, true)
     lib.add_line(ow, 2*ow, 2*w, w+3*ow, style, false, true)
     lib.add_line(ow+w, ow/2, 0, 2*(w+ow)+ow, style, false, true)	 

  end

  lib.end_canvas()
end
    