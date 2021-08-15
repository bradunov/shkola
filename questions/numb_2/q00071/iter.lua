
include("terms")

factor = {}
min_range = 15
max_range = 39

test = 0 
for i = 1,4 do
    factor[i] = min_range - math.random(max_range);
	if (factor[i] == 0) then 
	    factor[i] = - math.random(min_range)
	else	
	    if (factor[i] < 0) then
	        test = test + 1
		end	
	end	
end

if (test == 0) then
    ch = math.random(4)
	factor[ch] = -factor[ch]
end

prod1 = factor[1] * factor[3]
prod2 = factor[2] * factor[4]

ind1 = math.random(2)

if (ind1 == 1) then 
    term1 = prod1
    term2 = factor[1] 
    result1 = factor[3]
else 
    term1 = factor[3]
	term2 = factor[1]
	result1 = prod1  
end	  	
            
ind2 = math.random(2)

if (ind2 == 1) then 
    term3 = prod2
    term4 = factor[2] 
    result2 = factor[4]
else 
    term3 = factor[4]
	term4 = factor[2]
	result2 = prod2  
end	  

ind = math.random(2) + 2

if (ind == 3) then 
    result = result1 + result2
else	
    result = result1 - result2 
end	    