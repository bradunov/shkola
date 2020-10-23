
style = 
	{["off_color"] = "fff",
        ["on_color"] = "faf",
        ["line_color"] = "000",
        ["line_width"] = "1"};

diff_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "00f",
        ["line_width"] = "2"};

text_style = {["font_size"] = "40",
             ["line_width"] = "0.5"}


include("shapes")

mycanvas = function()

  ind = math.random(5)

  results = ""
  
  if (ind == 1) then
     results = "result[0] == 0 && result[1] == 0 && result[2] == 1 && result[3] == 0 && result[4] == 0  && result[5] == 0"  
  end	 
  if (ind == 2) then
     results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 1  && result[5] == 0"  
  end
  if (ind == 3) then
     results = "result[0] == 1 && result[1] == 0 && result[2] == 0 && result[3] == 0 && result[4] == 0  && result[5] == 0"  
  end
  if (ind == 4) then
     results = "result[0] == 0 && result[1] == 1 && result[2] == 0 && result[3] == 0 && result[4] == 0  && result[5] == 0"  
  end
  if (ind == 5) then
     results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 1 && result[4] == 0  && result[5] == 0"  
  end  
  
  lib.start_canvas(350, 220, "center", results)

  v = 5
  w = 10
  ow = 30
 
  scale = 0.7

  

  y = 2*ow
  d = 7*ow-v

  if (ind == 1) then 
     x = ow
     lib.add_triangle (x, y, 30, 30, diff_style, false, false)
     heart(lib, x + ow, y+w, scale, diff_style, false, false)
     lib.add_circle (x + 2*ow+v, y, 15, diff_style, false, false)
     cross(lib, x + 3*ow, y-v, scale, diff_style, false, false)
     lib.add_rectangle (x + 4*ow+v, y-w-v, 30, 30, diff_style, false, false)
     diamond(lib, x + 5*ow+w, y, scale, diff_style, false, false)
     lib.add_triangle (x+d, y, 30, 30, diff_style, false, false)
     heart(lib, x+d + ow , y+w, scale, diff_style, false, false) 
     lib.add_text(330, y, "?", text_style, false, false)
   end	 
  
  if (ind == 2) then 
      x = 0  
      heart(lib, x + ow, y+w, scale, diff_style, false, false)
      lib.add_circle (x + 2*ow+v, y, 15, diff_style, false, false)
      cross(lib, x + 3*ow, y-v, scale, diff_style, false, false)
      lib.add_rectangle (x + 4*ow+v, y-w-v, 30, 30, diff_style, false, false)
      diamond(lib, x + 5*ow+w, y, scale, diff_style, false, false)
      lib.add_triangle (x+d, y, 30, 30, diff_style, false, false)
      heart(lib, x+d + ow , y+w, scale, diff_style, false, false)
      lib.add_circle (x+d + 2*ow+v, y, 15, diff_style, false, false)
      lib.add_text(330, y, "?", text_style, false, false)
  end  

  if (ind == 3) then 
      x = -ow - v
      lib.add_circle (x + 2*ow+v, y, 15, diff_style, false, false)
      cross(lib, x + 3*ow, y-v, scale, diff_style, false, false)
      lib.add_rectangle (x + 4*ow+v, y-w-v, 30, 30, diff_style, false, false)
      diamond(lib, x + 5*ow+w, y, scale, diff_style, false, false)
      lib.add_triangle (x+d, y, 30, 30, diff_style, false, false)
      heart(lib, x+d + ow , y+w, scale, diff_style, false, false)
      lib.add_circle (x+d + 2*ow+v, y, 15, diff_style, false, false)
      cross(lib, x+d + 3*ow, y-v, scale, diff_style, false, false)
     lib.add_text(330, y, "?", text_style, false, false)
  end  

  if (ind == 4) then 
      x = -2*ow 
      cross(lib, x + 3*ow, y-v, scale, diff_style, false, false)
      lib.add_rectangle (x + 4*ow+v, y-w-v, 30, 30, diff_style, false, false)
      diamond(lib, x + 5*ow+w, y, scale, diff_style, false, false)
      lib.add_triangle (x+d, y, 30, 30, diff_style, false, false)
      heart(lib, x+d + ow , y+w, scale, diff_style, false, false)
      lib.add_circle (x+d + 2*ow+v, y, 15, diff_style, false, false )
      cross(lib, x+d + 3*ow, y-v, scale, diff_style, false, false)
      lib.add_rectangle (x+d + 4*ow+v, y-w-v, 30, 30, diff_style, false, false)
     lib.add_text(330, y, "?", text_style, false, false)
  end

  if (ind == 5) then 
      x = -3*ow - v
      lib.add_rectangle (x + 4*ow+v, y-w-v, 30, 30, diff_style, false, false)
      diamond(lib, x + 5*ow+w, y, scale, diff_style, false, false)
      lib.add_triangle (x+d, y, 30, 30, diff_style, false, false)
      heart(lib, x+d + ow , y+w, scale, diff_style, false, false)
      lib.add_circle (x+d + 2*ow+v, y, 15, diff_style, false, false )
      cross(lib, x+d + 3*ow, y-v, scale, diff_style, false, false)
      lib.add_rectangle (x+d + 4*ow+v, y-w-v, 30, 30, diff_style, false, false)
      diamond(lib, x+d + 5*ow+w, y, scale, diff_style, false, false)
      lib.add_text(330, y, "?", text_style, false, false)	  
  end
  
  y = 6*ow
      lib.add_rectangle (ow, y-w-v, 30, 30, style, false, true)
      diamond(lib, 3*ow, y, scale, style, false, true)
      lib.add_circle (5*ow, y, 15, style, false, true )
      lib.add_triangle (7*ow, y, 30, 30, style, false, true)
      cross(lib, 8*ow, y-v, scale, style, false, true)	  
      heart(lib, 10*ow, y+w, scale, style, false, true)

  lib.end_canvas()
end           
         
                         
                  
                      
                         
                  