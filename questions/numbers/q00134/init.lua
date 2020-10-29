
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};

orange_style = {["off_color"] = "f90",
               ["on_color"] = "f90",
               ["line_color"] = "000",
               ["line_width"] = "2"};
			   
line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
text_style = {["font_size"] = "16"}	

day = {"utorak", "sreda", "petak", "subota"}
number = {3, 4, 6, 5}

factor = 5 * math.random(4)

q = {}
for i = 1,4 do
    q[i] = number[i] * factor 
end

mycanvas = function()

  lib.start_canvas(380, 250, "center", results)

  w = 25
  ow = 10
  v = 170

  for i = 1,4 do
    lib.add_line(3*ow, ow+i*w, 12*w, 0, style, false, false)	
    lib.add_text(ow+2*w, 2*ow+i*w, day[i], text_style, false, false)
  end

  lib.add_line(3*ow, ow, 12*w, 0, line_style, false, false)
  lib.add_line(3*ow, ow+w, 12*w, 0, line_style, false, false)  
  lib.add_line(3*ow, ow+5*w, 12*w, 0, line_style, false, false)
  lib.add_line(3*ow, ow, 0, 5*w, line_style, false, false)
  lib.add_line(3*ow+3*w, ow, 0, 5*w, line_style, false, false)
  lib.add_line(3*ow+12*w, ow, 0, 5*w, line_style, false, false)  
  lib.add_text(ow+2*w, 2*ow, "dan", text_style, false, false)
  lib.add_text(ow+7*w, 2*ow, "broj pogačica", text_style, false, false)


  for j = 1,4 do
      y = 2*ow+j*w+2
      for i = 1,number[j] do
	      x = (i+4)*w
          lib.add_circle(x, y, 7, orange_style, true, false)
      end
  end
	

  for i = 1,5 do
    lib.add_line(3*ow+3*(i-1)*w, v, 0, 3*w, line_style, false, false)
  end


  for i = 1,2 do
    lib.add_line(3*ow, v+(i-1)*(w+5), 12*w, 0, line_style, false, false)
  end
    lib.add_line(3*ow, v+3*w, 12*w, 0, line_style, false, false)

  for i = 1,4 do
    lib.add_text((3*i-1)*w+ow, v+ow, day[i], text_style, false, false)
    lib.add_input((3*i-1)*w, v+w+ow+3, 40, 30, lib.check_number(q[i],15))
  end

  lib.end_canvas()
end
    
            