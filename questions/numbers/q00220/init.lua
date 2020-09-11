
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};

yelow_style = {["off_color"] = "ff0",
               ["on_color"] = "ff0",
               ["line_color"] = "000",
               ["line_width"] = "2"};

green_style = {["off_color"] = "6f6",
                ["on_color"] = "6f6",
                ["line_color"] = "000",
                ["line_width"] = "2"};

blue_style = {["off_color"] = "0cf",
               ["on_color"] = "0cf",
               ["line_color"] = "000",
               ["line_width"] = "2"};

orange_style = {["off_color"] = "f90",
               ["on_color"] = "f90",
               ["line_color"] = "000",
               ["line_width"] = "2"};
			   
red_style = {["off_color"] = "f30",
               ["on_color"] = "f30",
               ["line_color"] = "000",
               ["line_width"] = "2"};			   
			   
violet_style = {["off_color"] = "f9c",
             ["on_color"] = "f9c",
             ["line_color"] = "000",
             ["line_width"] = "2"};	

brown_style = {["off_color"] = "c90",
             ["on_color"] = "c90",
             ["line_color"] = "000",
             ["line_width"] = "2"};	

line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
text_style = {["font_size"] = "14"}	


mycanvas = function()


  lib.start_canvas(380, 330, "center", results)

  w = 20
  ow = 10
  v = 230

  max = 8
  q = {}
  for i = 1,7 do
      q[i] = math.random(max)
  end


  for i = 1,3 do
    numb = tostring(max-2*i)
    lib.add_line(3*ow, ow+2*i*w, 14*w, 0, style, false, false)
	lib.add_text(ow, ow+2*i*w, numb, text_style, false, false)
  end

  lib.add_line(3*ow, ow, 14*w, 0, line_style, false, false)
  lib.add_line(3*ow, ow+8*w, 14*w, 0, line_style, false, false)
  lib.add_line(3*ow, ow, 0, 8*w, line_style, false, false)
  lib.add_line(3*ow+14*w, ow, 0, 8*w, line_style, false, false)
  lib.add_text(ow, ow, tostring(max), text_style, false, false)
  lib.add_text(ow, ow+8*w, "0", text_style, false, false)

  lib.add_rectangle (2*w, 3*ow+w*(max-1-q[1]), w, q[1]*w, red_style, false, true)
  lib.add_rectangle (4*w, 3*ow+w*(max-1-q[2]), w, q[2]*w, green_style, false, true)  
  lib.add_rectangle (6*w, 3*ow+w*(max-1-q[3]), w, q[3]*w, violet_style, false, true) 
  lib.add_rectangle (8*w, 3*ow+w*(max-1-q[4]), w, q[4]*w, blue_style, false, true)  
  lib.add_rectangle (10*w, 3*ow+w*(max-1-q[5]), w, q[5]*w, orange_style, false, true) 
  lib.add_rectangle (12*w, 3*ow+w*(max-1-q[6]), w, q[6]*w, yelow_style, false, true)  
  lib.add_rectangle (14*w, 3*ow+w*(max-1-q[7]), w, q[7]*w, brown_style, false, true)  

  for i = 1,7 do
    lib.add_line(2*i*w-ow, v, 0, 4*w+ow, line_style, false, false)
  end
    lib.add_line(16*w-ow, v, 0, 4*w+ow, line_style, false, false)

  for i = 1,2 do
    lib.add_line(3*ow, v+2*(i-1)*w, 14*w, 0, line_style, false, false)
  end
    lib.add_line(3*ow, v+4*w+ow, 14*w, 0, line_style, false, false)

    lib.add_circle(2*w+ow, v+w, 7, red_style, false, false)
    lib.add_input(2*w-ow, v+2*w+ow, 40, 30, lib.check_number(q[1],15))
    lib.add_circle(4*w+ow, v+w, 7, green_style, false, false)
    lib.add_input(4*w-ow, v+2*w+ow, 40, 30, lib.check_number(q[2],15))
    lib.add_circle(6*w+ow, v+w, 7, violet_style, false, false)
    lib.add_input(6*w-ow, v+2*w+ow, 40, 30, lib.check_number(q[3],15))
    lib.add_circle(8*w+ow, v+w, 7, blue_style, false, false)
    lib.add_input(8*w-ow, v+2*w+ow, 40, 30, lib.check_number(q[4],15))
    lib.add_circle(10*w+ow, v+w, 7, orange_style, false, false)
    lib.add_input(10*w-ow, v+2*w+ow, 40, 30, lib.check_number(q[5],15))
    lib.add_circle(12*w+ow, v+w, 7, yelow_style, false, false)
    lib.add_input(12*w-ow, v+2*w+ow, 40, 30, lib.check_number(q[6],15))
    lib.add_circle(14*w+ow, v+w, 7, brown_style, false, false)
    lib.add_input(14*w-ow, v+2*w+ow, 40, 30, lib.check_number(q[7],15))

  lib.end_canvas()
end
           