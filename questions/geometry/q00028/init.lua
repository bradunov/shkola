
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};

text_style = {["font_size"] = "16"}

colour_style = {["off_color"] = "f90",
                ["font_size"] = "16"}

object = {"Kocka", "Kvadar"}
title = {" strana." , " ivica.", " temena.", " sve ivice jednake.", " sve strane podudarne.", " naspramne strane podudarne."}

index = {1,2,3,4,5,6}
out = lib.math.random_shuffle(index)

reply = {}

numb_edge = (3 + math.random(4)) * 2
numb_area = (2 + math.random(3)) * 2
numb_knot = (2 + math.random(3)) * 2

dim = 6

mycanvas = function()

  lib.start_canvas(350, 350, "center")

  wh = 100
  wv = 40
  ow = 10
  


    lib.add_line(2, ow, 3*ow+3*wh+8, 0, style, false, false)

for i = 1,7 do
    lib.add_line(2, i*(wv+ow), 3*ow+3*wh+8, 0, style, false, false)
  end
  
  lib.add_line(2, ow, 0, 17*wv/2, style, false, false)
  lib.add_line(2*wh+2*wv+2*ow, ow, 0, 17*wv/2, style, false, false)
  lib.add_line(4*ow+3*wh, ow, 0, 17*wv/2, style, false, false)
  
  lib.add_text(3*wv, 3*ow, "Tvrđenje", text_style)
  lib.add_text(2*(wh+wv+2*ow), 3*ow, "t / n", text_style)
  
  for i = 1,dim do
      ind = math.random(2)
	  reply[i] = " ima " 
	  x = wv + 2*ow
      if (out[i] == 1) then 
          reply[i] = reply[i] .. tostring(numb_area) .. title[1]
		  if (numb_area == 6) then
		      answ = "t"
		  else 
              answ = "n"
          end			  
      end
      if (out[i] == 2) then 
          reply[i] = reply[i] .. tostring(numb_edge) .. title[2]
		  if (numb_edge == 12) then
		      answ = "t"
		  else 
              answ = "n"
          end			  
      end	  
      if (out[i] == 3) then 
          reply[i] = reply[i] .. tostring(numb_knot) .. title[3]
		  if (numb_knot == 8) then
		      answ = "t"
		  else 
              answ = "n"
          end			  
      end	
      if (out[i] == 4) then 
          reply[i] = reply[i] .. title[4]
		  x = wv/2
		  if (ind == 1) then
		      answ = "t"
		  else 
              answ = "n"
          end			  
      end	  	    	  
      if (out[i] == 5) then 
          reply[i] = reply[i] .. title[5]
		  x = wv/2
		  if (ind == 1) then
		      answ = "t"
		  else 
              answ = "n"
          end			  
      end	  	    
      if (out[i] == 6) then 
          reply[i] = reply[i] .. title[6]
		  x = 0
		  answ = "t"		  
      end
      lib.add_text(3*ow, 2*ow+i*(wv+ow), object[ind], colour_style)
   	  lib.add_text(8*ow+wh-x, 2*ow+i*(wv+ow), reply[i], text_style)	  	  
	  lib.add_input(2*(wv+wh+ow), ow+i*(wv+ow),40, 40, lib.check_string(answ,15))	  
  end 

  lib.end_canvas()
end
    
          