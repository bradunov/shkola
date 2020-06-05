
ind = math.random(4)

bracketl = "{"
bracketr = "}"

if (ind == 1) then	
    term2 = math.random(5) + 3;
    noneq = "x " .. " \(\lt\) " .. tostring(math.floor(term2))  
	answ = "x " .. "\(\in\) " .. bracketl
	for i = 1, term2 - 2 do
	    answ = answ .. lib.check_number(i,10) .. ", "
	end	
    temp = term2 - 1
	answ = answ .. lib.check_number(temp,10) .. bracketr
end 

if (ind == 2) then	
    term1 = math.random(59) + 20;
    term2 = term1 + 2 + math.random(5)
    noneq = tostring(math.floor(term1)) .. " \(\lt\) " .. " x " .. " \(\lt\) " .. tostring(math.floor(term2))  
	answ = "x " .. "\(\in\) " .. bracketl
	for i = term1 + 1, term2 - 2 do
	    answ = answ .. lib.check_number(i,20) .. ", "
	end	
    temp = term2 - 1 
	answ = answ .. lib.check_number(temp,20) .. bracketr
end  

if (ind == 3) then	
    term2 = math.random(5) + 3;
    noneq = "x " .. "\(\leq\) " .. tostring(math.floor(term2))  
	answ = "x " .. "\(\in\) " .. bracketl
	for i = 1, term2 - 1 do
	    answ = answ .. lib.check_number(i,10) .. ", "
	end	 
	answ = answ .. lib.check_number(term2,10) .. bracketr
end 	

if (ind == 4) then	
    term1 = math.random(59) + 20;
    term2 = term1 + 2 + math.random(5)
    noneq = tostring(math.floor(term2)) .. " \(\gt\) " .. " x " .. " \(\geq\) " .. tostring(math.floor(term1))  
	answ = "x " .. "\(\in\) " .. bracketl
	for i = term1, term2 - 2 do
	    answ = answ .. lib.check_number(i,20) .. ", "
	end	
    temp = term2 - 1 
	answ = answ .. lib.check_number(temp,20) .. bracketr
end                 

             

             