
operation = {"uvećan", "umanjen"}
ind = math.random(2)

compare = {">", "<"}
comp = {"veći", "manji"}
index = math.random(2)
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

if(index == 1) then
    answ = "x " .. "\(\in\) " .. bracketl
    for i = 1, stampa do
	    out = solution + i
	    answ = answ .. lib.check_number(out,20) .. ", "		
    end	
    answ = answ .. " ... " .. bracketr	
else
	answ = "x " .. "\(\in\) " .. bracketl .. lib.check_number(1, 20) .. ", " .. lib.check_number(2, 20) .. ", ..." 
    for i = 1, stampa do
	    out = solution - stampa - 1 + i
	    answ = answ .. ", " .. lib.check_number(out,20) 
    end		
    answ = answ .. bracketr
end	

            
           