
measure = {"m³","dm³","cm³", "mm³"}
ind = math.random(3)

sign = {"+", "-"}
operat = math.random(2)

numb = {0, 0, 0}

numb[1] = math.random(150) - 1
numb[2] = (math.random(50) -1)*5
if (numb[1]*numb[2] == 0) then
    numb[1] = 1
end


if (operat == 1) then 
    numb[3] = numb[1] + math.random(20)
    value = (numb[3] - numb[1]) * 1000 - numb[2]
else
    if (numb[1] > 2) then 
        numb[3] = numb[2] + math.random(790)
    else
        numb[3] = numb[1] * 1000 + numb[2] - math.random(190)
    end
    value = numb[1] * 1000 + numb[2] - numb[3] 
end	


answ = tostring(math.floor(numb[1])) .. measure[ind]

if (numb[2] ~= 0) then    
    answ = answ .. " " .. tostring(math.floor(numb[2])) .. measure[ind+1] 
end
	
answ = answ .. "  " .. sign[operat] .. "  " .. lib.check_number(value,50) .. measure[ind+1] .. "  =  " .. tostring(math.floor(numb[3])) 

if (operat == 1) then
    answ = answ .. measure[ind]
else
    answ = answ .. measure[ind+1]	
end	
 