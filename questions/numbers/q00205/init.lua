
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

red_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "2"};			

text_style = {["font_size"] = "16"}

cifre = {};
number = {};
fact = {}

deg = 5
min = 10^(deg-1)
max = 10^deg

stampa = 3

number[1] = min + math.random(max - min)

factor = 0
for i = 1, stampa - 1 do
    fact[i] = math.random(9)
	number[stampa + 1 - i] = number[1] * fact[i] * 10^(stampa-1-i)
	factor = factor * 10 + fact[i]
end

number[stampa+1] = number[1] * factor


index = deg + stampa - 1
index_out = index + stampa

for i = 1,stampa+1 do
cifre[i] = {}
    temp = number[i]
    for j = 1,index do
         rest = math.floor(temp/10)
		 cifre[i][index+1-j] = temp - rest * 10
		 temp = rest
    end		 
end


mycanvas = function()

  lib.start_canvas(350, 250, "center")

  w = 30
  ow = 10
  
  for i = 1,index_out + 1 do
     lib.add_line(ow+(i-1)*w, ow, 0, (stampa+1)*w, style, false, false)
  end
  
  for i = 1,stampa + 2 do
    lib.add_line(ow, ow+(i-1)*w, index_out*w, 0, style, false, false)
  end
  lib.add_line(ow, ow+w, index_out*w, 0, red_style, false, false)
   lib.add_line(ow, ow+stampa*w, index_out*w, 0, diff_style, false, false)
  lib.add_text((index+1)*w-5, w-4, "*", text_style)
  for j = 1,stampa-1 do
      lib.add_text((index+1+j)*w-5, w-4, tostring(math.floor(fact[j])), text_style)  
  end			  
  for j = 1,stampa + 1 do
      imin = 1
	  imax = index 
	  if (j > 2 and j <= stampa) then
	      imax = imax + 2 - j
	  end	
  
      for i = 1, imax do      
	      if (cifre[j][imax + 1 - i] ~= 0) then
	          imin = imax + 1 - i
		  end	  
	  end	
	  
      for i = imin,imax do
          if (j ~= 1) then 
		      lib.add_input(ow+(i-1)*w-5, ow+(j-1)*w+2, 40, 40, lib.check_number(cifre[j][i],15))
		  else			  
		      text = tostring(math.floor(cifre[j][i]))
		      lib.add_text(3*ow+(i-1)*w-5, 3*ow+(j-1)*w-5, text, text_style)

		  end	 
	  end	  
  end

  lib.end_canvas()
end
       
              
   
        
       
            
       