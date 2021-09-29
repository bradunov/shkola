
sign = "·" 
comp = {"<", ">", "≤", "≥"}
bracketl = "{"
bracketr = "}" 

answ = {""}
value = {""}
 
stampa = 3

total = math.random(699) + 401;
place = math.random(26) + 19;

result = math.floor(total/place) 
rest = total - result * place

if (rest > 0) then
    result = result + 1
end	
           
answ[1] = tostring(math.floor(place)) .. " " .. sign .. " x " .. comp[1] .. tostring(math.floor(total))           
answ[2] = tostring(math.floor(place)) .. " " .. sign .. " x " .. comp[3] .. tostring(math.floor(total))                      
answ[3] = tostring(math.floor(place)) .. " " .. sign .. " x " .. comp[2] .. tostring(math.floor(total))  
answ[4] = tostring(math.floor(place)) .. " " .. sign .. " x " .. comp[4] .. tostring(math.floor(total)) 

ind = {1, 2, 3, 4}

out = lib.math.random_shuffle(ind)
for i = 1,4 do 
    value[i] = answ[out[i]]
    if (out[i] == 4) then
        index = i - 1
    end
end	
   
solution = "x " .. "\(\small\in\) " .. bracketl
for i = 1, stampa do
    temp = result + i - 1 
	solution = solution .. lib.check_number(temp,20) .. ", "
end	
solution = solution .. " ... " .. bracketr
     