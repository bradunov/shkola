
measure = {"m³","dm³","cm³", "mm³"}
numb = {0, 0, 0, 0}

ind1 = math.random(3)
ind2 = ind1 + math.random(4 - ind1)
max = ind2 - ind1 + 1

if (max == 4) then
    ind2 = ind2 - 1
    max = max - 1
end

factor = math.random(30)
value = 0

for i = ind1,ind2 do
    if(i == ind1) then
       numb[i] = math.random(9) 
    else 
       numb[i] = math.random(10) - 1 
    end
    if (i ~= ind1) then
        numb[i] = numb[i] * factor 
    end 
    value = value * 1000 + numb[i]	
end

if (value == 0) then
    numb[1] = math.random(9)
	value = numb[1] * 1000^(max-1)
end
    
answ = ""
for i = ind1,ind2 do
    if (numb[i] ~= 0) then    
        answ = answ .. " " .. lib.check_number(numb[i],25) .. measure[i]
    end
end	
   
                   
       