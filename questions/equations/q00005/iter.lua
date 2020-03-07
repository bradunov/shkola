sign = " "

factor1 = math.random(5) + 2
factor2 = math.random(101 - factor1*10) + 101
prod = factor1 * factor2


if (ITEM == 1) then  
	sign = "&middot;"	
	result = factor2
	answ = "x " .. sign .. " " .. tostring(factor1) .. " = " .. tostring(prod)
end

if (ITEM == 2) then  
	sign = ":"	
	result = prod
	answ = "x " .. sign .. " " .. tostring(factor1) .. " = " .. tostring(factor2)
end

if (ITEM == 3) then  
	sign = "&middot;"	
	result = factor2
	answ = tostring(factor1) .. " " .. sign .. " x " .. " = " .. tostring(prod)
end

if (ITEM == 4) then  
	sign = ":"	
	result = factor2
	answ = tostring(prod) .. " " .. sign .. " x " .. " = " .. tostring(factor1)
end
	  
