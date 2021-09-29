
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
relat1 = compare[index]

if (ind == 1) then
    relat2 = compare[index]
else
    if (index < 3) then
        relat2 = compare[3 - index]
	else
        relat2 = compare[7 - index]
   end	
end	

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

answ = "x " .. "\(\small\in\) " .. bracketl

if (index == 1 or index == 3) then 
    if (ind == 1) then
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
	    neq = " x " .. lib.check_one_option_dropdown(compare,relat2).. " " .. lib.check_number(solution,25)		
	else	
        if (index == 3) then
            min_range = 1 
            max_range = stampa		
        else
            min_range = 0 
            max_range = stampa - 1		
        end	
	    answ = answ .. lib.check_number(1,25)   
	    for i = min_range, max_range do
		    out = solution - stampa + i 		   
	        answ = answ .. ", " .. lib.check_number(out,25)
	    end		
	    answ = answ .. bracketr	
	    neq = lib.check_number(1,25) .. " " .. lib.check_one_option_dropdown(compare,compare[4]).. " x " .. lib.check_one_option_dropdown(compare,relat2).. " " .. lib.check_number(solution,25)		
	end
end	
	
if (index == 2 or index == 4) then 
    if (ind == 1) then
	    if (index == 2) then
            min_range = 0 
            max_range = stampa -1		
        else
            min_range = 1 
            max_range = stampa 		
        end
	    answ = answ .. lib.check_number(1,25)
	    for i = min_range, max_range do
		    out = solution - stampa + i
	       answ = answ .. ", " .. lib.check_number(out,25) 
	    end		
	    answ = answ .. bracketr	
	    neq = lib.check_number(1,25) .. " " .. lib.check_one_option_dropdown(compare,compare[4]).. " x " .. lib.check_one_option_dropdown(compare,relat2).. " " .. lib.check_number(solution,25)			
	else
        if (index == 2) then
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
        temp = term - 1	   
	    answ = answ .. "..." .. lib.check_number(temp,25) .. bracketr
	    neq = lib.check_number(temp,25) .. " " .. lib.check_one_option_dropdown(compare,compare[3]).. " x " .. lib.check_one_option_dropdown(compare,relat2).. " " .. lib.check_number(solution,25)			
	end
end	   