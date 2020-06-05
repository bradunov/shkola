
answ = {""}
value = {""}

total = (math.random(4990) + 3010) * 10;
solution = math.random(total/2 - 12000) + 10000;

number = total - solution
temp = 10^4 * math.floor(total/10^4) + number 
           
answ[1] = tostring(math.floor(number)) .. " - x = " .. tostring(math.floor(total))           
answ[2] = tostring(math.floor(total)) .. " + x = " .. tostring(math.floor(temp))                     
answ[3] = "x + " .. tostring(math.floor(number)) .. " = " .. tostring(math.floor(total)) 
answ[4] = "x - " .. tostring(math.floor(number)) .. " = " .. tostring(math.floor(total)) 

ind = {1, 2, 3, 4}

out = lib.math.random_shuffle(ind)
for i = 1,4 do 
    value[i] = answ[out[i]]
    if (out[i] == 3) then
        index = i - 1
    end
end	
   

     
    
             
            
            