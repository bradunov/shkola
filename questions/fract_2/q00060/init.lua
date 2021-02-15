
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

include("terms")

cifre = {};
value = {};
out = {}
diff = {}

deg = math.random(3)                        --[[broj cifara deljenika]]--
denum = math.random(2)                        --[[broj decimala deljenika]]--

round = denum + math.random(2)
dec = 10^round 

if (round == 1) then
    name = decim[1]
else
    name = decim[2]	
end	



if (denum >= deg) then
    min = denum - deg + 1
	point_d = 1
else
    min = 0
	point_d = deg - denum	
end	
deg_m = deg + min	
for i = 1,deg_m+round+5 do
    cifre[i] = 0
end	

	
cifre[1 + min] = math.random(9)
number = cifre[1 + min] 
if (deg > 1) then
    for i = 2,deg do 
	    if (i == deg) then
            cifre[i+min] = math.random(9)	
        else		
            cifre[i+min] = math.random(10) - 1
		end
    number = number * 10 + cifre[i+min]
	end	
end	

fact1 = math.random(10) - 1
fact2 = math.random(8)
factor = fact1 * 10 + fact2
if (fact1 == 0) then
    defac = 1
else
    defac = 2	
end	

if (number - factor * math.floor(number/factor) == 0) then
    fact2 = fact2 + 1
	factor = factor + 1
end

fract = number/factor 
term = math.floor(fract * dec) 

if (fract*dec - term >= 0.5) then
    term = term + 1
end	

result = term/(dec * 10^denum)     
number = number/10^denum
result = lib.math.round_dec(result, round)

qq = math.floor(result)

if (qq < 10) then 
    sign = 1
end
if (qq > 9 and qq < 100) then 
    sign = 2
end
if (qq >=100) then
    sign = 3
end	
stampa = sign + round + 1

out[1] = cifre[1]
ind = 1	
bound = math.floor(number)
if (bound >= factor) then	
    if (out[1] < factor) then
        out[1] = out[1] * 10 + cifre[2]
	    ind = 2
    end	
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

index_i = deg_m + defac + stampa + 3
index_j = 2 * stampa + 1


mycanvas = function()

  lib.start_canvas(400, 350, "center")

  w = 25
  ow = 10
  
  for i = 1,index_i  do
     lib.add_line(ow+(i-1)*w, ow, 0, index_j*w, style, false, false)
  end
  
  for j = 1,index_j + 1 do
    lib.add_line(ow, ow+(j-1)*w, (index_i-1)*w, 0, style, false, false)
  end
 
  lib.add_line(ow, ow+w, (index_i-1)*w, 0, red_style, false, false)
   
  lib.add_text(w, 2*ow, tostring(math.floor(cifre[1])), text_style)
  if (deg_m > 1) then  
     for i = 2,deg_m do
         lib.add_text(i*w, 2*ow, tostring(math.floor(cifre[i])), text_style)
     end
  end
  lib.add_text(ow+point_d*w, 2*ow, point, text_style)  
  
  lib.add_text(ow+(deg_m+0.5)*w, 2*ow, ":", text_style)  
  
  if (defac == 1) then
      lib.add_text(ow+(deg_m+1.5)*w, 2*ow, tostring(math.floor(fact2)), text_style) 
  else   
      lib.add_text(ow+(deg_m+1.5)*w, 2*ow, tostring(math.floor(fact1)), text_style)
      lib.add_text(ow+(deg_m+2.5)*w, 2*ow, tostring(math.floor(fact2)), text_style)	  
  end  
	  
  fld = deg_m + defac + 1.5
  lib.add_text(ow+fld*w, 2*ow, "=", text_style)  

  for i = 1,sign do
      lib.add_input(ow+(fld+i-0.7)*w, ow, 30, 30, lib.check_number(value[i],10))
  end	
  fld =  fld+sign 
  lib.add_text((fld+1)*w, 2*ow, point, text_style)
  
  for i = 1,stampa - sign do
      lib.add_input(ow+(fld+i-0.5)*w, ow, 30, 30, lib.check_number(value[sign+i],10))
  end

x = 0
if (ind == 1) then
    x = -2
end
if (ind == 2) then
    x = -1
end    
	
  for i = 1, stampa do 
      d1 = math.floor(diff[i]/100)
	  temp = diff[i] - 100 * d1 
	  d2 = math.floor(temp/10)
	  d3 = temp - 10 * d2
      lib.add_input((x+i+1)*w, ow+(2*i-1)*w, 40, 40, lib.check_number(d3,10))	  
	  if (d1 ~= 0) then 
         lib.add_input((x+i-1)*w, ow+(2*i-1)*w, 40, 40, lib.check_number(d1,10))
         lib.add_input((x+i)*w, ow+(2*i-1)*w, 40, 40, lib.check_number(d2,10))
      else
	     if (d2 ~= 0) then 
		     lib.add_input((x+i)*w, ow+(2*i-1)*w, 40, 40, lib.check_number(d2,10))
		 end
      end 
	  if (i == 1) then
	      lib.add_line(ow+(i-1)*w, ow+2*i*w, 3*w, 0, diff_style, false, false)
	  else
	      lib.add_line(ow+(i-2)*w, ow+2*i*w, 3*w, 0, diff_style, false, false)
      end	
      t1 = math.floor(out[i+1]/10)
	  t2 = out[i+1] - 10 * t1	  
	  if (t1 ~= 0) then 
	     lib.add_input((x+i)*w, ow+2*i*w, 40, 40, lib.check_number(t1,10))
	  end
      lib.add_input((x+i+1)*w, ow+2*i*w, 40, 40, lib.check_number(t2,10))
	  if(i ~= stampa) then
         lib.add_input((x+i+2)*w, ow+2*i*w, 40, 40, lib.check_number(cifre[ind+i],10))	  
      end 	  
  end 
    
  lib.end_canvas()
end        

            
            
            
           
   
   
        
    
   
        
       
             
       