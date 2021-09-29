
compare = {"<", ">", "≤", "≥"}
index = math.random(4)
relat = compare[index]
	
operat = {"+", "-"}
ind = math.random(2)

factor3 = math.random(10) + 4
factor2 = factor3 + 3 + math.random(10)

choice = math.random(4)

if (choice == 1) then   
    sign2 = "*"
    sign1 = operat[ind]	
    factor1 = math.random(15) + 4	
	if (ind == 1) then
	    value = factor1 * factor2 + factor3
		relatsol = relat
	else
	    value = factor1 * factor2 - factor3 	
	end	
	relatsol = relat	
	answ = tostring(factor1) .. " " .. sign2 .. " x " .. sign1 .. " " .. tostring(factor3) .. " " .. relat .. " " ..  tostring(value)
end

if (choice == 2) then  
    sign2 = "*"
    sign1 = operat[ind]	
	factor1 = math.random(15) + 4
	if (ind == 1) then
		value = factor1 * (factor2 + factor3)
	else
		value = factor1 * (factor2 - factor3)		 
	end
	relatsol = relat	
	answ = tostring(factor1) .. " " .. sign2 .. " (x " .. sign1 .. " " .. tostring(factor3) .. ") " .. relat .. " " ..  tostring(value)
end

if (choice == 3) then 
	sign2 = ":"
    sign1 = operat[ind]	
	tmp = factor3 + 2 + math.random(5)
	factor1 = tmp * factor2
	if (ind == 1) then
		value = tmp + factor3
	else		
	    value = tmp - factor3
	end	
    if (index < 3) then
		relatsol = compare[3 - index]	
    else
		relatsol = compare[7 - index]
    end			
	answ = tostring(factor1) .. " " .. sign2 .. " x " .. sign1 .. " " .. tostring(factor3) .. " " .. relat .. " " .. tostring(value)
end

if (choice == 4) then  
	sign2 = ":"
    sign1 = operat[ind]	
	value = 3 + math.random(7)	
	if (ind == 1) then
	    factor1 = value * (factor2 + factor3)
		relatsol = relat
	else		
	    factor1 = value * (factor2 - factor3)
	end	
	if (index < 3) then
		relatsol = compare[3 - index]	
    else
		relatsol = compare[7 - index]
    end	
	answ = tostring(factor1) .. " " .. sign2 .. " (x " .. sign1 .. " " .. tostring(factor3) .. ") " .. relat .. " " .. tostring(value)
end

result = factor2
    
     
     
  


    
     