
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
	    result = factor3
		mid = factor1 + result
	else	
	    if (factor1 < factor3) then
	        term = factor1
		    factor1 = factor3
		    factor3 = term
	    end		
	    value = factor2 * (factor1 - factor3)
	    result = factor3
		mid = factor1 - result
	end	
	answ1 = "(" .. tostring(factor1) .. sign2 .. "x) " .. sign1 .. " " .. tostring(factor2) .. " = " .. tostring(value) .. ", " 
	answ2 = tostring(factor1) .. sign2 .. "x = " .. lib.check_number(mid,30) .. ","
end

if (ITEM == 2) then  
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 * factor1 - factor3
	    result = factor3
		mid = value + result		
	else		
	    value = factor2 * factor1 + factor3
	    result = factor3
		mid = value - result
	end	
	answ1 = "(" .. tostring(value) .. sign2 .. "x) " .. sign1 .. " " .. tostring(factor1) .. " = " .. tostring(factor2) .. ", "
	answ2 = tostring(value) .. sign2 .. "x = " .. lib.check_number(mid,30) .. ","
end

if (ITEM == 3) then  
	sign1 = "·"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 * (factor1 + factor3)
	    result = factor3
		mid = factor1 + result		
	else	
	    if (factor1 < factor3) then
	        term = factor1
		    factor1 = factor3
		    factor3 = term
	    end		
	    value = factor2 * (factor1 - factor3)
	    result = factor3
		mid = factor1 - result			
	end	
	answ1 = tostring(factor2) .. " " .. sign1 .. " (" .. tostring(factor1) .. sign2 .. "x)= " .. tostring(value) ..", "
	answ2 = tostring(factor1) .. sign2 .. "x = " .. lib.check_number(mid,30) .. ","
end

if (ITEM == 4) then  
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 * (factor1 + factor3)
	    result = factor3
		mid = factor1 + result		
	else
        if (factor1 == factor3) then
            factor3 = factor3 - 1
        end
	    if (factor1 < factor3) then
	        term = factor1
		    factor1 = factor3
		    factor3 = term
	    end		
	    value = factor2 * (factor1 - factor3)
	    result = factor3
		mid = factor1 - result		
	end	
	answ1 = tostring(value) .. " " .. sign1 .. " (" .. tostring(factor1) .. sign2 .. "x) = " ..  tostring(factor2) ..", "
	answ2 = tostring(factor1) .. sign2 .. "x = " .. lib.check_number(mid,30) .. ","
end
    