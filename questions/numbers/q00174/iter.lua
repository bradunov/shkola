
term1 = math.random(889) + 100;
term2 = math.random(9) + 1;

result = math.floor(term1/term2);
rest = term1 - result * term2
  
if (rest == 0) then
    temp = math.random(term2 - 1)
    term1 = term1 + temp
	rest = rest + temp
end	