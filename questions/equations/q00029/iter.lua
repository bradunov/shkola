
operation = {"+", "-"}
ind = math.random(2)
sign = operation[ind]
ind2 = math.random(2)
sign2 = operation[ind2]

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

term = math.random(699) + 101;
solution = math.random(900 - term) + 100;
value = term + solution;
                  
if (ind == 2) then	
    temp = value;
    value = term;
    term = temp;
end	

t2 = math.floor(term/2)
rest = term - 2 * t2 
if (ind2 == ind) then
    temp = math.random(t2 - 30)	
	term1 = t2 + rest + temp
	term3 = t2 - temp
else
    temp = t2 + math.random(t2 - 10)
	term1 = t2 + rest + temp
	term3 = temp - t2
end

if (index == 1) then
    if(ind == 1) then
	   answ = "x " .. "\(\in\) " .. bracketl
	   for i = 1, stampa do
		   out = solution + i
	       answ = answ .. lib.check_number(out,25) .. ", "
	   end		
	   answ = answ .. "..." .. bracketr
	 else
	   answ = "x " .. "\(\in\) " .. bracketl .. "1, ..." 
	   for i = 1, stampa do
		   out = solution - stampa + i - 1
	       answ = answ .. ", " .. lib.check_number(out,25) 
	   end		
	   answ = answ .. bracketr	
	end
else 
    if(ind == 1) then
	   answ = "x " .. "\(\in\) " .. bracketl .. "1, ..." 
	   for i = 1, stampa do
		   out = solution - stampa + i - 1
	       answ = answ .. ", " .. lib.check_number(out,25) 
	   end		
	   answ = answ .. bracketr	
	else
	   answ = "x " .. "\(\in\) " .. bracketl
	   for i = 1, stampa do
		   out = solution + i
	       answ = answ .. lib.check_number(out,25) .. ", "
	   end
       temp = term - 1	   
	   answ = answ .. "..." .. lib.check_number(temp,25) .. bracketr
	end
end		
  