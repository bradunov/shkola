
operation = {"+", "-"}
ind = math.random(2)
sign = operation[ind]

compare = {">", "<"}
index = math.random(2)
relat = compare[index]

bracketl = "{"
bracketr = "}"

stampa = 3

term1 = math.random(79) + 10;
term2 = math.random(90 - term1) + 10;
value = term1 + term2;
                  
if (ind == 1) then	
    solution = term1;
    result = value; 
else
    solution = value;
    result = term1;
end		
	
if (index == 1) then
	answ = "x " .. "\(\in\) " .. bracketl
	for i = 1, stampa do
		out = solution + i
	    answ = answ .. lib.check_number(out,20) .. ", "
	end		
	answ = answ .. "..." .. bracketr
else 
    if (ind == 1) then	
	    answ = "x " .. "\(\in\) " .. bracketl .. "1, ..." 
    else
	    temp = term2 + 1
	    answ = "x " .. "\(\in\) " .. bracketl .. tostring(temp) .. ", ..." 		
	end
	for i = 1, stampa do
		out = solution - stampa + i - 1
	    answ = answ .. ", " .. lib.check_number(out,20) 
	end		
	answ = answ .. bracketr	
end		

                 

             

             