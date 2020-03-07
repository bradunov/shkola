
sign = {"·", ":"}

factor1 = math.random(7) + 2
factor2 = (1 + math.random(11 - factor1)) *5
factor3 = math.random(5) + 2


if (ITEM == 1) then  
	value = factor1 * factor2
	result = factor2 * factor3 
	answ = "( x " .. sign[1] .. " " .. tostring(factor1) .. " ) " .. sign[2] .. " " .. tostring(factor3) .. " = " ..  tostring(value)
end

if (ITEM == 2) then  
    value = factor1 * factor2 
	result = factor2 * factor3
	answ = "( x " .. sign[2] .. " " .. tostring(factor3) .. " ) " .. sign[1] .. " " .. tostring(factor1) .. " = " ..  tostring(value)
end

if (ITEM == 3) then  
	value = factor2 * factor1 * factor3
	result = factor1
	answ = tostring(value) .. " " .. sign[2] .. " ( " .. tostring(factor3) .. " " .. sign[1] .. " x ) = " .. tostring(factor2)
end

if (ITEM == 4) then 
    temp = factor2 * factor1 
	value = factor2 * factor3
    result = factor3
	answ = tostring(factor1) .. " " .. sign[1] .. " ( " .. tostring(value) .. " " .. sign[2] .. " x ) = " .. tostring(temp)
end

                 
                  
       
    
    
     