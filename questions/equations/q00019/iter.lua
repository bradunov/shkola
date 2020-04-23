operation = {"·", ":"}

ind = math.random(2)
sign = operation[ind]


factor1 = math.random(8) + 2
factor2 = math.random(8) + 2
prod = factor1 * factor2
                  
if (ind == 1) then	
    term = factor1
    solution = factor2;
    result = prod;
else
    term = prod
    solution = factor2;
    result = factor1;
end	
                    