
sign = {"veći", "manji"}

factor1 = math.random(8) + 2
factor2 = math.random(140 - factor1*10) + 60

prod = factor1 * factor2
dif = prod - factor1

ind = math.random(2)

if (ind == 1) then 
    term1 = prod
    term2 = factor1 
    result1 = factor2
else 
    term1 = factor1
	term2 = prod
	result1 = factor2  
end	  	
            
if (ind == 1) then 
    term3 = prod
    term4 = factor1 
    result2 = dif
else 
    term3 = factor1
	term4 = prod
	result2 = dif  
end	  

 
         
      