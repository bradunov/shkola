
sign1 = " "
operat = {"+", "-"}

factor1 = math.random(7) + 2
factor2 = math.random(11 - factor1)*10 + 10
factor3 = math.random(7) + 2

ind = math.random(2)

if (ITEM == 1) then  
	sign1 = "·"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 * (factor1 + factor3)
	    result = factor2
	else
        if (factor1 == factor3) then
            factor1 = factor1 - 2
        end			
	    if (factor1 < factor3) then
	        term = factor1
		    factor1 = factor3
		    factor3 = term
	    end	
	    value = factor2 * (factor1 - factor3)
	    result = factor2
	end	
	answ = "x " .. sign1 .. " ( " .. tostring(factor1) .. " " .. sign2 .. " " .. tostring(factor3) .. " ) = " ..  tostring(value)
end

if (ITEM == 2) then  
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 * (factor1 + factor3)
	    result = value
	else
        if (factor1 == factor3) then
            factor3 = factor3 - 2
        end
	    if (factor1 < factor3) then
	        term = factor1
		    factor1 = factor3
		    factor3 = term
	    end		
	    value = factor2 * (factor1 - factor3)
	    result = value
	end	
	answ = "x " .. sign1 .. " ( " .. tostring(factor1) .. " " .. sign2 .. " " .. tostring(factor3) .. " ) = " ..  tostring(factor2)
end

if (ITEM == 3) then  
	sign1 = "·"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 * (factor1 + factor3)
	    result = factor2
	else
        if (factor1 == factor3) then
            factor1 = factor1 - 2
        end					
	    if (factor1 < factor3) then
	        term = factor1
		    factor1 = factor3
		    factor3 = term
	    end	
	    value = factor2 * (factor1 - factor3)
	    result = factor2
	end	
	answ = "( " .. tostring(factor1) .. " " .. sign2 .. " " .. tostring(factor3) .. " ) " .. sign1 .. " x = " .. tostring(value)
end

if (ITEM == 4) then  
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 * factor1 - factor3
	    result = factor1
	else		
	    value = factor2 * factor1 + factor3
	    result = factor1
	end	
	answ = "( " .. tostring(value) .. " " .. sign2 .. " " .. tostring(factor3) .. " ) " .. sign1 .. " x = " .. tostring(factor2)
end

    
     