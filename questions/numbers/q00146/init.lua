
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

text_style = {["font_size"] = "14"}

magic = {}
out = {}

magic[1] = {4, 17, 14, 3, 11, 6, 9, 12, 7, 10,13, 8, 16, 5, 2, 15}
out[1] = {0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 1, 0, 1, 1}

magic[2] = {9, 4, 14, 7, 6, 15, 1, 12, 3, 10, 8, 13, 16, 5, 11, 2}
out[2] = {1, 0, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1}

magic[3] = {21, 10, 16, 7, 8, 15, 13, 18, 11, 20, 6, 17, 14, 9, 19, 12}
out[3] = {1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 1, 0}

magic[4] = {6, 19, 16, 5, 13, 8, 11, 14, 9, 12, 15, 10, 18, 7, 4, 17}
out[4] = {1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 1}


dim = 4

ind = math.random(4)

mycanvas = function()

  lib.start_canvas(300, 250, "center")

  w = 50
  ow = 10

dimp1 = dim + 1
  for i = 1,dimp1 do
    lib.add_line(ow, ow+(i-1)*w, dim*w, 0, style, false, false)
    lib.add_line(ow+(i-1)*w, ow, 0, dim*w, style, false, false)
  end

  for j = 1,dim do
      for i = 1,dim do
	      temp = magic[ind][(j-1)*dim + i]
          if (out[ind][(j-1)*dim + i] == 1) then 
		      text = tostring(math.floor(temp))
		      lib.add_text(3*ow+(i-1)*w+5, 3*ow+(j-1)*w+5, text, text_style)
		  else
		      lib.add_input(2*ow+(i-1)*w-5, 2*ow+(j-1)*w+5, 40, 40, lib.check_number(temp,20))
		  end	    
	  end	  
  end 
  lib.end_canvas()
end
               