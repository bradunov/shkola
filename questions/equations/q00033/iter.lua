	
sign = "&middot;"

factor1 = math.random(19) + 11
factor2 = math.random(factor1 - 10) + 5
result = math.random(39) + 11

ind = math.random(3)

if (ind == 1) then  	
    prod = (factor1 + factor2) * result
	answ = tostring(factor1) .. " " .. sign .. " x + " .. tostring(factor2) .. " " .. sign .. " x = " .. tostring(prod)
end

if (ind == 2) then  	
    prod = (factor1 - factor2) * result
	answ = tostring(factor1) .. " " .. sign .. " x - " .. tostring(factor2) .. " " .. sign .. " x = " .. tostring(prod)
end

if (ind == 3) then  
    result = math.random(12) + 3	
    prod = factor1 + result * result
	answ = "x " .. sign .. " x + " .. tostring(factor1) .. " = " .. tostring(prod)
end


