
sign1 = " "
operat = {"+", "-"}

factor1 = math.random(15) + 4
factor2 = math.random(99 - factor1)*10 + 91
factor3 = math.random(15) + 4

ind = math.random(2)

if (ITEM == 1) then  
    sign1 = "·"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = (factor2 + factor3) * factor1
	else
	    value = (factor2 - factor3) * factor1 
	end	
	result = factor3	
	answ = " (" .. tostring(factor2) .. " " .. sign2 .. " x) " .. sign1 .. " " .. tostring(factor1) .. " = " ..  tostring(value)
end

if (ITEM == 2) then  
    sign1 = "·"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 + factor3 * factor1
	else
	    temp = factor3 * factor1
        if (factor2 <= temp) then
            factor2 = temp + 11 + math.random(19)
        end			
	    value = factor2 - temp 
	end
	result = factor3	
	answ = tostring(factor2) .. " " .. sign2 .. " x " .. sign1 .. " " .. tostring(factor1) .. " = " ..  tostring(value)
end

if (ITEM == 3) then  
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 * factor1 - factor3
	else		
	    value = factor2 * factor1 + factor3
	end	
	result = factor3
	answ = "( " .. tostring(value) .. " " .. sign2 .. " x) " .. sign1 .. " " .. tostring(factor1) .. " = " .. tostring(factor2)
end

if (ITEM == 4) then  
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 + factor3
	else		
	    value = factor2 - factor3
	end	
	result = factor1 * factor3	
	answ = tostring(factor2) .. " " .. sign2 .. " x " .. sign1 .. " " .. tostring(factor1) .. " = " .. tostring(value)
end
     
  


    
     