
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
value = {};
out = {}
diff = {}

deg = 4
min = 10^(deg-1)
max = 10^deg

result = min + math.random(max - min)
factor = 1 + math.random(8)
rest = 0  --[[za deljenje sa ostatkom rest=math.random(factor-1) ]]--
number = result * factor + rest

index = deg + 1


temp = number
for i = 1,index do
    quot = math.floor(temp/10)
    cifre[index + 1 - i] = temp - quot * 10
    temp = quot	 
end

if (cifre[1] < factor) then
    out[1] = cifre[1] * 10 + cifre[2]
	stampa = deg 
	ind = 2
else
    out[1] = cifre[1]
	stampa = deg + 1 
	ind = 1
end	

temp = out[1]
for i = 1, stampa do   
	value[i] = math.floor(temp/factor)
	diff[i] = value[i] * factor
    out[i+1] = temp - diff[i] 
	if(i ~= stampa) then
	   temp = out[i+1] * 10 + cifre[ind+i]
    end
end	
	
index_out = index + deg + 4

mycanvas = function()

  lib.start_canvas(350, 350, "center")

  w = 25
  ow = 10
  
  for i = 1,index_out + 1 do
     lib.add_line(ow+(i-1)*w, ow, 0, (2*stampa+1)*w, style, false, false)
  end
  
  for i = 1,2*stampa + 2 do
    lib.add_line(ow, ow+(i-1)*w, index_out*w, 0, style, false, false)
  end
  lib.add_line(ow, ow+w, index_out*w, 0, red_style, false, false)
  lib.add_text(ow+(index+1.5)*w, 2*ow, ":", text_style)
  lib.add_text(ow+(index+2.5)*w, 2*ow, tostring(math.floor(factor)), text_style)
  lib.add_text(ow+(index+3.5)*w, 2*ow, "=", text_style)  

  if(cifre[1] ~= 0) then
     lib.add_text(2*w, 2*ow, tostring(math.floor(cifre[1])), text_style)
  end
  
  for i = 2,index do
      lib.add_text(w+i*w, 2*ow, tostring(math.floor(cifre[i])), text_style)
  end

  for i = 1,deg do
      lib.add_input(ow+(index+3+i)*w, ow, 30, 30, lib.check_number(value[i],15))
  end

  for i = 1, stampa do 
      quot = math.floor(diff[i]/10)
	  temp = diff[i] - 10 * quot 
      lib.add_input(w+i*w, ow+(2*i-1)*w, 40, 40, lib.check_number(temp,15))
	  if (quot ~= 0) then 
         lib.add_input(w+(i-1)*w, ow+(2*i-1)*w, 40, 40, lib.check_number(quot,15))
      end 
	  lib.add_line(ow+i*w, ow+2*i*w, 2*w, 0, diff_style, false, false)
      lib.add_input((i+1)*w, ow+2*i*w, 40, 40, lib.check_number(out[i+1],15))
	  if(i ~= stampa) then
         lib.add_input((i+2)*w, ow+2*i*w, 40, 40, lib.check_number(cifre[ind+i],15))	  
      end 	  
  end 
  
  lib.end_canvas()
end
                  
            
   
        
       
             
       