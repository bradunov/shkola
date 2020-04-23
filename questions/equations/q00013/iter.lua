operation = {"+", "-"}

ind = math.random(2)
sign = operation[ind]

term1 = math.random(79) + 10;
term2 = math.random(90 - term1) + 10;
value = term1 + term2;
                  
if (ind == 1) then	
    solution = term1;
    result = value;
else
    solution = value;
    result = term1;
end	
             