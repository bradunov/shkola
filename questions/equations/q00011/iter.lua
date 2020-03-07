
sign = {"·", ":"}

factor1 = math.random(7) + 2
factor2 = (1 + math.random(11 - factor1)) *5
factor3 = math.random(5) + 2


if (ITEM == 1) then  
    temp = factor2 * factor3
	value = factor1 * factor2
	result = factor1
	answ = "x " .. sign[1] .. " ( " .. tostring(temp) .. " " .. sign[2] .. " " .. tostring(factor3) .. " ) = " ..  tostring(value)
end

if (ITEM == 2) then  
    value = factor1 * factor2 *factor3
	result = value
	answ = "x " .. sign[2] .. " ( " .. tostring(factor1) .. " " .. sign[1] .. " " .. tostring(factor3) .. " ) = " ..  tostring(factor2)
end

if (ITEM == 3) then  
    temp = factor2 * factor3
	value = factor2 * factor1
	result = factor1
	answ = "( " .. tostring(temp) .. " " .. sign[2] .. " " .. tostring(factor3) .. " ) " .. sign[1] .. " x = " .. tostring(value)
end

if (ITEM == 4) then  
    temp = factor2 * factor1
	value = factor2 * factor3
    result = factor1
	answ = "( " .. tostring(temp) .. " " .. sign[1] .. " " .. tostring(factor3) .. " ) " .. sign[2] .. " x = " .. tostring(value)
end

     
    
    
     