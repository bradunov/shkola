
sign = {"·", ":"}

factor1 = math.random(7) + 2
factor2 = (1 + math.random(10 - factor1)) *5
factor3 = math.random(5) + 2


if (ITEM == 1) then  
	value = factor1 * factor2
	result = factor2 * factor3 
	mid = value * factor3
	answ1 = "(x " .. sign[1] .. " " .. tostring(factor1) .. ") " .. sign[2] .. " " .. tostring(factor3) .. " = " ..  tostring(value) .. ","
    answ2 = "x " .. sign[1] .. " " .. tostring(factor1) .. " = " .. lib.check_number(mid) .. ","
end

if (ITEM == 2) then  
    value = factor1 * factor2 
	result = factor2 * factor3
	answ1 = "(x " .. sign[2] .. " " .. tostring(factor3) .. ") " .. sign[1] .. " " .. tostring(factor1) .. " = " ..  tostring(value) .. ","
    answ2 = "x " .. sign[2] .. " " .. tostring(factor3) .. " = " .. lib.check_number(factor2) .. ","
end

if (ITEM == 3) then  
	value = factor2 * factor1 * factor3
	result = factor1
	mid = factor1 * factor3
	answ1 = tostring(value) .. " " .. sign[2] .. " (" .. tostring(factor3) .. " " .. sign[1] .. " x) = " .. tostring(factor2) .. ","
    answ2 = tostring(factor3) .. " " .. sign[1] .. " x = " .. lib.check_number(mid) .. ","
end

if (ITEM == 4) then 
    temp = factor2 * factor1 
	value = factor2 * factor3
    result = factor3
	answ1 = tostring(factor1) .. " " .. sign[1] .. " (" .. tostring(value) .. " " .. sign[2] .. " x) = " .. tostring(temp) .. ","
    answ2 = tostring(value) .. " " .. sign[2] .. " x = " .. lib.check_number(factor2) .. ","
end
   

                 
                  
       
    
    
     