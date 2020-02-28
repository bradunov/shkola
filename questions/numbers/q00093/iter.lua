
sign = {""}

factor1 = math.random(5) + 2
factor2 = math.random(8) + 2
factor3 = math.random(101 - factor1*10) + 101
factor4 = math.random(101 - factor2*10) + 61

prod1 = factor1 * factor3
prod2 = factor2 * factor4

sign[3] = "+"
ind = math.random(2)

if (ind == 1) then 
    term1 = factor3
    term2 = factor1 
    term3 = prod2
    term4 = factor2
	sign[1] = "."
	sign[2] = ":"
	result = prod1 + factor4
	if (prod1 >= factor4) then
	    result = prod1 - factor4
		sign[3] = "-"
	end	
else 
    term1 = prod1
	term2 = factor1
	term3 = factor4
	term4 = factor2
	sign[1] = ":"
	sign[2] = "."
	result = factor3 + prod2  
	if (prod2 <= factor3) then
	    result = factor3 - prod4
		sign[3] = "-"
	end	
end	  	
            
answ = tostring(term1) .. " " .. sign[1] .. " " .. tostring(term2) .. " " .. sign[3] .. " " .. tostring(term3) .. sign[2] .. " " .. tostring(term4) .." = "
  
		  
			  
		  