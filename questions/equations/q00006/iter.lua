sign = " "

factor1 = math.random(799) + 100;
factor2 = math.random(900 - factor1) + 100;
summ = factor1 + factor2;
                  

if (ITEM == 1) then  
	sign = "+"	
	result = factor2
	answ = "x " .. sign .. " " .. tostring(factor1) .. " = " .. tostring(summ)
end

if (ITEM == 2) then  
	sign = "-"	
	result = summ
	answ = "x " .. sign .. " " .. tostring(factor1) .. " = " .. tostring(factor2)
end

if (ITEM == 3) then  
	sign = "+"	
	result = factor2
	answ = tostring(factor1) .. " " .. sign .. " x " .. " = " .. tostring(summ)
end

if (ITEM == 4) then  
	sign = "-"	
	result = factor2
	answ = tostring(summ) .. " " .. sign .. " x " .. " = " .. tostring(factor1)
end
	   
