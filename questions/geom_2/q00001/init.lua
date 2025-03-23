
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}		

par = "\(\small\parallel\)";   

ind = math.random(7)

mycanvas = function(no)

  ow = 10
  w = 250
  ov = 150
  v = 40

  lib.start_canvas(300, 200, "center")
  
  lib.add_straight_path(ow+2*v, 2*ow, {{w, ov}}, style, true, false)
  lib.add_straight_path(ov-v, 2*ow, {{-2*v, ov}}, style, true, false)  
  lib.add_straight_path(ow, ov-ow, {{w+v, -v}}, style, true, false)  
  lib.add_straight_path(ow, 2*v+ow, {{w+v, -v}}, style, true, false)  
 
  if (ind > 5) then
     lib.add_text(w+v-ow, 3*ow+5, "a", text_style, false, false)  
  else
     lib.add_input(w+ow, 2*ow, 50, 30, lib.check_string_case("a", 10)) 
  end
  lib.add_input(w+ow, v+3*ow, 50, 30, lib.check_string_case("b", 10))
  if (ind == 7) then
     lib.add_text(v, ov+2*ow, "c", text_style, false, false)
  else 	 
     lib.add_input(v-2*ow, ov, 50, 30, lib.check_string_case("c", 10))
  end
  if (ind == 5) then 
     lib.add_text(w+3*ow, ov, "d", text_style, false, false)
  else	 
     lib.add_input(w+ow, ov-ow, 50, 30, lib.check_string_case("d", 10))
  end 
  
  lib.add_text(ov-v-5, 2*ow-3, ".", dot_style, false, false)
  if (ind == 3 or ind == 4) then
      lib.add_text(ov-v+ow, 2*ow, "O", text_style, false, false) 
  else	  
      lib.add_input(ov-v-ow, 2, 50, 30, lib.check_string_case("O", 10)) 
  end
  
  lib.add_text(v+ow-2, 3*v+2, ".", dot_style, false, false)  
  if (ind == 4 or ind == 6) then  
      lib.add_text(v, ov-v+ow, "P", text_style, false, false)
  else	  
      lib.add_input(ow, ov-v, 50, 30, lib.check_string_case("P", 10)) 
  end
  
  lib.add_text(w-ow-2, 2*(v+ow)-2, ".", dot_style, false, false)
  if (ind == 2) then  
      lib.add_text(w-ow, 2*v+ow+5, "Q", text_style, false, false)  
  else	  
      lib.add_input(ov+2*v-ow-2, 2*v, 50, 30, lib.check_string_case("Q", 10)) 
  end

  lib.add_text(2*v-3, 2*v-ow, ".", dot_style, false, false)
  if (ind == 1 or ind == 5) then 
      lib.add_text(2*v-ow, 2*v-ow, "R", text_style, false, false)
  else	  
      lib.add_input(v, v+2*ow, 50, 30, lib.check_string_case("R", 10))
  end
  
  lib.add_text(ov+2*ow, v+ow+5, ".", dot_style, false, false)
  if (ind < 4 ) then 
      lib.add_text(ov+v-ow-5, v+ow+3, "S", text_style, false, false)
  else  
      lib.add_input(ov+ow-5, v+5, 50, 30, lib.check_string_case("S", 10))
  end
  
  lib.end_canvas()
end