
include("terms")

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
               ["line_width"] = "4"};			   

blue_line = {["off_color"] = "none",
               ["on_color"] = "fff",
               ["line_color"] = "0cf",
               ["line_width"] = "3"};	

brown_line = {["off_color"] = "none",
               ["on_color"] = "fff",
               ["line_color"] = "c90",
               ["line_width"] = "2"};	

text_style = {["font_size"] = "16"}

number = {}
out = {}

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

	for j = 1,3 do
	  if (j == 1) then
		  figstyle = red_style
		  linestyle = red_line
	  else
		  if (j == 2) then
			  figstyle = blue_style
			  linestyle = blue_line  
		  else
			  figstyle = brown_style
			  linestyle = brown_line 
		  end
	  end	  
	  lib.add_circle(xs[j], ys[j], 3, figstyle, true, false)
	  lib.add_triangle(xs[j], ys[1]+ow, ow, ow, figstyle, true, false)

	  x = xs[j]
	  y = ys[j]+w
	  number[j] = 1

	  for i = 1, stampa do
		  if (y ~= max) then
			 ind = (i-1) % 2 
			 if (ind == 1) then 		 
				 yad = 0	  
				 sign = math.random(2)	  
				 temp = math.random(step) 
				 xad = temp * w			 
				 number[j] = number[j] + temp			 			 
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
				 number[j] = number[j] + temp			 
			 end 	  
			 lib.add_straight_path(x, y, {{xad,yad}}, linestyle, false, false)
			 x = x + xad
			 y = y + yad
		  end	  
	  end
	end  

	lib.add_text(7*w+ow, 2*ow+14*w, "C I LJ", text_style, false, false) 
	out = lib.math.argsort(number)
	if (number[out[1]] < number[out[2]]) then  
	  first = fig[out[1]]
	  answ = ans[1] .. lib.check_string(first, 50) .. ans[2]  
	else
	  if (number[out[1]] < number[out[3]]) then
		  first = fig[out[1]]
		  second = fig[out[2]] 
		  reply = "answer == '" .. first .. "' "  ..
				  "|| answer == '" .. second .. "'" ;
		  an1 = "answer = '" .. first .. "' "	
		  an2 = "answer = '" .. second .. "' "		  
		  answ = ans[1] .. lib.check_string(reply, 50, an1) .. " " .. vez .. " " .. lib.check_string(reply, 50, an2) .. ans[2]	   
	  else	
		  answ = ans[3] 
	  end	  
	end	

  lib.end_canvas()
end   		               
        
        