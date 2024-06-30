
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f90",
        ["line_width"] = "2"};
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}		

index = {1,2,3,4,5,6,7,8,9}
out = lib.math.random_shuffle(index)

w = 3
ow = 10
v = 70
ov = 100


mycanvas = function(no)
  lib.start_canvas(200, 200, "center")
  
  lib.add_circle (ov, ov, v, style, false, false)
  lib.add_straight_path(ov+6*ow, ov-4*ow, {{-11*ow-w, 8*ow+w}}, style,  false, false) 
  lib.add_straight_path(ov-6*ow-w, ov-3*ow, {{6*ow+w, 3*ow}}, style,  false, false) 
  lib.add_straight_path(ov+3*ow+w, ov-ow+v, {{3*ow-w, -v-3*ow}}, style,  false, false)

  lib.add_text(ov+w, ov-ow, ".", dot_style, false, false) 
  lib.add_text(ow+ov+w, ov+2*w, "O", text_style, false, false) 
  lib.add_text(ov+6*ow, ov-5*ow, ".", dot_style, false, false)    
  lib.add_text(ov+7*ow+w, ov-4*ow, "A", text_style, false, false) 
  lib.add_text(ov-6*ow+2*w, ov+3*ow+w, ".", dot_style, false, false)    
  lib.add_text(ov-7*ow+w, ov+5*ow, "D", text_style, false, false)    
  lib.add_text(ov-6*ow-w, ov-4*ow, ".", dot_style, false, false)    
  lib.add_text(2*ow+w, ov-3*ow, "B", text_style, false, false) 
  lib.add_text(ov+3*ow+w, ov-2*ow+v, ".", dot_style, false, false)    
  lib.add_text(ov+4*ow, ov+v, "C", text_style, false, false) 

  lib.end_canvas()
end
