
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
text_style = {["font_size"] = "16"}	
dot_style = {["font_size"] = "40"}	

test = {"pripada", "ne pripada"}

ow = 10
ov = 100
w = 200

ind = math.random(2)
if (ind == 1) then
   x = ov+2*ow
   y = ov-4*ow
else
   x = ov-4*ow 
   y = 3*ow   
end   


mycanvas = function(no)
  lib.start_canvas(250, 150, "center")
  
  lib.add_straight_path(ow/2, ov+ow, {{w, 0}}, style, true, false)
  lib.add_straight_path(ow/2, ov+ow, {{w, -ov}}, style, true, false)  

  lib.add_text(w, 2*ow+ov, "a", text_style, false, false)  
  lib.add_text(w, 2*ow+5, "b", text_style, false, false)
  lib.add_text(ow/2, ov, ".", dot_style, false, false)
  lib.add_text(ow/2, ov+2*ow+5, "O", text_style, false, false)  
  lib.add_text(ov, ov, ".", dot_style, false, false)
  lib.add_text(ov, ov+2*ow+5, "A", text_style, false, false)
  lib.add_text(x, y, ".", dot_style, false, false)
  lib.add_text(x+ow, y+2*ow, "M", text_style, false, false)  

  
  lib.end_canvas()
end
   