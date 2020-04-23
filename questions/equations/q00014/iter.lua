operation = {"+", "-"}

ind = math.random(2)
sign = operation[ind]

term = math.random(69) + 10;
solution = math.random(90 - term) + 10;
value = term + solution;
                  
if (ind == 2) then	
    temp = value;
    value = term;
    term = temp;
end	