
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

deg = 3
min = 10^(deg-1)
max = 10^deg



result = min + math.random(max - min)

fact1 = math.random(9)
fact2 = math.random(10) - 1
factor = fact1 * 10 + fact2

rest = 0  --[[za deljenje sa ostatkom rest=math.random(factor-1) ]]--
number = result * factor + rest

index = deg + 2


temp = number
for i = 1,index do
    quot = math.floor(temp/10)
    cifre[index + 1 - i] = temp - quot * 10
    temp = quot	 
end

out[1] = cifre[1] * 10 + cifre[2] 
if (out[1] < factor) then
    out[1] = out[1] * 10 + cifre[3]
	stampa = deg 
	ind = 3
else
	stampa = deg + 1 
	ind = 2
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

  lib.start_canvas(350, 250, "center")

  w = 25
  ow = 10
  
  for i = 1,index_out + 1 do
     lib.add_line(ow+(i-1)*w, ow, 0, (2*stampa+1)*w, style, false, false)
  end
  
  for i = 1,2*stampa + 2 do
    lib.add_line(ow, ow+(i-1)*w, index_out*w, 0, style, false, false)
  end
  lib.add_line(ow, ow+w, index_out*w, 0, red_style, false, false)
  lib.add_text(ow+(index+0.5)*w, 2*ow, ":", text_style)
  lib.add_text(ow+(index+1.5)*w, 2*ow, tostring(math.floor(fact1)), text_style)
  lib.add_text(ow+(index+2.5)*w, 2*ow, tostring(math.floor(fact2)), text_style)
  lib.add_text(ow+(index+3.5)*w, 2*ow, "=", text_style)  

  if(cifre[1] ~= 0) then
     lib.add_text(w, 2*ow, tostring(math.floor(cifre[1])), text_style)
  end
  
  for i = 2,index do
      lib.add_text(i*w, 2*ow, tostring(math.floor(cifre[i])), text_style)
  end

  for i = 1,deg do
      lib.add_input(ow+(index+3+i)*w, ow, 30, 30, lib.check_number(value[i],15))
  end

  for i = 1, stampa do 
      d1 = math.floor(diff[i]/100)
	  temp = diff[i] - 100 * d1 
	  d2 = math.floor(temp/10)
	  d3 = temp - 10 * d2
      lib.add_input((i+1)*w, ow+(2*i-1)*w, 40, 40, lib.check_number(d3,15))	  
	  if (d1 ~= 0) then 
         lib.add_input((i-1)*w, ow+(2*i-1)*w, 40, 40, lib.check_number(d1,15))
         lib.add_input(i*w, ow+(2*i-1)*w, 40, 40, lib.check_number(d2,15))
      else
	     if (d2 ~= 0) then 
		     lib.add_input(i*w, ow+(2*i-1)*w, 40, 40, lib.check_number(d2,15))
		 end
      end 
	  lib.add_line(ow+(i-1)*w, ow+2*i*w, 3*w, 0, diff_style, false, false)
      t1 = math.floor(out[i+1]/10)
	  t2 = out[i+1] - 10 * t1	  
	  if (t1 ~= 0) then 
	     lib.add_input(i*w, ow+2*i*w, 40, 40, lib.check_number(t1,15))
	  end
      lib.add_input((i+1)*w, ow+2*i*w, 40, 40, lib.check_number(t2,15))
	  if(i ~= stampa) then
         lib.add_input((i+2)*w, ow+2*i*w, 40, 40, lib.check_number(cifre[ind+i],15))	  
      end 	  
  end 
  
  lib.end_canvas()
end      
     
            
            
   
        
       
             
       