
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
text_style = {["font_size"] = "16"}	
dot_style = {["font_size"] = "40"}	

ang = {"α", "β", "γ"}

reply1 = "answer == '" .. elem[4] .. "' "  ..
        "|| answer == '" .. elem2[4] .. "'" ;
ans1 = "answer = '" .. elem[4] .. "' ";
reply2 = "answer == '" .. elem[5] .. "' "  ..
        "|| answer == '" .. elem2[5] .. "'" ;
ans2 = "answer = '" .. elem[5] .. "' ";

mycanvas = function(no)

  ow = 10
  ov = 100
  w = 200

  lib.start_canvas(250, 150, "center")
  
  lib.add_straight_path(ow, ov+2*ow, {{w, 0}}, style, true, false)
  lib.add_straight_path(ow, ov+2*ow, {{w-5*ow, -ov-ow}}, style, true, false)  
  lib.add_straight_path(ow+w, ov+2*ow, {{-5*ow, -ov-ow}}, style, true, false)

  lib.add_input(w-3*ow+5, 4*ow, 50, 30, lib.check_string_case("a", 15))
  lib.add_input(5*ow-5, 4*ow, 50, 30, lib.check_string_case("b", 15))
  lib.add_text(ov+ow, ov+3*ow, "c", text_style, false, false)  

  lib.add_text(ow, ov+ow, ".", dot_style, false, false) 
  lib.add_input(ow-3*ow, ov+3*ow, 50, 30, lib.check_string_case("A", 15))
  lib.add_text(w+ow,  ov+ow, ".", dot_style, false, false)
  lib.add_input(w-ow, ov+3*ow, 50, 30, lib.check_string_case("B", 15))
  lib.add_text(w-4*ow, 0, ".", dot_style, false, false)
  lib.add_text(w-3*ow+5, ow, "C", text_style, false, false)

  lib.add_input(ow, ov, 50, 30, ang[1])
  lib.add_input(w-3*ow, ov, 50, 30, ang[2])
  lib.add_input(ov+3*ow, 2*ow, 50, 30, ang[3])

  lib.add_text(ov+3*ow, ov-3*ow+5, ".", dot_style, false, false)
  lib.add_text(ov+3*ow, ov-3*ow, "M", text_style, false, false)  
 
  lib.end_canvas()
end
   