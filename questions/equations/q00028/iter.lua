
operation = {"+", "-"}
ind = math.random(2)
sign = operation[ind]
ind2 = math.random(2)
sign2 = operation[ind2]

compare = {">", "<"}
index = math.random(2)
relat = compare[index]

bracketl = "{"
bracketr = "}"

stampa = 3

term1 = math.random(699) + 101;
term2 = math.random(900 - term1) + 100;
value = term1 + term2;
                  
if (ind == 1) then	
    solution = term1;
    result = value; 
else
    solution = value;
    result = term1;
end	

term3 = math.random(result - 80) + 50
 
if (ind2 == 1) then	
    result = result + term3; 
else
    result = result - term3;
end		
	
if (index == 1) then
	answ = "x " .. "\(\in\) " .. bracketl
	for i = 1, stampa do
		out = solution + i
	    answ = answ .. lib.check_number(out,25) .. ", "
	end		
	answ = answ .. "..." .. bracketr
else 
    if (ind == 1) then
        if(ind2 == 1) then	
	       answ = "x " .. "\(\in\) " .. bracketl .. "1, ..." 
		else
           temp = term2 - term3
           if (temp < 0) then
               temp = -temp
           end	
           temp = temp + 1	
	       answ = "x " .. "\(\in\) " .. bracketl .. tostring(temp) .. ", ..." 				   
        end
    else
        if(ind2 == 1) then	
	       temp = term2 - term3
           if (temp < 0) then
               temp = -temp
           end			   
		else
           temp = term2 + term3           
        end		
	    temp = temp + 1
	    answ = "x " .. "\(\in\) " .. bracketl .. tostring(temp) .. ", ..." 		
	end
	for i = 1, stampa do
		out = solution - stampa + i - 1
	    answ = answ .. ", " .. lib.check_number(out,25) 
	end		
	answ = answ .. bracketr	
end		
        
        

             

                 

             

             