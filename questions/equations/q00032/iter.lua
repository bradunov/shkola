	
sign = "&middot;"

factor1 = math.random(69) + 11
factor2 = math.random(80) + 19
prod = factor1 * factor2

ind = math.random(2)

if (ind == 1) then  	
	result = factor2
	answ = "x " .. sign .. " " .. tostring(factor1) .. " = " .. tostring(prod)
else
	result = factor2
	answ = tostring(factor1) .. " " .. sign .. " x " .. " = " .. tostring(prod)
end

