
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f90",
        ["line_width"] = "2"};		
		
dot_style = {["font_size"] = "40"}
text_style = {["font_size"] = "16"}		


answ = {1, 3, 6, 10, 15}

out = lib.math.random_shuffle(answ)

ind = math.random(5)

for i = 1,5 do
    if (out[i] == answ[ind]) then
	    index = i - 1
    end
end	

mycanvas = function(no)
  lib.start_canvas(300, 260, "center")  

  lib.add_text(45, 90, ".", dot_style, false, false)
  lib.add_text(45, 88, "O", text_style, false, false)
  
  lib.add_text(240, 170, ".", dot_style, false, false)
  lib.add_text(240, 170, "M", text_style, false, false)

  if(ind > 1) then
     lib.add_text(60, 180, ".", dot_style, false, false)
     lib.add_text(60, 178, "A", text_style, false, false)
  
     if(ind > 2) then
        lib.add_text(150, 70, ".", dot_style, false, false)
        lib.add_text(150, 68, "J", text_style, false, false)

        if(ind > 3) then
           lib.add_text(130, 230, ".", dot_style, false, false)
           lib.add_text(130, 228, "T", text_style, false, false)

           if(ind > 4) then
              lib.add_text(230, 30, ".", dot_style, false, false)
              lib.add_text(230, 28, "E", text_style, false, false)
           end
        end
     end
  end	 
	
  lib.end_canvas()
end
