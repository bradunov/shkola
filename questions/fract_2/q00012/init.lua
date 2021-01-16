
set = {2, 2, 2, 3, 3, 5}
dim = 6

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
qq = {}
brojilac = {}

max = 500
for i = 1,2 do
    qq = lib.math.random_shuffle(set)
    ind = 1 + math.random(3)
	denom[i] = 1
	for j = 1,ind do
        denom[i] = denom[i] * qq[j];
	end	 
    enum[i] = denom[i] + math.random(max-denom[i]);	 
    value[i] = enum[i] / denom[i]
    if (value[i] == math.floor(value[i])) then
	    enum[i] = enum[i] + 1
		value[i] = enum[i] / denom[i]
	end	
end	

temp1 = value[1] + value[2]
rest1 = temp1 - math.floor(temp1)
temp2 = math.abs(value[1] - value[2])
rest2 = temp2 - math.floor(temp2)
if (rest1 * rest2 == 0) then
    enum[1] = enum[1] + 1
    value[1] = enum[1] / denom[1]	 
end	

for i = 1,2 do
    whl[i] =  math.floor(enum[i]/denom[i])
	enum_p[i] = enum[i] - denom[i] * whl[i]
end	 
	 
index = math.random(2)
if (value[1] < value[2]) then
    index = 1
end	

q = lib.math.gcd(denom[1], denom[2])
imenilac = denom[1] * denom[2] / q
brojilac[1] = enum[1] * denom[2]/q
brojilac[2] = enum[2] * denom[1]/q

first = whl[1]
second = enum_p[1]
if (index == 1 ) then
    sign = "+"
	summ = brojilac[1] + brojilac[2]
	result = value[1] + value[2]
    broj_p = (enum_p[1] * denom[2] + enum_p[2] * denom[1]) / q	
	whole = whl[1] + whl[2]
else 
    sign = "-"	
	summ = brojilac[1] - brojilac[2]	
	result = value[1] - value[2]
    broj_p = (enum_p[1] * denom[2] - enum_p[2] * denom[1]) / q	
	whole = whl[1] - whl[2]
    if (broj_p < 0) then
	    first = first - 1
		second = enum_p[1] + denom[1]
		broj_p = (second * denom[2] - enum_p[2] * denom[1]) / q
		whole = whole - 1
    end			    
end

gcd = lib.math.gcd(imenilac, summ)
broj = summ / gcd
imen = imenilac / gcd
ceo = math.floor(broj/imen)
broj = broj - ceo * imen

if (ceo == 0) then
    condition = "is_ok = math.eq(numerator/denominator, "..tostring(result)..");"	          
    solution1 = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
    solution2 = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
    ans1 =  lib.check_fraction_condition(condition, nil, nil, solution1)
    ans2 =  lib.check_fraction_condition(condition, nil, nil, solution2)   
else
    condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(result)..");"	          
    solution1 = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";whole="..tostring(ceo)..";"
    solution2 = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";whole="..tostring(ceo)..";"
    ans1 =  lib.check_fraction_condition(condition, true, nil, solution1)
    ans2 =  lib.check_fraction_condition(condition, true, nil, solution2)   
end	

