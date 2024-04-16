
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}		

out = {"MON", "mOn", "MNO", "OMN"}

answ = lib.math.random_shuffle(out)

for i = 1,4 do
    if (answ[i] == out[1]) then
	    ind = i - 1
	end	
end	

ow = 8
w = 160
ov = 120


mycanvas = function(no)
  lib.start_canvas(240, 150, "center")
  
  lib.add_straight_path(ow, ov, {{w, 0}}, style, true, false)
  lib.add_straight_path(ow, ov, {{w-2*ow, -ov+ow}}, style, true, false)  

  lib.add_text(ow, ov-ow-2, ".", dot_style, false, false)
  lib.add_text(ow, ov+ow+3, "O", text_style, false, false)
  lib.add_text(ov-2*ow, 5*ow-5, ".", dot_style, false, false)
  lib.add_text(ov-2*ow, 4*ow, "N", text_style, false, false)
  lib.add_text(ov+2*ow, ov-ow-2, ".", dot_style, false, false)
  lib.add_text(ov+2*ow, ov+ow+3, "M", text_style, false, false)
  
  lib.end_canvas()
end