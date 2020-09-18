
red_style = {["off_color"] = "f30",
                ["on_color"] = "f30",
                ["line_color"] = "000",
                ["line_width"] = "1"};

blue_style = {["off_color"] = "0cf",
               ["on_color"] = "0cf",
               ["line_color"] = "000",
               ["line_width"] = "1"};
			   
text_style = {["font_size"] = "16"}		

reply = "answer == '" .. "ostra" .. "' "  ..
        "|| answer == '" .. "oštra" .. "'" ;
ans = "answer = '" .. "oštra" .. "' ";
		
  w = 5
  ow = 20
  wy = 70
	
mycanvas = function()

  lib.start_canvas(300, 120, "center")

  lib.add_straight_path(ow, ow, {{0, wy}, {3*wy/2, 0}, {-3*wy/2, -wy},}, red_style,  false, false)
   lib.add_text(ow-w, ow+wy+w, "A", text_style, false, false)
   lib.add_text(3*ow+wy, ow+wy+w, "B", text_style, false, false)
   lib.add_text(ow-w, ow-w, "C", text_style, false, false)

  lib.add_straight_path(2*ow+wy, ow, {{wy, wy}, {3*wy/2, 0}, {-5*wy/2, -wy} }, blue_style,  false, false)
   lib.add_text(2*(ow+wy)-w, ow+wy+w, "K", text_style, false, false)
   lib.add_text(4*ow+3*wy, ow+wy+w, "L", text_style, false, false)
   lib.add_text(3*ow/2+wy, ow-w, "M", text_style, false, false)
       
  lib.end_canvas()
end   
      
			    

  