
measure = {"l", "dl", "cl", "ml"}

dim = {""}
number = {};
value = {};
out = {};

stampa = 6

index = stampa

for i = 1, stampa do
    ind = math.random(4)
	if(ind == 4) then
	   temp = 10^3
	else 
       temp = 10^ind	
	end   
    value[i] = 2*(ind-1) + math.random(temp)
    number[i] = value[i] * 10^(4-ind)
	if (i > 1) then
	    for j = 1, i-1 do
		    if (number[i] == number[j]) then
			   	index = index - 1
			    number[i] = index 
				ind = 4				
				value[i] = number[i]
			end
        end			
	end		
    dim[i] = measure[ind]
end		
 
out = lib.math.argsort(number);

  