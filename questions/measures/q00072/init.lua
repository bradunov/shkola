
part = (3 + math.random(3)) * 10

number = (3 + math.random(5)) * 10 

value = part * number 

weight = math.floor(value/1000)
rest = value - weight * 1000  

answ = tostring(math.floor(weight)) .. "t " 

if (rest ~=0) then 
    answ = answ .. " " .. tostring(math.floor(rest)) .. "kg" 
end	        
   

