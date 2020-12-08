
prime = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97}
dim = 7                                    --[[25]]--

ind = 4

number = {}
deg = {}
value = {}

q = {}

numbmax = 5000

for j = 1,ind do
    number[j] = prime[5]
end	

prod = prime[5]
for i = 1,dim do
    if (i < 4) then
	    max = 4
		min = 1
    else
        max = 3
		min = 0		
    end	
    for j = 1, ind do
        if (number[j] >= numbmax) then
            deg[j] = 0
        else			
            deg[j]= min - 1 + math.random(max) 
		end	
	    if (deg[j] > 0) then
	        for k = 1,deg[j] do
                number[j] = number[j] * prime[i]
	        end
	    end	
    end
	q = lib.math.argsort(deg)
	if (deg[q[1]] ~= 0) then
        for k = 1,deg[q[1]] do
			prod = prod * prime[i]
		end	
	end	               		
end			
		
for j = 1,ind do		
    value[j] = number[j]/prod
end	

 
            
            
            
   
        
       
             
       