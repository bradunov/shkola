
factor2 = math.random(6) + 2;
temp = math.floor(100/factor2)
factor1 = math.random(temp - 11) + 11;

value = math.floor(factor1/10)
rest = factor1 - value * 10

if (rest == 0) then
    factor1 = factor1 - 1
    value = math.floor(factor1/10)
    rest = factor1 - value * 10
end

term1 = value * 10
term2 = term1 * factor2
term3 = rest * factor2
result = factor1 * factor2
                 
   

   
