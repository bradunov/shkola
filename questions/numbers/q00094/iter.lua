include("terms")


factor1 = math.random(5) + 2
factor2 = math.random(8) + 2
factor3 = math.random(101 - factor1*10) + 101
factor4 = math.random(101 - factor2*10) + 61

prod1 = factor1 * factor3
prod2 = factor2 * factor4


ind1 = math.random(2)

if (ind1 == 1) then 
    term1 = prod1
    term2 = factor1 
    result1 = factor3
else 
    term1 = factor3
	term2 = factor1
	result1 = prod1  
end	  	
            
ind2 = math.random(2)

if (ind2 == 1) then 
    term3 = prod2
    term4 = factor2 
    result2 = factor4
else 
    term3 = factor4
	term4 = factor2
	result2 = prod2  
end	  

ind = math.random(2) + 2

if (ind == 4 and result1 < result2) then
    temp = term3
	term3 = term1
	term1 = temp
	temp = term4
	term4 = term2
	term2 = temp
	temp = result1
	result1 = result2
	result2 = temp
	temp = ind1
	ind1 = ind2
	ind2 = temp
end	


if (ind == 3) then 
    result = result1 + result2
else	
    result = result1 - result2 
end	              
       