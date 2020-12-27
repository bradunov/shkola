include("terms")

square_style = 
	{["off_color"] = "f90",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "1"};
		
rectangle_style = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};		
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}		

w = 3
ow = 10
v = 70
ov = 100


mycanvas = function(no)
  lib.start_canvas(300, 180, "center")
  
  lib.add_rectangle (ow, 3*ow, ov+ow, v, rectangle_style, true, false)
  lib.add_text(2*ow-w, ov+ow, "A", text_style, false, false) 
  lib.add_text(2*ow+ov-w, ov+ow, "B", text_style, false, false) 
  lib.add_text(2*ow+ov-w, 3*ow/2, "C", text_style, false, false)    
  lib.add_text(2*ow-w, 3*ow/2, "D", text_style, false, false)    
  lib.add_input(ow, ov+3*ow, 110, 30, lib.check_string(answ[1], 90))
  
  lib.add_rectangle (ov+v+ow, 3*ow, v, v, square_style, true, false)
  lib.add_text(ov+v+ow, ov+ow, "A", text_style, false, false) 
  lib.add_text(ov+2*v+ow, ov+ow, "B", text_style, false, false) 
  lib.add_text(ov+2*v+ow, 3*ow/2, "C", text_style, false, false)    
  lib.add_text(ov+v+ow, 3*ow/2, "D", text_style, false, false)    
  lib.add_input(ov+v+ow, ov+3*ow, 70, 30, lib.check_string(answ[2], 50))

  lib.end_canvas()
end
         