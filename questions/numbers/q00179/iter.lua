
factor2 = math.random(6) + 2;
temp = math.floor(1000/factor2)
result = math.random(temp - 110) + 110;

factor1 = result * factor2

value1 = math.floor(factor1/(factor2*100))
rest1 = factor1 - value1 * 100 * factor2
value2 = math.floor(rest1/(factor2*10))
rest2 = rest1 - value2 * 10 * factor2

if (rest2 == 0) then
    result = result - 1
    factor1 = result * factor2
    value1 = math.floor(factor1/(factor2*100))
    rest1 = factor1 - value1 * 100 * factor2
    value2 = math.floor(rest1/(factor2*10))
    rest2 = rest1 - value2 * 10 * factor2
end	


term1 = value1 * 100 * factor2
term2 = value2 * 10 * factor2
term3 = rest2

res1 = value1 * 100 
res2 = value2 * 10
res3 = result - res1 - res2
        

   

   
