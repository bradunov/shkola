
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
    if (value[1] == math.floor(value[1])) then
	    enum[1] = enum[1] + 1
		value[1] = enum[1] / denom[1]
	end		
end	

for i = 1,2 do
    whl[i] =  math.floor(enum[i]/denom[i])
	enum_p[i] = enum[i] - denom[i] * whl[i]
end	 
	 
index = math.random(2)
if (value[1] < value[2]) then
    index = 2
end	

q = lib.math.gcd(denom[1], denom[2])
imenilac = denom[1] * denom[2] / q
brojilac[1] = enum[1] * denom[2]/q
brojilac[2] = enum[2] * denom[1]/q

if (index == 2 ) then
    sign = "+"
	summ = brojilac[1] + brojilac[2]
else 
    sign = "-"	
	summ = brojilac[1] - brojilac[2]	
end

gcd = lib.math.gcd(imenilac, summ)
broj = summ / gcd
imen = imenilac / gcd
ceo = math.floor(broj/imen)
broj = broj - ceo * imen

if (ceo == 0) then
    ans =  lib.check_fraction_simple(broj, imen) 
else
    ans =  lib.check_number(ceo,20) .. lib.check_fraction_simple(broj, imen)   
end	

