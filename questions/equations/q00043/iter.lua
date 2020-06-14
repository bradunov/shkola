
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
    relatsol = relat
    sign1 = "·"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = (factor2 + factor1) * factor3
	else
	    value = (factor2 - factor1) * factor3 
	end	
	result = factor3	
	answ = tostring(factor2) .. " " .. sign1 .. " x " .. sign2 .. " " .. tostring(factor1) .. " " .. sign1 .. " x " .. " " .. relat .. " " ..  tostring(value)
end

if (ITEM == 2) then 
    index = math.random(2)
    relat = compare[index]
    relatsol = compare[3 - index]  
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor2 * factor3 + factor1 * factor3
	else		
	    value = factor2 * factor3 - factor1 * factor3
	end	
	result = factor3
	answ = tostring(factor2) .. " " .. sign1 .. " x " .. sign2 .. " " .. tostring(factor1) .. " " .. sign1 .. " x " .. relat .. " " .. tostring(value)
end

if (ITEM == 3) then  
    index = math.random(2)
    relat = compare[index] 
    relatsol = relat
	sign1 = "·"
    value = factor3 * factor3
	result = factor3	
	answ = " x " .. sign1 .. " x " .. " " .. relat .. " " .. tostring(value)
end
     
  


    
     