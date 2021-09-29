
bracketl = "{"
bracketr = "}"
compare = {">", "<", "≥", "≤"} 
operation = {"+", "-"}

stampa = 3

ind = math.random(2)
sign = operation[ind]
ind2 = math.random(2)
sign2 = operation[ind2]

index = math.random(4)
relat = compare[index]

term1 = math.random(69) + 11;
term2 = math.random(90 - term1) + 10;
value = term1 + term2;
                  
if (ind == 1) then	
    solution = term1;
    result = value; 
else
    solution = value;
    result = term1;
end	

term3 = math.random(result - 8) + 5
 
if (ind2 == 1) then	
    result = result + term3; 
else
    result = result - term3;
end		

answ = "x " .. "\(\small\in\) " .. bracketl	

if (index == 1 or index == 3) then
    if (index == 1) then
        min_range = 1 
        max_range = stampa		
    else
        min_range = 0 
        max_range = stampa - 1		
    end
	for i = min_range, max_range do
		out = solution + i
	    answ = answ .. lib.check_number(out,25) .. ", "
	end		
	answ = answ .. "..." .. bracketr
	neq = "x " .. lib.check_one_option_dropdown(compare,relat).. lib.check_number(solution,25)
end 

temp = 1
if (index == 2 or index == 4) then
    if (ind == 1) then
	    temp = temp - term2	
    else
	    temp = temp + term2	
    end		
    if(ind2 == 1) then	
	    temp = temp - term3 
	else
        temp = temp + term3
	end  
    if (temp < 1) then
        temp = 1
    end	
	answ = answ .. lib.check_number(temp,25) .. ", ..." 				   
	neq = lib.check_number(temp,25) .. " " .. lib.check_one_option_dropdown(compare,compare[4]).. " x " .. lib.check_one_option_dropdown(compare,relat).. lib.check_number(solution,25)
    if (index == 4) then
        min_range = 1 
        max_range = stampa 		
    else
        min_range = 0 
        max_range = stampa - 1		
    end
	for i = min_range, max_range do
		out = solution - stampa + i 
	    answ = answ .. ", " .. lib.check_number(out,25) 
	end		
	answ = answ .. bracketr	
end			
	
        
        
        

             

                 

             

             