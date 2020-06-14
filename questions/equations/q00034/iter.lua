	
sign = "&middot;"

factor1 = math.random(69) + 11
factor2 = math.random(80) + 19
prod = factor1 * factor2

ind = math.random(2)

if (ind == 1) then  	
	result = factor2
	answ = "x " .. sign .. " " .. tostring(factor1) 
else
	result = factor2
	answ = tostring(factor1) .. " " .. sign .. " x " 
end

indpr = math.random(2)

if (indpr == 1) then
    temp = math.random(math.floor(prod/2))
    value1 = temp
    value2 = prod - temp
    answ = answ .. " - " .. tostring(value1) .. " = " .. tostring(value2) 
end	

if (indpr == 2) then
    temp = math.random(math.floor(prod/2))
    value1 = temp	
    value2 = prod + temp  
    answ = answ .. " + " .. tostring(value1) .. " = " .. tostring(value2) 
end
