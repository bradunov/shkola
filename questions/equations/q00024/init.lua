
answ = {""}

ind = math.random(4)

term1 = math.random(4990) + 3010;
term2 = math.random(term1 - 1500) + 1000;

diff = term1 - term2
if (diff < 2001) then
    term1 = term1 + 3001 - diff
	diff = term1 - term2
end	
summ = term1 + term2

if (ind == 1) then	
    term3 = 1000 + math.random(summ - 2000) ;
    solution = summ - term3
end	
                   
if (ind == 2) then	
    term3 = summ + math.random(5000) ;
    solution = term3 - summ
end	 
              
if (ind == 3) then	
    term3 = diff + math.random(5000) ;
    solution = term3 - diff
end	

if (ind == 4) then	
    term3 = 1000 + math.random(diff - 2000) ;    
    solution = diff - term3		
end	
           
answ[1] = "(" .. tostring(math.floor(term1)) .. " + " .. tostring(math.floor(term2)) .. ") - x = " .. tostring(math.floor(term3))           
answ[2] = "(" .. tostring(math.floor(term1)) .. " + " .. tostring(math.floor(term2)) .. ") + x = " .. tostring(math.floor(term3))                     
answ[3] = "(" .. tostring(math.floor(term1)) .. " - " .. tostring(math.floor(term2)) .. ") + x = " .. tostring(math.floor(term3)) 
answ[4] = "(" .. tostring(math.floor(term1)) .. " - " .. tostring(math.floor(term2)) .. ") - x = " .. tostring(math.floor(term3))  
