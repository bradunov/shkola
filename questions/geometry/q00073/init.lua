
velocity = math.random(3) * 10

number = (10 + math.random(15)) * 10

hour = math.floor(number/60)
minute = number - hour * 60

value = number * velocity

volume = math.floor(value/100)
rest = value - volume * 100

quest = tostring(math.floor(volume)) .. "hl " 

if (rest ~=0) then 
    quest = quest .. " " .. tostring(math.floor(rest)) .. "l" 
end	        
   
answ = lib.check_number(number) .. "minuta" 

if (minute ~=0) then 
    answ = answ .. " = " .. lib.check_number(hour,20) .. "časa"  .. " " .. lib.check_number(minute) .. "minuta." 
else
    answ = answ .. " = " .. lib.check_number(hour,20) .. "časa."
end           
                 