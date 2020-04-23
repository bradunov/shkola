
factor2 = math.random(6) + 2;
temp = math.floor(100/factor2)
result = math.random(temp - 11) + 11;

factor1 = result * factor2

value = math.floor(factor1/(factor2*10))
rest = factor1 - value * 10 * factor2

if (rest == 0) then
    result = result - 1
    factor1 = result * factor2

    value = math.floor(factor1/(factor2*10))
    rest = factor1 - value * 10 * factor2
end	


term1 = value * 10 * factor2

term2 = value * 10
term3 = result - value * 10
        

   

   
