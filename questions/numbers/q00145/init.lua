
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

text_style = {["font_size"] = "14"}

magic = {}
out = {}

magic[1] = {3, 16, 5, 10, 8, 6, 11, 0, 13}
out[1] = {1, 0, 1, 0, 1, 0, 0, 0, 1}

magic[2] = {7, 13, 14, 17, 12, 5, 10, 9, 17}
out[2] = {0, 0, 1, 0, 0, 0, 1, 1, 1}

magic[3] = {25, 3, 17, 7, 15, 23, 13, 27, 5}
out[3] = {0, 1, 1, 0, 1, 0, 0, 1, 1}

magic[4] = {22, 21, 14, 11, 19, 27, 24, 17, 16}
out[4] = {1, 1, 1, 0, 0, 1, 0, 0, 0}

magic[5] = {10, 38, 18, 30, 22, 14, 26, 6, 34}
out[5] = {0, 0, 1, 0, 1, 0, 1, 1, 1}

dim = 3

ind = math.random(5)

mycanvas = function()

  lib.start_canvas(300, 200, "center")

  w = 60
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
		      lib.add_text(4*ow+(i-1)*w, 4*ow+(j-1)*w, text, text_style)
		  else
		      lib.add_input(ow+(i-1)*w+15, ow+(j-1)*w+15, 40, 40, lib.check_number(temp,20))
		  end	    
	  end	  
  end 

  lib.end_canvas()
end
         
                