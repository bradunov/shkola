
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "00f",
        ["line_width"] = "2"};

diff_style = 
	{["off_color"] = "faf",
        ["on_color"] = "faf",
        ["line_color"] = "faf",
        ["line_width"] = "2"};
		
marker_style = 
	{["off_color"] = "fff",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};		

text_style = {["font_size"] = "16"}

include("shapes")

ind = math.random(9)

if (ind == 1 or ind == 5 or ind == 8) then
results = "result[0] == 0 && result[1] == 1 && result[2] == 0 && result[3] == 0"
end

if (ind == 2 or ind == 3 or ind == 6 or ind == 9) then
results = "result[0] == 1 && result[1] == 1 && result[2] == 1 && result[3] == 1"
end

if (ind == 4 or ind == 7) then
results = "result[0] == 1 && result[1] == 1 && result[2] == 0 && result[3] == 0"
end

mycanvas = function()

  lib.start_canvas(280, 320, "center", results)

  w = 100
  ow = 25
  v = 10

  scale = 5

  if(ind == 1) then
     lib.add_triangle (ow+w, ow+w, 2*(w-v), 2*(w-v), diff_style, false, false)	
  end

  if(ind == 2) then
     lib.add_circle (ow+w, ow+w, w, diff_style, false, false )	 
 end
  
  if(ind == 3) then
     lib.add_rectangle (ow+v, ow+v, 2*(w-v), 2*(w-v), diff_style, false, false)
  end
  
  if(ind == 4) then  
     lib.add_rectangle (ow, ow+ow, 2*w, w+2*ow, diff_style, false, false)  
  end
  
  if(ind == 5) then  
     heart(lib, ow+w, ow+2*w, scale, diff_style, false, false)	 
  end

  if(ind == 6) then
     cross(lib, ow, w, scale, diff_style, false, false)
  end

  if(ind == 7) then  
     lib.add_ellipse(ow+w, ow+w, w, w/2, diff_style, false, false)
  end
  
  if(ind == 8) then  
     leaf(lib, ow+w, ow, 4, diff_style, false, false)	 
  end
  
  if(ind == 9) then  
     diamond(lib, ow, ow+w, scale, diff_style, false, false)
  end

 --[[  ose  ]]--
  lib.add_line(ow+w, ow/2, 0, 2*w+ow, style, false, false)
  lib.add_line(ow/2, ow+w, 2*w+ow, 0, style, false, false)
  lib.add_line(ow, ow, 2*w, 2*w, style, false, false)
  lib.add_line(ow, ow+2*w, 2*w, -2*w, style, false, false)

  lib.add_text(ow-v, w+ow-v, "a", text_style, false, false)
  lib.add_text(ow+v, ow+2*w+v, "c", text_style, false, false)
  lib.add_text(ow+w+v, ow+2*w+v, "b", text_style, false, false)
  lib.add_text(ow+2*w+v, ow+2*w+v, "d", text_style, false, false)
  
 --[[  markeri  ]]--
  lib.add_circle(ow+2*v, 300, 7, marker_style, false, true) 
  lib.add_text(ow, 300, "a", text_style, false, false)  
  lib.add_circle(4*ow+2*v, 300, 7, marker_style, false, true) 
  lib.add_text(4*ow, 300, "b", text_style, false, false)  
  lib.add_circle(7*ow+2*v, 300, 7, marker_style, false, true) 
  lib.add_text(7*ow, 300, "c", text_style, false, false)  
  lib.add_circle(10*ow+2*v, 300, 7, marker_style, false, true) 
  lib.add_text(10*ow, 300, "d", text_style, false, false) 

  lib.end_canvas()
end
                                  
                  