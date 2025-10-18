
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

text_style = {["font_size"] = "16"}

out = {}
out[1] = {6, 6, 2, 0, 1, 5}
out[2] = {0, 0, 1, 1, 1, 0}

index = {1,2,3,4,5,6}
ind = lib.math.random_shuffle(index)

dim = 6

mycanvas = function()

  lib.start_canvas(350, 350, "center")

  wh = 100
  wv = 40
  ow = 10

    lib.add_line(ow, ow, 3*wh, 0, style, false, false)
  for i = 1,7 do
    lib.add_line(ow, ow+(i+ 1)*wv, 3*wh, 0, style, false, false)
  end
  
  for i = 1,4 do
    lib.add_line(ow+(i-1)*wh, ow, 0, 8*wv, style, false, false)
  end  

  lib.add_input(2*ow, 2*ow, 70, 30, title[1])
  lib.add_input(2*ow, 4*ow, 70, 30,  title[3])

  lib.add_input(2*ow+wh, 2*ow, 70, 30,  title[2])
  lib.add_input(2*ow+wh, 4*ow, 70, 30,  title[5])
  lib.add_input(2*ow+wh, 6*ow, 70, 30,  title[4])

  lib.add_input(2*ow+2*wh, 2*ow, 70, 30, title[2])
  lib.add_input(ow+2*wh, 4*ow, 90, 30, title[6])
  lib.add_input(2*ow+2*wh, 6*ow, 70, 30, title[4])
  
  for i = 1,dim do
  	  if (ind[i] == dim) then
		  lib.add_input(2*ow, (i+2)*wv-3*ow, 70, 30, object[dim+1])
		  lib.add_input(2*ow, (i+2)*wv-ow, 90, 30, object[dim])		  
      else
		  lib.add_input(2*ow, (i+2)*wv-2*ow, 70, 30, object[ind[i]])	  
      end	  
      for j = 1,2 do
	      temp = out[j][ind[i]]
          if (i == 1) then 		      
		      lib.add_text(5*ow+j*wh, (i+2)*wv-ow, temp, text_style)
		  else
		      lib.add_input(3*ow+j*wh, 2*ow+(i+1)*wv, 40, 40, lib.check_number(temp,20))
		  end	    
	  end	  
  end 

  lib.end_canvas()
end   