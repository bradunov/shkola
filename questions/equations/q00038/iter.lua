
sign1 = " "
operat = {"+", "-"}

factor1 = math.random(15) + 4
factor2 = math.random(99 - factor1)*10 + 91
factor3 = math.random(15) + 4

ind = math.random(2)

if (ITEM == 1) then  
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = (factor2 - factor1) * factor3
	else		
	    value = (factor2 + factor1) * factor3
	end	
	result =  factor3	
	answ = tostring(value) .. " " .. sign1 .. " x " .. sign2 .. " " .. tostring(factor1) .. " = " .. tostring(factor2)
end

if (ITEM == 2) then  
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = (factor2 + factor1) * factor3
	else		
	    value = (factor2 - factor1) * factor3
	end	
	result = factor2
	answ = tostring(value) .. " " .. sign1 .. " (x " .. sign2 .. " " .. tostring(factor1) .. "  ) = " .. tostring(factor3)
end

if (ITEM == 3) then  
    sign1 = "·"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor1 * factor2 + factor3 
	else
		value = factor1 * factor2 - factor3 
	end
	result = factor2	
	answ = tostring(factor1) .. " " .. sign1 .. " x " .. sign2 .. " " .. tostring(factor3) .. " = " ..  tostring(value)
end

if (ITEM == 4) then  
    sign1 = "·"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor1 * (factor2 + factor3) 
	else
	    value = factor1 * (factor2 - factor3) 
	end	
	result = factor2	
	answ = tostring(factor1) .. " " .. sign1 .. " (x " .. sign2 .. " " .. tostring(factor3) .. ") = " ..  tostring(value)
end
       
  


    
     