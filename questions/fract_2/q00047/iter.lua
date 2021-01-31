
set = {2, 2, 2, 3, 3, 5, 7}
dim = 7

enum = {}
denom = {}
whl = {}
enum_p = {}
brojilac = {}
imenilac = {}
value = {}
qq = {}

choice = math.random(2)
max = 200
for i = 1,2 do
    qq = lib.math.random_shuffle(set)
    ind = 1 + math.random(2)
	denom[i] = 1
	for j = 1,ind do
	    if (i == choice) then 
		    if (qq[j] == 3 or qq[j] == 7) then
                denom[i] = denom[i] * 5;
			else
                denom[i] = denom[i] * qq[j];
            end				
        else			
            denom[i] = denom[i] * qq[j];	
		end	
	end	 
    enum[i] = 5 + math.random(max);	 
    value[i] = enum[i] / denom[i]
    if (value[i] == math.floor(value[i])) then
	    enum[i] = enum[i] + 1
		value[i] = enum[i] / denom[i]
	end	
end	

chind = 3
for j = 1,3 do
    temp = value[choice] * 10^(4-j) 
    if (math.abs(lib.math.round(temp) - temp) < 0.0001) then
	    chind = 4-j
	end	
end
denom[choice] = 10^chind	    
enum[choice] = value[choice] * denom[choice]

for i = 1,2 do
    if (i ~= choice) then
        whl[i] =  math.floor(enum[i]/denom[i])
	    enum_p[i] = enum[i] - denom[i] * whl[i]
	end	
end	 

term1 = ""
if (choice == 1) then
    term1 = term1 .. lib.dec_to_str(lib.math.round_dec(value[1],chind))
else     
    if (whl[1] ~= 0) then
        term1 = term1 .. whl[1]
    end
    term1 = term1 .. "\(\frac{" .. math.floor(enum_p[1]) .. "}{" .. math.floor(denom[1]).. "}\)" 	
end	
	
term2 = ""
if (choice == 2) then
    term2 = term2 .. lib.dec_to_str(lib.math.round_dec(value[2],chind))
else 
    if (whl[2] ~= 0) then
        term2 = term2 .. whl[2]
    end
    term2 = term2 .. "\(\frac{" .. math.floor(enum_p[2]) .. "}{" .. math.floor(denom[2]).. "}\)" 	
end	
	 
result = value[1] * value[2]

imen = denom[1] * denom[2]
broj = enum[1] * enum[2]
q = lib.math.gcd(imen, broj)
broj = broj / q
imen = imen / q
ceo = math.floor(broj/imen)
broj = broj - ceo * imen

ans2 = ""

if (ceo == 0) then
    condition = "is_ok = math.eq(numerator/denominator, "..tostring(result)..");"	          
    solution = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
    ans2 =  lib.check_fraction_condition(condition, nil, nil, solution)
else
    condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(result)..");"	          
    solution = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";whole="..tostring(ceo)..";"
    ans2 =  lib.check_fraction_condition(condition, true, nil, solution)
end	

q1 = lib.math.gcd(enum[1], denom[1])
q2 = lib.math.gcd(enum[2], denom[2])
if (q1 * q2 ~= 1) then
    brojilac[1] = enum[1]/q1
    imenilac[1] = denom[1]/q1	
    brojilac[2] = enum[2]/q2
    imenilac[2] = denom[2]/q2	
else
    brojilac[1] = enum[1]
    imenilac[1] = denom[1]	
    brojilac[2] = enum[2]
    imenilac[2] = denom[2]	
end	
	
q3 = lib.math.gcd(brojilac[1], imenilac[2])
q4 = lib.math.gcd(brojilac[2], imenilac[1])
if (q3 * q4 ~= 1) then
    brojilac[1] = brojilac[1]/q3
    brojilac[2] = brojilac[2]/q4
    imenilac[1] = imenilac[1]/q4
    imenilac[2] = imenilac[2]/q3
end	

ans1 = ""	
if(q1 * q2 * q3 * q4 ~= 1) then
   ans1 = lib.check_fraction_simple(brojilac[1],imenilac[1]) .. "*" .. lib.check_fraction_simple(brojilac[2],imenilac[2]) .. " = "
end       