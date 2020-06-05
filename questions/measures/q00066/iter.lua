
measure = {"l", "dl", "cl", "ml"}
numb = {0, 0, 0, 0}

indr = 1 + math.random(3)
indl = math.random(indr-1)

ind = indr - indl

if (indl == 1) then
    numb[indl] = math.random(5) 
else	
    numb[indl] = math.random(9)  
end   	

value = numb[indl]

factor = 1 + math.random(3)


for i = indl+1,indr do
    numb[i] = math.random(9)
    if (i == factor) then
        numb[i] = 0 
    end 
    value = value * 10 + numb[i]	
end

    
answ = ""
for i = 1,4 do
    if (numb[i] ~= 0) then    
        answ = answ .. " " .. lib.check_number(numb[i],20) .. measure[i]
    end
end	        