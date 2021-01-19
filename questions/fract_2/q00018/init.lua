
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


cifre_whl = {};
cifre_dec = {};
number = {};
out = {};
com = {}
wom = {}

ind = math.random(2)

degg = 4
minn = 10
maxx = 10^degg

stampa = 2

if (ind == 1) then
    sign = "+"
	mini = 1
	maxi = stampa
else
    sign = "-"	
	mini = 2
	maxi = stampa + 1	
end	

summ = 0
comma = 0
for i = mini,maxi do
    com[i] = math.random(3)
    number[i] = (minn + math.random(maxx - minn)) / 10^com[i]  
	summ = summ + number[i]
	if (com[i] > comma) then 
	    comma = com[i]
	end	
end
if (ind == 1) then
    number[stampa+1] = summ
	com[stampa+1] = comma
else
    number[1] = summ
	com[1] = comma	
end
result = number[stampa+1]	

for i = 1,stampa+1 do
    cifre_whl[i] = {}	
    part_w = math.floor(number[i])
	part_d = number[i] - part_w                                            
    for j = 1,degg do
         rest = math.floor(part_w/10)
		 cifre_whl[i][j] = part_w - rest * 10
		 part_w = rest
    end	

wom[i] = 0
sw = 0
for j = 1,degg do
    sw = sw + cifre_whl[i][degg+1-j]	
    if (sw == 0 ) then
	    wom[i] = wom[i] + 1
	end	
end	

    cifre_dec[i] = {}	
    for j = 1,com[i] do
	     if (j == com[i]) then
		    cifre_dec[i][j] = lib.math.round(part_d*10)		 
		 else		 
		    cifre_dec[i][j] = math.floor(part_d*10)
         end			
		 part_d = part_d * 10 - cifre_dec[i][j]
    end	
end

index = degg + 1 + comma

for i = 1,index do
    out[i] = stampa + 1                  --[[math.random(stampa)]]--
end	
      

mycanvas = function()

  lib.start_canvas(350, 150, "center")

  w = 35
  ow = 10
  
  for i = 1,index + 2 do
     lib.add_line(ow+(i-1)*w, ow, 0, (stampa+1)*w, style, false, false)
  end
  
  for i = 1,stampa + 2 do
    lib.add_line(ow, ow+(i-1)*w, (index+1)*w, 0, style, false, false)
  end
  lib.add_line(ow, ow+stampa*w, (index+1)*w, 0, diff_style, false, false)
  lib.add_text(3*ow, 3*ow+(stampa-1)*w, sign, text_style)
			  
  for j = 1,stampa+1 do
	  lib.add_text(2*ow+(degg+1)*w, 3*ow+(j-1)*w, ",", text_style)	

      if (wom[j] == degg) then
	      max = 1
	  else	  
	      max = degg-wom[j]
	  end
	  
      for i = 1,max do
	      x = degg + 1 - i
		  lib.add_input(ow+x*w-5, 2*ow+(j-1)*w-5, 40, 40, lib.check_number(cifre_whl[j][i],15))	    
	  end
      for i = degg+1,degg+com[j] do
	      temp = cifre_dec[j][i-degg]
		  lib.add_input(ow+(i+1)*w-5, 2*ow+(j-1)*w-5, 40, 40, lib.check_number(temp,15))    
	  end	  
  end

  lib.end_canvas()
end
            
            
       