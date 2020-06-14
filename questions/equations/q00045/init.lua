
answ = {""}
value = {""}
sign = "·" 

bracketl = "{"
bracketr = "}"  
stampa = 3

number = math.random(10) + 10;
place1 = math.random(20) + 30;
place2 = math.random(7) + 19;
result = math.random(10) + 5; 
rest = math.random(6) - 1
total = number * place1 + result * place2 + rest

if (rest > 0) then
    result = result + 1
end	
           
answ[1] = tostring(number).. " " .. sign .. " " .. tostring(place1).. " + x " .. sign .. " " ..tostring(place2).. " \(\gt\) " .. tostring(math.floor(total))           
answ[2] = tostring(number).. " " .. sign .. " " .. tostring(place1).. " - x " .. sign .. " " .. tostring(place2).. " \(\lt\) " .. tostring(math.floor(total))                      
answ[3] = tostring(number).. " " .. sign .. " " .. tostring(place1).. " - x " .. sign .. " " .. tostring(place2).. " \(\leq\) " .. tostring(math.floor(total)) 
answ[4] = tostring(number).. " " .. sign .. " " .. tostring(place1).. " + x " .. sign .. " " .. tostring(place2).. " \(\geq\) " .. tostring(math.floor(total)) 

ind = {1, 2, 3, 4}

out = lib.math.random_shuffle(ind)
for i = 1,4 do 
    value[i] = answ[out[i]]
    if (out[i] == 4) then
        index = i - 1
    end
end	
   
solution = "x " .. "\(\in\) " .. bracketl
for i = 1, stampa do
    temp = result + i - 1 
	solution = solution .. lib.check_number(temp,20) .. ", "
end	
solution = solution .. " ... " .. bracketr
     

     
    
             
            
            