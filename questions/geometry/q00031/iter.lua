measure = {"\(km^2\)", "ha", "a", "\(m^2\)","\(dm^2\)","\(cm^2\)"}
ind = math.random(5)

sign = {"+", "-"}
operat = math.random(2)

numb = {0, 0, 0}

numb[1] = math.random(15) - 1
numb[2] = (math.random(5) -1)*5
if (numb[1]*numb[2] == 0) then
    numb[1] = 1
end


if (operat == 1) then 
    numb[3] = numb[1] + math.random(2)
    value = (numb[3] - numb[1]) * 100 - numb[2]
else
    if (numb[1] > 2) then 
        numb[3] = numb[2] + math.random(79)
    else
        numb[3] = numb[1] * 100 + numb[2] - math.random(19)
    end
    value = numb[1] * 100 + numb[2] - numb[3] 
end	


answ = tostring(math.floor(numb[1])) .. measure[ind]

if (numb[2] ~= 0) then    
    answ = answ .. " " .. tostring(math.floor(numb[2])) .. measure[ind+1] 
end
	
answ = answ .. "  " .. sign[operat] .. "  " .. lib.check_number(value) .. measure[ind+1] .. "  =  " .. tostring(math.floor(numb[3])) 

if (operat == 1) then
    answ = answ .. measure[ind]
else
    answ = answ .. measure[ind+1]	
end	
 