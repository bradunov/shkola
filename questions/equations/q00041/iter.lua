
compare = {"<", ">", "≤", "≥"} 
index = math.random(4)
relat = compare[index]

operat = {"+", "-"}
ind = math.random(2)

sign1 = " "

factor1 = math.random(15) + 4
factor2 = math.random(99 - factor1) + 31
factor3 = math.random(15) + 4

choice = math.random(4)

if (choice == 1) then 
    sign1 = "·"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = (factor2 + factor3) * factor1
		relatsol = relat
	else	
	    value = (factor2 - factor3) * factor1 
		if (index < 3) then
		    relatsol = compare[3 - index]	
        else
		    relatsol = compare[7 - index]
        end			
	end	
	result = factor3	
	answ = " (" .. tostring(factor2) .. " " .. sign2 .. " x) " .. sign1 .. " " .. tostring(factor1) .. " " .. relat .. " " .. tostring(value)
end

if (choice == 2) then 

    sign1 = "·"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 + factor3 * factor1
		relatsol = relat		
	else
	    temp = factor3 * factor1
        if (factor2 <= temp) then
            factor2 = temp + 11 + math.random(19)
        end			
	    value = factor2 - temp 
		if (index < 3) then
		    relatsol = compare[3 - index]	
        else
		    relatsol = compare[7 - index]
        end			
	end
	result = factor3	
	answ = tostring(factor2) .. " " .. sign2 .. " x " .. sign1 .. " " .. tostring(factor1) .. " " .. relat .. " " .. tostring(value)
end

if (choice == 3) then  

	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 * factor1 - factor3
		relatsol = relat		
	else		
	    value = factor2 * factor1 + factor3
		if (index < 3) then
		    relatsol = compare[3 - index]	
        else
		    relatsol = compare[7 - index]
        end			
	end	
	result = factor3
	answ = "( " .. tostring(value) .. " " .. sign2 .. " x) " .. sign1 .. " " .. tostring(factor1) .. " " .. relat .. " " .. tostring(factor2)
end

if (choice == 4) then  

	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 + factor3
		relatsol = relat		
	else		
	    value = factor2 - factor3
		if (index < 3) then
		    relatsol = compare[3 - index]	
        else
		    relatsol = compare[7 - index]
        end		
	end	
	result = factor1 * factor3	
	answ = tostring(factor2) .. " " .. sign2 .. " x " .. sign1 .. " " .. tostring(factor1) .. " " .. relat .. " " .. tostring(value)
end
   
  


    
     