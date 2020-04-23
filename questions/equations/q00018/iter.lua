operation = {"&middot;", ":"}

ind = math.random(2)
sign = operation[ind]


factor1 = math.random(8) + 2
factor2 = math.random(8) + 2
prod = factor1 * factor2
                  
if (ind == 1) then	
    solution = factor2;
    result = prod;
else
    solution = prod;
    result = factor2;
end	
                  
                  
                  