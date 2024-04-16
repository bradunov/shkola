
operation = {"+", "-"}
ind = math.random(2)
sign = operation[ind]

compare = {">", "<"}
index = math.random(2)
relat1 = compare[index]

if (ind == 1) then
    relat2 = compare[index]
else
    relat2 = compare[3 - index]
end	

bracketl = "{"
bracketr = "}"

stampa = 3

term = math.random(69) + 10;
solution = math.random(90 - term) + 10;
value = term + solution;
                  
if (ind == 2) then	
    temp = value;
    value = term;
    term = temp;
end	

if (index == 1) then
    if(ind == 1) then
	   answ = "x " .. "\(\in\) " .. bracketl
	   for i = 1, stampa do
		   out = solution + i
	       answ = answ .. lib.check_number(out) .. ", "
	   end		
	   answ = answ .. "..." .. bracketr
	 else
	   answ = "x " .. "\(\in\) " .. bracketl .. "1, ..." 
	   for i = 1, stampa do
		   out = solution - stampa + i - 1
	       answ = answ .. ", " .. lib.check_number(out) 
	   end		
	   answ = answ .. bracketr	
	end
else 
    if(ind == 1) then
	   answ = "x " .. "\(\in\) " .. bracketl .. "1, ..." 
	   for i = 1, stampa do
		   out = solution - stampa + i - 1
	       answ = answ .. ", " .. lib.check_number(out) 
	   end		
	   answ = answ .. bracketr	
	else
	   answ = "x " .. "\(\in\) " .. bracketl
	   for i = 1, stampa do
		   out = solution + i
	       answ = answ .. lib.check_number(out) .. ", "
	   end
       temp = term - 1	   
	   answ = answ .. "..." .. lib.check_number(temp) .. bracketr
	end
end		
