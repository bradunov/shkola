
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

text_style = {["font_size"] = "16"}

cifre = {};
number = {};

deg = 5
min = 10^(deg-1)
max = 10^deg

stampa = 1

for i = 1,stampa do
    number[i] = min + math.random(max - min)
end

factor = 1 + math.random(8)
number[stampa+1] = number[1] * factor



index = deg + 1
index_out = index + 2

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

  w = 40
  ow = 10
  
  for i = 1,index_out + 1 do
     lib.add_line(ow+(i-1)*w, ow, 0, (stampa+1)*w, style, false, false)
  end
  
  for i = 1,stampa + 2 do
    lib.add_line(ow, ow+(i-1)*w, index_out*w, 0, style, false, false)
  end
  lib.add_line(ow, ow+stampa*w, index_out*w, 0, diff_style, false, false)
  lib.add_text((index_out-1)*w-ow, 3*ow+(stampa-1)*w, "*", text_style)
  lib.add_text(index_out*w, 3*ow+(stampa-1)*w, tostring(math.floor(factor)), text_style)  
			  
  for j = 1,stampa+1 do
      imin = 2
	  if (j == stampa+1 and cifre[j][1] ~= 0) then
	      imin = 1
	  end

      for i = imin,index do
	      if (j == 1) then 
              if (i == 4) then 
		          lib.add_input(ow+(i-1)*w, 2*ow+(j-1)*w, 40, 40, lib.check_number(cifre[j][i],20))
		      else			  
		          text = tostring(math.floor(cifre[j][i]))
		          lib.add_text(3*ow+(i-1)*w, 3*ow+(j-1)*w, text, text_style)
              end
		  else
              if (i == 2 or i == 6) then 
		          lib.add_input(ow+(i-1)*w, 2*ow+(j-1)*w, 40, 40, lib.check_number(cifre[j][i],20))
		      else			  
		          text = tostring(math.floor(cifre[j][i]))
		          lib.add_text(3*ow+(i-1)*w, 3*ow+(j-1)*w, text, text_style)
              end		  
		  end	 
	  end	  
  end

  lib.end_canvas()
end      
   
   
        
       
            
       