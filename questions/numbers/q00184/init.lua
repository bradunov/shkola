
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};
		
diff_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};		

text_style = {["font_size"] = "14"}

cifre = {};
number = {};
out = {};

deg = 5
min = 10^(deg-1)
max = 10^deg

stampa = 2

summ = 0
for i = 2,stampa + 1 do
    number[i] = min + math.random(max - min)
	summ = summ + number[i]
end
number[1] = summ

index = deg + 1

for i = 1,stampa+1 do
cifre[i] = {}
    temp = number[i]
    for j = 1,index do
         rest = math.floor(temp/10)
		 cifre[i][index+1-j] = temp - rest * 10
		 temp = rest
    end		 
end

for i = 1,index do
    out[i] = math.random(stampa)
end	


mycanvas = function()

  lib.start_canvas(350, 250, "center")

  w = 50
  ow = 10
  
  for i = 1,index + 1 do
     lib.add_line(ow+(i-1)*w, ow, 0, (stampa+1)*w, style, false, false)
  end
  
  for i = 1,stampa + 2 do
    lib.add_line(ow, ow+(i-1)*w, index*w, 0, style, false, false)
  end
  lib.add_line(ow, ow+stampa*w, index*w, 0, diff_style, false, false)
  lib.add_text(3*ow+5, 3*ow+(stampa-1)*w+5, "-", text_style)
			  
  for j = 1,stampa+1 do
      imin = 2
	  if (j == 1 and cifre[j][1] ~= 0) then
	      imin = 1
	  end	  
      for i = imin,index do
          if (out[i] == j) then 
		      lib.add_input(2*ow+(i-1)*w-5, 2*ow+(j-1)*w+5, 40, 40, lib.check_number(cifre[j][i],20))
		  else			  
		      text = tostring(math.floor(cifre[j][i]))
		      lib.add_text(3*ow+(i-1)*w+5, 3*ow+(j-1)*w+5, text, text_style)
		  end	    
	  end	  
  end

  lib.end_canvas()
end
   
  
            
       