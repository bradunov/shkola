
red_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "3"};			

text_style = {["font_size"] = "16"}

prime = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97}
dim = 10                                    --[[25]]--

ind = 2

number = {}
deg = {}
divid = {}
term = {}
q = {}

numbmax = 50000
stampa = 8

for j = 1,ind do
    number[j] = 1
end	

sum = 0
prod = 1
for i = 1,dim do
    if (i < 4) then
	    max = 3
    else
        max = 2
    end	
    for j = 1, ind do
        if (number[j] >= numbmax or sum > stampa) then
            deg[j] = 0
        else			
            deg[j]= math.random(max) - 1
		end	
	    if (deg[j] > 0) then
	        for k = 1,deg[j] do
                number[j] = number[j] * prime[i]
	        end
	    end	
    end
	q = lib.math.argsort(deg)
	if (deg[q[ind]] ~= 0) then
        for k = 1,deg[q[ind]] do
			sum = sum + 1		
		    divid[sum] = prime[i]
			prod = prod * divid[sum]
		end	
	end	               		
end	

mycanvas = function()

  lib.start_canvas(350, 320, "center")

  v = 100
  w = 30
  ow = 10

  lib.add_line(3*v-ow, ow, 0, (sum+1)*w, red_style, false, false)

  for j = 1,ind do 
      lib.add_text(v/(ind-1)+(2-ind)*ow + (j-1)*v, w, tostring(math.floor(number[j])), text_style) 	  
  end		  
  

  x = (2 - ind + 2/(ind-1)) * w
  y = 2 * ow
  z = 3 * v 
  
  for j = 1,ind do
      term[j] = number[j]  
  end	  

  for i = 1, sum do
	  lib.add_input(z, y, 40, 30, lib.check_number(divid[i],20))  
	  for j = 1, ind do 
		  temp = math.floor(term[j]/divid[i])
          rest = term[j] - temp * divid[i]
          if (rest == 0) then 	
              term[j] = temp
		  end	  
          lib.add_input(x+(j-1)*v, y+w, 80, 30, lib.check_number(term[j],60))	
      end
      y = y + w				  
   end	   
   
  lib.end_canvas()
end 
                     
               
     

  
            
            
            
   
        
       
             
       