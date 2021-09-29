	
compare = {"<", ">", "≤", "≥"}
index = math.random(4)
relat = compare[index] 
	
operat = {"+", "-"}
ind = math.random(2)

sign1 = " "

factor1 = math.random(15) + 4
factor2 = math.random(99 - factor1) + 31
factor3 = math.random(15) + 4

choice = math.random(3)

if (choice == 1) then
    relatsol = relat
    sign1 = "·"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = (factor2 + factor1) * factor3
	else
	    value = (factor2 - factor1) * factor3 
	end		
	answ = tostring(factor2) .. " " .. sign1 .. " x " .. sign2 .. " " .. tostring(factor1) .. " " .. sign1 .. " x " .. " " .. relat .. " " ..  tostring(value)
end

if (choice == 2) then 
    if (index < 3) then
		relatsol = compare[3 - index]	
    else
		relatsol = compare[7 - index]
    end	 
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 * factor3 + factor1 * factor3
	else		
	    value = factor2 * factor3 - factor1 * factor3
	end	
	answ = tostring(factor2) .. " " .. sign1 .. " x " .. sign2 .. " " .. tostring(factor1) .. " " .. sign1 .. " x " .. relat .. " " .. tostring(value)
end

if (choice == 3) then  
    relatsol = relat
	sign1 = "·"
	sign2 = operat[ind]	
    value = factor3 * factor3
	temp = 10 + math.random(value - 11)
	if (ind == 1) then
	    value = value + temp
	else
        value = value - temp
    end			
	answ = " x " .. sign1 .. " x " .. " " .. sign2 .. " " .. tostring(temp) .. " " .. relat .. " " .. tostring(value)
end
 
result = factor3 


  