
factor2 = math.random(6) + 2;
temp = math.floor(1000/factor2)
factor1 = math.random(temp - 110) + 110;

value1 = math.floor(factor1/100)
rest1 = factor1 - value1 * 100
value2 = math.floor(rest1/10)
rest2 = rest1 - value2 * 10

if (rest2 == 0) then
    factor1 = factor1 - 1
    value1 = math.floor(factor1/100)
	rest1 = factor1 - value1 * 100
    value2 = math.floor(rest1/10)
    rest2 = rest1 - value2 * 10
end

term1 = value1 * 100
term2 = value2 * 10
term3 = rest2

res1 = term1 * factor2
res2 = term2 * factor2
res3 = term3 * factor2

result = factor1 * factor2
                 

   
