
include("terms")

ind = math.random(2)

compare = {">", "<", "≥", "≤"} 
index = math.random(4)
relat = compare[index]

bracketl = "{"
bracketr = "}"

stampa = 3

solution = math.random(69) + 15;
number = math.random(90) + 10;
prod = solution * number
dif = math.random(solution - 15) + 11;
                  
if (ind == 1) then	    
    result = prod + dif; 
    sign = "+"
else
    result = prod - dif;
    sign = "-"
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
	    answ = answ .. lib.check_number(out,20) .. ", "		
    end	
    answ = answ .. " ... " 		
end

if (index == 2 or index == 4) then 
	if (index == 2) then
        min_range = 0 
        max_range = stampa -1		
    else
        min_range = 1 
        max_range = stampa 		
    end
	answ = answ .. lib.check_number(1, 20) .. ", ..." 
    for i = min_range, max_range do
	    out = solution - stampa  + i
	    answ = answ .. ", " .. lib.check_number(out,20) 
    end		
end	

answ = answ .. bracketr	
          