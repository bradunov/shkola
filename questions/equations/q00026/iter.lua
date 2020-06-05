
term1 = math.random(6999) + 2001;
term2 =  math.random(term1 - 2000) + 1001; 
diff = term1 - term2

solution = math.random(diff - 100) + 101;

ind = math.random(6)                  

if (ind == 1) then	
    temp = solution
	solution = term2
	term2 = temp
	result = term1 + solution - term2
    answ = tostring(math.floor(term1)) .. " + (x - " .. tostring(math.floor(term2)) .. ") = " .. tostring(math.floor(result))           
end	
                   
if (ind == 2) then	
    result = term1 - solution + term2 
    answ = "(" .. tostring(math.floor(term1)) .. " - x) + " .. tostring(math.floor(term2)) .. " = " .. tostring(math.floor(result))           
end	
             
if (ind == 3) then	
    result = term1 + solution - term2 
    answ = "(" .. tostring(math.floor(term1)) .. " + x) - " .. tostring(math.floor(term2)) .. " = " .. tostring(math.floor(result))           
end	

if (ind == 4) then	
    temp = solution
	solution = term1
	term1 = term2
	term2 = temp
	result = solution -term1 - term2
    answ = "(x - " .. tostring(math.floor(term1)) .. ") - " .. tostring(math.floor(term2)) .. " = " .. tostring(math.floor(result))           
end	
           
if (ind == 5) then	   
	result = term1 - term2 - solution 
    answ = tostring(math.floor(term1)) .. " - (" .. tostring(math.floor(term2)) .. " + x) = " .. tostring(math.floor(result))           
end	

if (ind == 6) then	   
	result = term1 - term2 + solution 
    answ = tostring(math.floor(term1)) .. " - (" .. tostring(math.floor(term2)) .. " - x) = " .. tostring(math.floor(result))           
end	
                                   