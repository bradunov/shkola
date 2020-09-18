
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}
symb = "\(\angle\)" 

tacka = {"A", "B", "C"}
reply = {}
ans = {}

reply[1] = "answer == '" .. tacka[1] .. "' ";
ans[1] = "answer = '" .. tacka[1] .. "' ";
reply[2] = "answer == '" .. tacka[2] .. "' ";
ans[2] = "answer = '" .. tacka[2] .. "' ";		
reply[3] = "answer == '" .. tacka[3] .. "' ";
ans[3] = "answer = '" .. tacka[3] .. "' ";


  w = 5 
  ow = 10
  wy = 100
	
mycanvas = function()

  lib.start_canvas(250, 170, "center")

  lib.add_straight_path(wy, wy+3*ow, {{wy, 0}}, style,  false, false)
  lib.add_text(2*wy-ow, wy + 2*ow, "a", text_style, false, false) 

  lib.add_straight_path(wy, wy+3*ow, {{wy/2, -wy}}, style,  false, false)
  lib.add_text(3*wy/2-ow, 3*ow, "c", text_style, false, false) 

  lib.add_straight_path(wy, wy+3*ow, {{-wy/2, -wy}}, style,  false, false)
  lib.add_text(wy/2-ow, 3*ow, "b", text_style, false, false) 

  lib.add_text(wy, 3*wy/2-ow, "O", text_style, false, false) 

lib.add_input(wy+2*ow, wy/2+2*ow-w, 30, 30, lib.check_string(reply[1], 15, ans[1]))
lib.add_text(wy+2*ow, (wy+3*w)/2+2*ow, ".", dot_style, false, false)

lib.add_input(3*wy/2+ow, ow+w, 30, 30, lib.check_string(reply[2], 15, ans[2]))
lib.add_text(3*(wy/2+ow)-w, wy/2+ow, ".", dot_style, false, false)

lib.add_input(wy-2*ow+w, ow-w, 30, 30, lib.check_string(reply[3], 15, ans[3]))
lib.add_text(wy, wy/2, ".", dot_style, false, false)
        
  lib.end_canvas()
end    
  