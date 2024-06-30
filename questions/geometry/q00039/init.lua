
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f90",
        ["line_width"] = "2"};
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}		

index = {1,2,3,4,5,6}
out = lib.math.random_shuffle(index)

w = 3
ow = 10
v = 70
ov = 100


mycanvas = function(no)
  lib.start_canvas(200, 200, "center")
  
  lib.add_circle (ov, ov, v, style, false, false)
  lib.add_text(ov, ov-ow, ".", dot_style, false, false) 
  lib.add_text(ow+ov+w, ov, "O", text_style, false, false) 
  lib.add_text(ov+6*ow, ov-5*ow, ".", dot_style, false, false)    
  lib.add_text(ov+7*ow+w, ov-4*ow, "A", text_style, false, false)    
  lib.add_text(ov-4*ow, ov-4*ow, ".", dot_style, false, false)    
  lib.add_text(ov-3*ow+w, ov-3*ow, "B", text_style, false, false) 
  lib.add_text(ov+3*ow+w, ov-2*ow+v, ".", dot_style, false, false)    
  lib.add_text(ov+5*ow-w, ov-ow+v+w, "C", text_style, false, false) 

  lib.end_canvas()
end
         