
numb = {}

total = 70 + math.random(25); 
tmp = total - 10

numb[1] = 20 + math.random(15);
numb[2] = 10 + math.random(tmp - numb[1] - 10);
if (numb[2] < numb[1]) then
	bound = numb[2]
else
	bound = numb[1]	
end	
numb[3] = 8 + math.random(bound - 10);

enum = total - (numb[1] + numb[2]);
result = enum/total
qq = lib.math.gcd(enum,total)
enum = math.floor(enum/qq)
denom = math.floor(total/qq)
condition = "is_ok = math.eq(numerator/denominator, "..tostring(result)..");"                     
solution = "numerator="..tostring(enum)..";denominator="..tostring(denom)..";"	
answ = lib.check_fraction_condition(condition, nil, nil, solution)
   
        