style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

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
             ["on_color"] = "f9s",
             ["line_color"] = "000",
             ["line_width"] = "2"};	


mycanvas = function()

  lib.start_canvas(400, 250, "center", results)

  w = 20
  ow = 15

  for i = 1,11 do
    lib.add_line(ow, ow+(i-1)*w, 14*w, 0, style, false, false)
  end

  for i = 1,15 do
    lib.add_line(ow+(i-1)*w, ow, 0, 10*w, style, false, false)
  end
  
  lib.add_rectangle (ow+7*w, ow+6*w, 2*w, 3*w, violet_style, false, true)
  lib.add_input(ow+7*w+5, ow+7*w, 30, 30, lib.check_number(3,10)) 
 
  lib.add_rectangle (ow+w, ow+7*w, 2*w, 2*w, red_style, false, true)
  lib.add_input(ow+w+5, ow+7*w+10, 30, 30, lib.check_number(2,10))

  lib.add_rectangle (ow+w, ow+2*w, 4*w, 4*w, green_style, false, true)  
  lib.add_input(ow+2*w+5, ow+3*w+5, 30, 30, lib.check_number(6,10))

  lib.add_rectangle (ow+7*w, ow+3*w, 2*w, w, yelow_style, false, true)  
  lib.add_input(ow+7*w+5, ow+3*w-3, 30, 30, lib.check_number(1,10))

  lib.add_rectangle (ow+6*w, ow+w, 7*w, w, orange_style, false, true)  
  lib.add_input(ow+9*w-5, ow+w-3, 30, 30, lib.check_number(4,10))

  lib.add_rectangle (ow+11*w, ow+3*w, 2*w, 4*w, blue_style, false, true)  
  lib.add_input(ow+11*w+5, ow+4*w+10, 30, 30, lib.check_number(5,10))
 
  lib.end_canvas()
end
                   
