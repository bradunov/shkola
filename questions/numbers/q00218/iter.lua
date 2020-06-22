
if (ITEM == 1) then
    quest = tostring(number3) .. " + " .. tostring(number4) .. " : " .. tostring(number1) .. " - " .. tostring(number2) 
    result = number3 + number4 / number1 - number2	
end  

if (ITEM == 2) then
    quest = "(" .. tostring(number3) .. " + " .. tostring(number4) .. ") : " .. tostring(number1) .. " - " .. tostring(number2)  
    result = (number3 + number4) / number1 - number2	
end 	

if (ITEM == 3) then
    quest =  tostring(number3) .. " + " .. tostring(number4) .. " : (" .. tostring(number1) .. " - " .. tostring(number2) .. ")" 
    result = number3 + number4 / (number1 - number2)	
end 	

if (ITEM == 4) then
    quest = "(" .. tostring(number3) .. " + " .. tostring(number4) .. ") : (" .. tostring(number1) .. " - " .. tostring(number2) .. ")" 
    result = (number3 + number4) / (number1 - number2)	
end 	
    