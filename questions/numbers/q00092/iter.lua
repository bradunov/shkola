
answ = {""}
sign = {"&middot;", ":"}
result = {}

factor1 = math.random(5) + 2
factor2 = math.random(7) + 2
factor3 = math.random(100 - factor2*10) + 101
factor4 = math.random(4) + 1

if (ITEM == 1) then 
    term1 = factor2 * factor3
	term2 = factor2
	term3 = factor1
else
    if (ITEM == 2) then 
        term1 = factor3
	    term2 = factor1 * factor4
	    term3 = factor4
	else 
        term1 = factor2 * factor3
	    term2 = factor1
	    term3 = factor2
	end	
end	 
    
result[ITEM] = factor3 * factor1	
            
answ[1] = "( " .. tostring(term1) .. " " .. sign[2] .. " " .. tostring(term2) .. " ) " .. sign[1] .. " " .. tostring(term3) .. " = "

answ[2] = tostring(term1) .. " " .. sign[1] .. " (" .. tostring(term2) .. " " .. sign[2] .. " " .. tostring(term3) .. " ) = "
	               
answ[3] = "( " .. tostring(term1) .. " " .. sign[1] .. " " .. tostring(term2) .. " ) " .. sign[2] .. " " .. tostring(term3) .. " = "  
                
      
            
		  
			  
		  