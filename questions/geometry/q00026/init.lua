include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};

text_style = {["font_size"] = "16"}
colour_style = {["off_color"] = "f90",
                ["font_size"] = "16"}

index = {1,2,3,4,5,6}
ind = lib.math.random_shuffle(index)

dim = 6

mycanvas = function()

  lib.start_canvas(350, 350, "center")

  wh = 100
  wv = 40
  ow = 10

    lib.add_line(ow, ow, 2*ow+3*wh, 0, style, false, false)

for i = 1,7 do
    lib.add_line(ow, i*(wv+ow), 2*ow+3*wh, 0, style, false, false)
  end
  
  lib.add_line(ow, ow, 0, 17*wv/2, style, false, false)
  lib.add_line(3*ow+2*wh+wv, ow, 0, 17*wv/2, style, false, false)
  lib.add_line(3*ow+3*wh, ow, 0, 17*wv/2, style, false, false)
  

  lib.add_text(3*wv, 3*ow, tvrdjenje_str, text_style)
  lib.add_text(2*(wh+wv+ow), 3*ow, t_str.." / "..n_str, text_style)
  
  for i = 1,dim do
      lib.add_text(5*ow, 2*ow+i*(wv+ow), object[ind[i]], colour_style)
	  out = math.random(4)
   	  lib.add_text(8*ow+wh, 2*ow+i*(wv+ow), title[out], text_style)	  
	  temp = n_str
	  if(ind[i] < 3 and out < 3) then
	     temp = t_str
	  end	 
	  if(ind[i] == 3  and out == 3) then
	     temp = t_str
	  end
	  if(ind[i] == 4  and out == 3) then
	     temp = t_str
	  end	  
 	  if(ind[i] == 5 and out == 4) then
	     temp = t_str
	  end			  
	  lib.add_input(8*ow+2*wh, ow+i*(wv+ow),40, 40, lib.check_string(temp,15))	  
  end 

  lib.end_canvas()
end
  
          