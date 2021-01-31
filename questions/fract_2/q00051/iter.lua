
set = {2, 2, 2, 3, 3, 5, 7}

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
qq = {}

min = 1
max = 10

choice = math.random(3)
for i = 1,2 do
    qq = lib.math.random_shuffle(set)
    ind = math.random(2)
	denom[i] = 1
	for j = 1,ind do
	    if (choice == ITEM and i == 2) then 
		    if (qq[j] == 3 or qq[j] == 7) then
                denom[i] = denom[i] * 5;
			else
                denom[i] = denom[i] * qq[j];
            end	
        else			
            denom[i] = denom[i] * qq[j];
		end	
	end	
	if (i == 2) then
	    min = math.floor(value[1] * denom[2])
		max = max + min
	end	
    enum[i] = min + math.random(max);	 
    value[i] = enum[i] / denom[i]
    if (i == 1 and value[i] == math.floor(value[i])) then
	    enum[i] = enum[i] + 1
		value[i] = enum[i] / denom[i]
	end	
end	

for i = 1,2 do
	if (choice == ITEM and i == 2) then 
        chind = 3
        for j = 1,3 do
            temp = value[i] * 10^(4-j) 
            if (math.abs(lib.math.round(temp) - temp) < 0.0001) then
	            chind = 4-j
	        end	
        end
        denom[i] = 10^chind	    
        enum[i] = value[i] * denom[i]	
	else
		q = lib.math.gcd(enum[i], denom[i])
		enum[i] = enum[i]/q
		denom[i] = denom[i]/q	
        whl[i] =  math.floor(enum[i]/denom[i])
	    enum_p[i] = enum[i] - denom[i] * whl[i]
	end	
end	 

term1 = ""
if (whl[1] ~= 0) then
    term1 = term1 .. whl[1]
end
term1 = term1 .. "\(\frac{" .. math.floor(enum_p[1]) .. "}{" .. math.floor(denom[1]).. "}\)" 	

term2 = ""
if (choice == ITEM) then 
    term2 = term2 .. lib.dec_to_str(lib.math.round_dec(value[2], chind))
else
    if (whl[2] ~= 0) then
        term2 = term2 .. whl[2]
    end
	if (enum_p[2] ~= 0) then
        term2 = term2 .. "\(\frac{" .. math.floor(enum_p[2]) .. "}{" .. math.floor(denom[2]).. "}\)" 
    end		
end
	 
result = value[1] * value[2]

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
    if ( broj == 0) then
	    ans = lib.check_number(math.floor(ceo))
	else
        condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(result)..");"	          
        solution = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";whole="..tostring(ceo)..";"
        ans =  lib.check_fraction_condition(condition, true, nil, solution)
	end	
end	     
   