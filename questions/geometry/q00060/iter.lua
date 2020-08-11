
number = math.random(11); 
if (number == 6) then 
    number = 9
end	

if (number == 1) then
    name = "čas"
end
if (number > 1 and number < 5) then
    name = "časa"
end
if (number > 4) then
    name = "časova"
end	

if (number < 3  or number > 9) then
    reply = "answer == '" .. "ostar" .. "' "  ..
        "|| answer == '" .. "oštar" .. "'" ;
else
    reply = "tup"
end  

if (number == 3 or number == 9) then
    reply = "prav"
end	
                                                     
