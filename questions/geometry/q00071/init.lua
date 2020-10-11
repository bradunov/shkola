
style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};
			   
red_style = {["off_color"] = "f30",
               ["on_color"] = "f30",
               ["line_color"] = "f30",
               ["line_width"] = "3"};	
			   
blue_style = {["off_color"] = "0cf",
               ["on_color"] = "0cf",
               ["line_color"] = "0cf",
               ["line_width"] = "3"};	

brown_style = {["off_color"] = "c90",
               ["on_color"] = "c90",
               ["line_color"] = "c90",
               ["line_width"] = "3"};	

red_line = {["off_color"] = "none",
               ["on_color"] = "fff",
               ["line_color"] = "f30",
               ["line_width"] = "3"};			   

blue_line = {["off_color"] = "none",
               ["on_color"] = "fff",
               ["line_color"] = "0cf",
               ["line_width"] = "3"};	

brown_line = {["off_color"] = "none",
               ["on_color"] = "fff",
               ["line_color"] = "c90",
               ["line_width"] = "3"};	

text_style = {["font_size"] = "16"}


v = 5
w = 18
ow = 10

start = {4,8,12}
xs = {start[1]*w-ow, start[2]*w-ow, start[3]*w-ow}
ys = {ow, ow, ow}

min = ow
max = 15*w - ow
stampa = 15
step = 4

mycanvas = function()

  lib.start_canvas(280, 290, "center")
  
  for i = 1,14 do
    lib.add_line(ow, 3*ow+(i-1)*w, 14*w, 0, style, false, false)
  end

  for i = 1,15 do
    lib.add_line(ow+(i-1)*w, 3*ow, 0, 13*w, style, false, false)
  end

--[[ red ]]--

  lib.add_circle(xs[1], ys[1], 3, red_style, true, false)
  lib.add_triangle(xs[1], ys[1]+ow, ow, ow, red_style, true, false)

  x = xs[1]
  y = ys[1]+w
  numb_red = 1

  for i = 1, stampa do
      if (y ~= max) then
         ind = (i-1) % 2 
	     if (ind == 1) then 		 
		     yad = 0	  
		     sign = math.random(2)	  
             temp = math.random(step) 
			 xad = temp * w			 
			 numb_red = numb_red + temp			 			 
			 if (x + xad > max) then
			     sign = 2
		     end
			 if (x - xad < min) then
			     sign = 1
		     end				 
		     if (sign == 2) then
		         xad = - xad
		     end			 
	     else
             xad = 0 	  
	         temp = math.random(step)
			 yad = temp * w
             if (y + yad >= max) then
                 yad = max - y	
                 temp = math.floor(yad/w) 	
             end				 
             numb_red = numb_red + temp			 
	     end 	  
         lib.add_straight_path(x, y, {{xad,yad}}, red_line, false, false)
	     x = x + xad
	     y = y + yad
	  end
  end

--[[ blue ]]--

  lib.add_circle(xs[2], ys[2], 3, blue_style, true, false)
  lib.add_triangle(xs[2], ys[2]+ow, ow, ow, blue_style, true, false)

  x = xs[2]
  y = ys[2]+w
  numb_blue = 1

  for i = 1, stampa do
      if (y ~= max) then
         ind = (i-1) % 2 
	     if (ind == 1) then 		 
		     yad = 0	  
		     sign = math.random(2)	  
             temp = math.random(step) 
			 xad = temp * w			 
			 numb_blue = numb_blue + temp			 			 
			 if (x + xad > max) then
			     sign = 2
		     end
			 if (x - xad < min) then
			     sign = 1
		     end				 
		     if (sign == 2) then
		         xad = - xad
		     end			 
	     else
             xad = 0 	  
	         temp = math.random(step)
			 yad = temp * w
             if (y + yad >= max) then
                 yad = max - y	
                 temp = math.floor(yad/w) 	
             end				 
             numb_blue = numb_blue + temp			 
	     end 	  
         lib.add_straight_path(x, y, {{xad,yad}}, blue_line, false, false)
	     x = x + xad
	     y = y + yad
	  end
  end

--[[ brown ]]--

  lib.add_circle(xs[3], ys[3], 3, brown_style, true, false)
  lib.add_triangle(xs[3], ys[3]+ow, ow, ow, brown_style, true, false)

  x = xs[3]
  y = ys[3]+w
  numb_brown = 1

  for i = 1, stampa do
      if (y ~= max) then
         ind = (i-1) % 2 
	     if (ind == 1) then 		 
		     yad = 0	  
		     sign = math.random(2)	  
             temp = math.random(step) 
			 xad = temp * w			 
			 numb_brown = numb_brown + temp			 			 
			 if (x + xad > max) then
			     sign = 2
		     end
			 if (x - xad < min) then
			     sign = 1
		     end				 
		     if (sign == 2) then
		         xad = - xad
		     end			 
	     else
             xad = 0 	  
	         temp = math.random(step)
			 yad = temp * w
             if (y + yad >= max) then
                 yad = max - y	
                 temp = math.floor(yad/w) 	
             end				 
             numb_brown = numb_brown + temp			 
	     end 	  
         lib.add_straight_path(x, y, {{xad,yad}}, brown_line, false, false)
	     x = x + xad
	     y = y + yad
	  end
  end

  lib.add_text(7*w+ow, 2*ow+14*w, "C I LJ", text_style, false, false)

  out = {}
  index = {} 
  fig = {"crvena", "plava", "braon"}    
  number = {numb_red, numb_blue, numb_brown}

  out = lib.math.argsort(number)

   if (number[out[1]] < number[out[2]]) then  
      first = fig[out[1]]
      answ = "Na cilj će prva stići " .. lib.check_string(first, 40) .. " figura."  
  else
      if (number[out[1]] < number[out[3]]) then
	      first = fig[out[1]]
          second = fig[out[2]] 
	      reply = "answer == '" .. first .. "' "  ..
                  "|| answer == '" .. second .. "'" ;
		  an1 = "answer = '" .. first .. "' "	
		  an2 = "answer = '" .. second .. "' "		  
	      answ = "Na cilj će prve stići " .. lib.check_string(reply, 40, an1) .. " i " .. lib.check_string(reply, 40, an2) .. " figura."	   
      else	
          answ = "Na cilj će istovremeno stići sve tri figure." 
      end	  
  end	

  lib.end_canvas()
end   		               
  
        