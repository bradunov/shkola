
prime = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97}
dim = 3                                    --[[25]]--

ind = 2

number = { }
deg = {}

numbmax = 1000
numbmin = 100

for j = 1,ind do
    number[j] = prime[6]
end	

prod = prime[6]
for i = 1,dim do
    for j = 1, ind do
	    if (j == 1) then
	        max = 4
        else
            max = 3
        end	
        if (number[j] >= numbmax) then
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
	if (deg[q[1]] ~= 0) then
        for k = 1,deg[q[1]] do	
			prod = prod * prime[i]
		end	
	end	               		
end	

sign = math.random(2)

if (number[1] < numbmin) then
    temp = dim + sign
    number[1] = number[1] * prime[temp]
end	

if (number[2] < numbmin) then
    temp = dim + 3 - sign
    number[2] = number[2] * prime[temp]
end

if (number[1] > number[2]) then  
    length = number[1]
	width = number[2]
else
    if(number[1] == number[2]) then
	   number[2] = number[2] * prime[dim + sign]
	end   
    length = number[2]
	width = number[1]	
end
   	
value = length * width/(prod * prod)
              
      
   
        
       
             
       