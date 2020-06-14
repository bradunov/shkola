	
sign = ":"

factor1 = math.random(7) + 4
deg = math.random(2) - 1
temp = (math.random(80) + 19) * 10^deg
factor2 = math.floor(temp)
prod = factor1 * factor2

ind = math.random(2)

if (ind == 1) then  	
	result = prod
	answ = "x " .. sign .. " " .. tostring(factor1) 
else
	result = factor1
	answ = tostring(prod) .. " " .. sign .. " x " 
end

indpr = math.random(4)

if (indpr == 1) then
    temp = math.random(math.floor(factor2/2))
    value1 = temp
    value2 = factor2 - temp
    answ = answ .. " - " .. tostring(value1) .. " = " .. tostring(value2) 
end	

if (indpr == 2) then
    temp = math.random(math.floor(factor2/2))
    value1 = temp	
    value2 = factor2 + temp  
    answ = answ .. " + " .. tostring(value1) .. " = " .. tostring(value2) 
end

if (indpr == 3) then
    temp = 11 + math.random(89)
    value1 = factor2 + temp
    value2 = temp
    answ = tostring(value1) .. " - " .. answ .. " = " .. tostring(value2) 
end	

if (indpr == 4) then
    temp = 11 + math.random(89)
    value1 = factor2 + temp
    value2 = temp
    answ = tostring(value2) .. " + " .. answ .. " = " .. tostring(value1) 
end	
