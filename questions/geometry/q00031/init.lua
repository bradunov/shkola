include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}		

test = {t_str, n_str, t_str, n_str, t_str, t_str, n_str,  t_str}

index = {1,2,3,4,5,6,7,8}
out = lib.math.random_shuffle(index)

ow = 10
w = 250
ov = 150


mycanvas = function(no)
  lib.start_canvas(300, 200, "center")
  
  lib.add_straight_path(ow, 2*ow, {{w, 0}}, style, true, false)
  lib.add_straight_path(7*ow, ow/2, {{0, ov}}, style, true, false)  
  lib.add_straight_path(ow, ov, {{w, -ov}}, style, true, false)  

  lib.add_text(5*ow/2, 3*ow, "a", text_style, false, false)  
  lib.add_text(5*ow/2, ov, "b", text_style, false, false)
  lib.add_text(8*ow, ov, "c", text_style, false, false)

  lib.add_text(3*ov/2, ow, ".", dot_style, false, false)
  lib.add_text(3*ov/2, ow, "O", text_style, false, false)
  lib.add_text(ov, 5*ow+3, ".", dot_style, false, false)
  lib.add_text(ov, 5*ow, "M", text_style, false, false)
  lib.add_text((ov-ow)/2, ov/2, ".", dot_style, false, false)
  lib.add_text(ov/2+ow, ov/2+ow, "N", text_style, false, false)
  
  lib.end_canvas()
end
         
            