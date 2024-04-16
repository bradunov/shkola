
measure = {"m²", "dm²", "cm²", "mm²"}
numb = {0, 0, 0, 0}

ind = 1 + math.random(3)

factor = math.random(4)
value = 0

for i = 1,ind do
    if(ind == 2 and i == 1) then
       numb[i] = math.random(9) 
    else 
       numb[i] = math.random(10) - 1 
    end
    if (i ~= 1) then
        numb[i] = numb[i] * factor 
    end 
    value = value * 100 + numb[i]	
end

if (value == 0) then
    numb[1] = math.random(9)
	value = numb[1] * 100^(ind-1)
end
    
answ = ""
for i = 1,4 do
    if (numb[i] ~= 0) then    
        answ = answ .. " " .. tostring(math.floor(numb[i])) .. measure[i]
    end
end	
                          
       