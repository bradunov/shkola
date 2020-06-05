
answ = {""}
quest = {""}
ind = math.random(4)

term = math.random(8999) + 1001;
solution = math.random(7999) + 3001;
if (solution == term) then
    term = term - 100
end	                



if (ind == 1) then	
	if (solution < term) then 
	    temp = solution
		solution = term
		term = temp
	end    
    value = solution - term
    quest[ind] = "Od kog broja treba oduzeti broj " .. tostring(math.floor(term)) .. " da bi se dobio broj " .. tostring(math.floor(value)) .. "?"
end	
                  
if (ind == 2) then	
    value = term + solution;
    quest[ind] = "Kom broju treba dodati broj " .. tostring(math.floor(term)) .. " da bi se dobio broj " ..  tostring(math.floor(value)) .. "?"
end	                  

if (ind == 3) then
	if (term < solution) then 
	    temp = solution
		solution = term
		term = temp
	end    	
    value = term - solution
    quest[ind] = "Koji broj treba oduzeti od broja " .. tostring(math.floor(term)) .. " da bi se dobio broj " ..  tostring(math.floor(value)) .. "?"
end	                

if (ind == 4) then	
    value = term + solution;
    quest[ind] = "Koji broj treba dodati broju " .. tostring(math.floor(term)) .. " da bi se dobio broj " ..  tostring(math.floor(value)) .. "?"
end	
            
answ[1] = "x - " .. tostring(math.floor(term)) .. " = " .. tostring(math.floor(value))           

if (ind ~= 2 and value < term) then
    answ[2] = "x + " .. tostring(math.floor(value)) .. " = " .. tostring(math.floor(term)) 
else
    answ[2] = "x + " .. tostring(math.floor(term)) .. " = " .. tostring(math.floor(value))            
end

if (ind ~= 3 and value > term) then
    answ[3] = tostring(math.floor(value)) .. " - x = " .. tostring(math.floor(term)) 
else	
    answ[3] = tostring(math.floor(term)) .. " - x = " .. tostring(math.floor(value))    
end

if (ind ~=4 and value < term) then	
    answ[4] = tostring(math.floor(value)) .. " + x = " .. tostring(math.floor(term))             
else 
    answ[4] = tostring(math.floor(term)) .. " + x = " .. tostring(math.floor(value))  
end	
             
            
            