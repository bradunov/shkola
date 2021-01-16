                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
set = {2, 2, 2, 3, 3, 5}
dim = 6

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
qq = {}
brojilac = {}

choice = math.random(2)
max = 500
for i = 1,2 do
    qq = lib.math.random_shuffle(set)
    ind = 1 + math.random(3)
	denom[i] = 1
	for j = 1,ind do
	    if (i == choice and qq[j] == 3) then
            denom[i] = denom[i] * 5;
        else			
            denom[i] = denom[i] * qq[j];
		end	
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

index = math.random(2)
if (value[1] < value[2]) then
    index = 1
end	


for j = 1,3 do
    temp = value[choice] * 10^(4-j) 
    if (lib.math.round(temp) == temp) then
	    chind = 10^(4-j)
	end	
end	    
enum[choice] = value[choice] * chind
denom[choice] = chind

for i = 1,2 do
    whl[i] =  math.floor(enum[i]/denom[i])
	enum_p[i] = enum[i] - denom[i] * whl[i]
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

quest = ""

if (choice == 1) then
   up = lib.math.round(enum_p[2])
   down = lib.math.round(denom[2])
   quest = value[1] .. " " .. sign .. " " .. whl[2]  .. "\(\frac{" .. up .. "}{" .. down .. "}\)"  
else
   up = lib.math.round(enum_p[1])
   down = lib.math.round(denom[1])
   quest = whl[1] .. "\(\frac{" .. up .. "}{" .. down .. "}\) " .. sign .. " " .. value[2]
end
               
    