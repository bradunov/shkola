	
sign = ":"

factor1 = math.random(7) + 4
deg = math.random(2) - 1
temp = (math.random(80) + 19) * 10^deg
factor2 = math.floor(temp)
prod = factor1 * factor2

ind = math.random(2)

if (ind == 1) then  	
	result = prod
	answ = "x " .. sign .. " " .. tostring(factor1) .. " = " .. tostring(factor2)
else
	result = factor1
	answ = tostring(prod) .. " " .. sign .. " x " .. " = " .. tostring(factor2)
end

