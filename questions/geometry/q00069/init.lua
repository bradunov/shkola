
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};

blue_style = {["off_color"] = "none",
               ["on_color"] = "0cf",
               ["line_color"] = "000",
               ["line_width"] = "3"};
			   
red_style = {["off_color"] = "f30",
               ["on_color"] = "f30",
               ["line_color"] = "000",
               ["line_width"] = "2"};	

text_style = {["font_size"] = "14"}		   

mycanvas = function()

  lib.start_canvas(300, 300, "center", results)

  w = 20
  ow = 10

  for i = 1,15 do
    lib.add_line(ow, ow+(i-1)*w, 14*w, 0, style, false, false)
  end

  for i = 1,15 do
    lib.add_line(ow+(i-1)*w, ow, 0, 14*w, style, false, false)
  end
  
  lib.add_rectangle (ow+2*w, ow+w, 4*w, 2*w, red_style,  false, true)
  lib.add_circle (ow+4*w, ow+2*w, ow+2, text_style, false, false)
  lib.add_text(ow+4*w, ow+2*w, "12", text_style, false, false)

  lib.add_straight_path (ow+11*w, ow+8*w, {{0, -w}, {-w,0}, {0,-w}, {-2*w,0}, {0,2*w}, {w, 0}, {0,w}, {w, 0}}, blue_style, false, true)   
  lib.add_input(9*w, 7*w, 30, 30, lib.check_number(10,15)) 
 
  lib.add_straight_path (ow+5*w, ow+12*w, {{w,0}, {0,w}, {-5*w,0}, {0, -2*w}, {5*w, 0}, {0,-2*w}, {-5*w,0}, {0,w}, {w,0}}, blue_style, false, true)   
  lib.add_input(ow+3*w-5, 12*w, 30, 30, lib.check_number(23,15))

  lib.add_straight_path (ow+8*w, ow+w, {{2*w,0}, {0,w}, {w,0}, {0,w}, {w,0}, {0, w}, {w,0}, {0, w}, {-2*w,0}, {0,-w}, {-w,0}, {0,-w}, {-2*w,0}, {0, -2*w}}, blue_style, false, true)   
  lib.add_input(9*w, 2*w, 30, 30, lib.check_number(18,15))

  lib.add_straight_path (ow+w, ow+5*w, {{5*w,0}, {0,w}, {-w,0}, {0,w}, {-3*w, 0}, {0,-w}, {-w,0}, {0,-w}}, blue_style, false, true)    
  lib.add_input(ow+3*w-5, ow+5*w+5, 30, 30, lib.check_number(14,15))

  lib.add_straight_path (ow+8*w, ow+10*w, {{5*w,0}, {0,3*w}, {-w,0}, {0,-w}, {-w, 0}, {0,w}, {-w,0}, {0,-w}, {-w, 0}, {0,w}, {-w,0}, {0,-3*w}}, blue_style, false, true)    
  lib.add_input(ow+10*w-5, 11*w, 30, 30, lib.check_number(20,15))
 
  lib.end_canvas()
end
 
     