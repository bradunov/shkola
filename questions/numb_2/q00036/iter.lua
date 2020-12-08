
prime = {2, 3, 5, 7, 11, 13, 17, 19} 
dim = 4                                    

ind = 2                                                                                                                                                                               

number = {}
deg = {}

q = {}
value = {}



numbmax = 200
numbmin = 60

for j = 1,ind do
    number[j] = prime[4]
end	


prod = number[1]
for i = 1,dim do
    if (i < 3) then
	    max = 4
        min = 1
    else
        max = 2
        min = 0
    end	
    for j = 1, ind do
        if (number[j] >= numbmax) then
            deg[j] = 0
        else			
            deg[j]= min - 1 + math.random(max-min)
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
			prod = prod * prime[i]
		end	
	end		
end	 

     
if (number[1] > number[2]) then
    temp = math.floor(number[1]/number[2])
	rest = number[1] - temp * number[2]
	if (rest == 0) then
        number[2] = number[2] * prime[5]
        prod = prod * prime[5]
	end	
else
    temp = math.floor(number[2]/number[1])
	rest = number[2] - temp * number[1]	
	if (rest == 0) then
        number[1] = number[1] * prime[5]
        prod = prod * prime[5]
	end	
end
 
for i = 1,ind do
    value[i] = prod/number[i]
end	    

if (value[1] == 1) then
    temp = number[2]
	number[2] = number[1]
	number[1] = temp
	temp = value[2]
	value[2] = value[1]
	value[1] = temp
end	
      
if (value[2] == 1) then
    result = math.floor(value[1])
else           
    result = number[2]
end	
      
      
                 
   
        
       
             
       