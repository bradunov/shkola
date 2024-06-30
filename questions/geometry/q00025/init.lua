
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

  lib.add_text(5*ow, 3*ow, title[1], text_style)
  lib.add_text(5*ow, 5*ow, title[3], text_style)

  lib.add_text(5*ow+wh, 3*ow , title[2], text_style)
  lib.add_text(5*ow+wh, 5*ow , title[5], text_style)
  lib.add_text(5*ow+wh, 7*ow , title[4], text_style)

  lib.add_text(5*ow+2*wh, 3*ow, title[2], text_style)
  lib.add_text(5*ow+2*wh, 5*ow , title[6], text_style)
  lib.add_text(5*ow+2*wh, 7*ow , title[4], text_style)
  
  for i = 1,dim do
  	  if (ind[i] == dim) then
		  lib.add_text(5*ow, (i+2)*wv-2*ow, object[dim+1], text_style)
		  lib.add_text(5*ow, (i+2)*wv, object[dim], text_style)		  
      else
		  lib.add_text(5*ow, (i+2)*wv-ow, object[ind[i]], text_style)	  
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
                
                