
compare = {"<", ">"}

operat = {"+", "-"}
ind = math.random(2)

sign1 = " "

factor1 = math.random(15) + 4
factor2 = math.random(99 - factor1) + 31
factor3 = math.random(15) + 4



if (ITEM == 1) then
    index = math.random(2)
    relat = compare[index]   
    sign1 = "·"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = (factor2 + factor3) * factor1
		relatsol = relat
	else
	    value = (factor2 - factor3) * factor1 
		relatsol = compare[3 - index]
	end	
	result = factor3	
	answ = " (" .. tostring(factor2) .. " " .. sign2 .. " x) " .. sign1 .. " " .. tostring(factor1) .. " " .. relat .. " " ..  tostring(value)
end

if (ITEM == 2) then  
    index = math.random(2)
    relat = compare[index] 
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
		relatsol = compare[3 - index]
	end
	result = factor3	
	answ = tostring(factor2) .. " " .. sign2 .. " x " .. sign1 .. " " .. tostring(factor1) .. " " .. relat .. " " ..  tostring(value)
end

if (ITEM == 3) then 
    index = math.random(2)
    relat = compare[index]  
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 * factor1 - factor3
		relatsol = relat
	else		
	    value = factor2 * factor1 + factor3
		relatsol = compare[3 - index]
	end	
	result = factor3
	answ = "( " .. tostring(value) .. " " .. sign2 .. " x) " .. sign1 .. " " .. tostring(factor1) .. " " .. relat .. " " .. tostring(factor2)
end

if (ITEM == 4) then  
    index = math.random(2)
    relat = compare[index] 
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 + factor3
		relatsol = relat
	else		
	    value = factor2 - factor3
		relatsol = compare[3 - index]
	end	
	result = factor1 * factor3	
	answ = tostring(factor2) .. " " .. sign2 .. " x " .. sign1 .. " " .. tostring(factor1) .. " " .. relat .. " " .. tostring(value)
end
     
  


    
     