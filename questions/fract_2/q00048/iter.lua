
enum = {}
denom = {}
brojilac = {}
imenilac = {}
value = {}

min = 100
max = 1000
round = 0
for i = 1,2 do
    ind = math.random(3)
	round = round + ind
	denom[i] = 10^ind 
    enum[i] = min + math.random(max-min-10);	
    if (enum[i] - 10 * math.floor(enum[i]/10) == 0) then
	    enum[i] = enum[i] + 1
	end		
    value[i] = enum[i] / denom[i]
    if (value[i] == math.floor(value[i])) then
	    enum[i] = enum[i] + 1
		value[i] = enum[i] / denom[i]                   
	end	
end	
 
result = value[1] * value[2]
resround = lib.math.round_dec(result, round)

imen = denom[1] * denom[2]
broj = enum[1] * enum[2]
q = lib.math.gcd(imen, broj)
broj = broj / q
imen = imen / q
ceo = math.floor(broj/imen)
broj = broj - ceo * imen

ans = ""

if (ceo == 0) then
    condition = "is_ok = math.eq(numerator/denominator, "..tostring(result)..");"	          
    solution = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
    ans =  lib.check_fraction_condition(condition, nil, nil, solution)
else
    condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(result)..");"	          
    solution = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";whole="..tostring(ceo)..";"
    ans =  lib.check_fraction_condition(condition, true, nil, solution)
end	
