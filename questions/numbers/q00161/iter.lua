
sign = {""}

factor1 = math.random(5) + 4
factor2 = math.random(7) + 2
factor3 = math.random(10 - factor1) + 4
factor4 = math.random(10 - factor2) + 6

prod1 = factor1 * factor3
prod2 = factor2 * factor4

sign[3] = "+"
ind = math.random(2)

if (ind == 1) then 
    term1 = factor3
    term2 = factor1 
    term3 = prod2
    term4 = factor2
	sign[1] = "·"
	sign[2] = ":"
	result = prod1 + factor4
	if (prod1 >= factor4) then
	    result = prod1 - factor4
		sign[3] = "-"
	end	
	out1 = prod1
	out2 = factor4
else 
    term1 = prod1
	term2 = factor1
	term3 = factor4
	term4 = factor2
	sign[1] = ":"
	sign[2] = "·"
	result = factor3 + prod2  
	if (prod2 <= factor3) then
	    result = factor3 - prod2
		sign[3] = "-"
	end	
    out1 = factor3
	out2 = prod2
end	  	
            
answ = tostring(math.floor(term1)) .. " " .. sign[1] .. " " .. tostring(math.floor(term2)) .. " " .. sign[3] .. " " .. tostring(math.floor(term3)) .. " " .. sign[2] .. " " .. tostring(math.floor(term4)) .." = " .. lib.check_number(out1,20) .. " " .. sign[3] .. " " .. lib.check_number(out2,20) .. " = "
	
			  
		  