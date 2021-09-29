
operation = {"·", ":"}
ind = math.random(2)
sign = operation[ind]

compare = {"<", ">", "≤", "≥"}
index = math.random(4)
relat = compare[index]

factor1 = math.random(59) + 21
factor2 = math.random(39) + 11
prod = factor1 * factor2  

term = factor1
solution = factor2;
result = prod;               
relsol = relat
 
stampa =  math.random(2)     
if (stampa == 1) then
    if (ind == 2) then
	    term = prod
        solution = factor2;
        result = factor1;	
        if (index < 3) then		
	        relsol = compare[3 - index]
		else
	        relsol = compare[7 - index]
        end			
	end
	ineq = tostring(term) .. " " .. sign .. " x " .. relat .. " " .. tostring(result)
else
    if (ind == 2) then
	    term = factor1
        solution = prod;
        result = factor2;				
	end
    ineq = "x " .. sign .. " " .. tostring(term) .. " " .. relat .. " " .. tostring(result)
end	
      