
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};		
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}		


answ = {2, 6, 12, 8, 10}

out = lib.math.random_shuffle(answ)

ind = math.random(4)

for i = 1,5 do
    if (out[i] == answ[ind]) then
	    index = i - 1
    end
end	

mycanvas = function(no)
  lib.start_canvas(350, 250, "center")  
  
  w = 20
  ow = 10

  for i = 1,12 do
    lib.add_line(w, i*w, 14*w, 0, style, false, false)
  end

  for i = 1,15 do
    lib.add_line(i*w, w, 0, 11*w, style, false, false)
  end

  lib.add_text(3*w, 7*w+ow, ".", dot_style, false, false)
  lib.add_text(3*w+ow, 7*w+ow, "A", text_style, false, false)
  lib.add_text(13*w, 4*w+ow, ".", dot_style, false, false)
  lib.add_text(13*w+ow, 4*w+ow, "M", text_style, false, false)
 
  if (ind > 1) then
     lib.add_text(9*w, 2*w+ow, ".", dot_style, false, false)
     lib.add_text(9*w+ow, 2*w+ow, "J", text_style, false, false)
  end
  
  if (ind == 3) then  
      lib.add_text(3*w, 3*w+ow, ".", dot_style, false, false)
      lib.add_text(3*w+ow, 3*w+ow, "O", text_style, false, false)
  end
  
  if (ind == 4) then
     lib.add_text(7*w, 9*w+ow, ".", dot_style, false, false)
     lib.add_text(7*w+ow, 9*w+ow, "T", text_style, false, false)
  end 
	
  lib.end_canvas()
end
        