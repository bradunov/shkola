sign = " "

factor1 = math.random(8) + 2
factor2 = math.random(8) + 2
prod = factor1 * factor2


if (ITEM == 1) then  
	sign = "·"	
	result = factor2
	answ = "x " .. sign .. " " .. tostring(factor1) .. " = " .. tostring(prod)
end

if (ITEM == 2) then  
	sign = ":"	
	result = prod
	answ = "x " .. sign .. " " .. tostring(factor1) .. " = " .. tostring(factor2)
end

if (ITEM == 3) then  
	sign = "·"	
	result = factor2
	answ = tostring(factor1) .. " " .. sign .. " x " .. " = " .. tostring(prod)
end

if (ITEM == 4) then  
	sign = ":"	
	result = factor2
	answ = tostring(prod) .. " " .. sign .. " x " .. " = " .. tostring(factor1)
end
	  
