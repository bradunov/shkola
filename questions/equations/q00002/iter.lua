operation = {"+", "-"}

ind = math.random(2)
sign = operation[ind]

term = math.random(699) + 100;
solution = math.random(900 - term) + 100;
value = term + solution;
                  
if (ind == 2) then	
    temp = value;
    value = term;
    term = temp;
end	
                  
                  
        