
proc = "%"

ind = math.random(3)
denom = 10^ind 
enum = 2 + math.random(2*denom - 5);	
value = enum / denom

result = value * 100
round = 0
if (ind > 2) then
    round = ind - 2
end	
resround = lib.math.round_dec(result, round)

q = lib.math.gcd(enum, denom)
enum = enum / q
denom = denom / q

condition = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"	          
solution = "numerator="..tostring(enum)..";denominator="..tostring(denom)..";"
ans =  lib.check_fraction_condition(condition, nil, nil, solution)

            


