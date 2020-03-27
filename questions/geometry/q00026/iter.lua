measure = {"\(km^2\)","ha","a","\(m^2\)"}
numb = {0, 0, 0, 0}

indr = 1 + math.random(3)
indl = math.random(indr-1)

ind = indr - indl

factor = 1 + math.random(3)

numb[indl] = math.random(49) 
value = numb[indl]

for i = indl+1,indr do
    numb[i] = math.random(10)-1
    if (i == factor) then
        numb[i] = 0 
    end 
    value = value * 100 + numb[i]	
end

    
answ = ""
for i = 1,4 do
    if (numb[i] ~= 0) then    
        answ = answ .. " " .. tostring(numb[i]) .. measure[i]
    end
end	
                                
                             
       