
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}	

area_dot = {"O", "M"}
area_line = {"a", "b", "c", "d"}

ow = 10
w = 220
ov = 120

mycanvas = function(no)
  lib.start_canvas(250, 150, "center")
  
  lib.add_straight_path(ow, 2*ow, {{w, 0}}, style, true, false)
  lib.add_input(w-ow, 5*ow/2, 30, 30, lib.check_string(area_line[1], 15)) 

  lib.add_straight_path(ow, ov/2+ow, {{w, 0}}, style, true, false) 
  lib.add_input(w-ow, (ov+3*ow)/2, 30, 30, lib.check_string(area_line[2], 15)) 
 
  lib.add_straight_path(7*ow, ow/2, {{0, ov+ow}}, style, true, false) 
  lib.add_input(7*ow, ov, 30, 30, lib.check_string(area_line[4], 15))
 
  lib.add_straight_path(ow, ov, {{w, -ov}}, style, true, false)  
  lib.add_input(ow, ov, 30, 30, lib.check_string(area_line[3], 15))

  lib.add_text(7*ow, ow, ".", dot_style, false, false)
  lib.add_input(7*ow, 5*ow/2, 30, 30, lib.check_string_case(area_dot[1], 15))
  lib.add_text(ov-2*ow+2, ov/2-2, ".", dot_style, false, false)
  lib.add_input(ov-3*ow-2, (ov+3*ow)/2, 30, 30, lib.check_string_case(area_dot[2], 15))

  lib.end_canvas()
end
     
    
            