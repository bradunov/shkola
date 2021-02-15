
set = {2, 2, 2, 3, 3, 5}

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
qq = {}

choice = 1 + math.random(3)
max = 50
for i = 1,3 do
    qq = lib.math.random_shuffle(set)
    ind = math.random(2)
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
    enum[i] = 1 + math.random(max);	 
    value[i] = enum[i] / denom[i]
    if (value[i] == math.floor(value[i])) then
	    enum[i] = enum[i] + 1
		value[i] = enum[i] / denom[i]
	end	
end	
if (value[2] == value[3]) then
    enum[2] = enum[2] + math.random(5)
    value[2] = enum[2] / denom[2]
end	

sign = math.random(2)
index = math.random(2)
temp = value[2] - value[3]
brojilac = enum[2] * denom[3] - enum[3] * denom[2]
imen = denom[1] * denom[2] * denom[3]
if (sign == 1) then
    znak = "+"
    if (temp > 0) then
		result = temp * value[1]
		broj = brojilac * enum[1]
	else
	    index = 2
        sign = 2	
        znak = "-"		
		result = -temp * value[1]
		broj = -brojilac * enum[1]		
	end	
else
    znak = "-"	 
    if (temp < 0) then
	    index = 2
		result = -temp * value[1]
		broj = -brojilac * enum[1]		
	else
	    index = 1	
		result = (value[2] + value[3]) * value[1]	
		broj = (enum[2] * denom[3] + enum[3] * denom[2]) * enum[1]		
	end	
end  

if (choice < 4) then
    chind = 3
    for j = 1,3 do
        temp = value[choice] * 10^(4-j) 
        if (math.abs(lib.math.round(temp) - temp) < 0.0001) then
	        chind = 4-j
	    end	
    end
end	

for i = 1,3 do
    q = lib.math.gcd(enum[i], denom[i])
    enum[i] = enum[i] / q
    denom[i] = denom[i] / q
    whl[i] =  math.floor(enum[i]/denom[i])
    enum_p[i] = enum[i] - denom[i] * whl[i]
end	 

q = lib.math.gcd(imen, broj)
broj = broj / q
imen = imen / q
ceo = math.floor(broj/imen)
broj = broj - ceo * imen

ans2 = ""
if (choice == 2) then
    ans2 = ans2 .. lib.dec_to_str(lib.math.round_dec(value[2],chind))
else 
    if (whl[2] ~= 0) then
        ans2 = ans2 .. whl[2]
    end
    ans2 = ans2 .. "\(\frac{" .. math.floor(enum_p[2]) .. "}{" .. math.floor(denom[2]).. "}\)" 	
end	

term3 = ""
if (choice == 3) then
    term3 = term3 .. lib.dec_to_str(lib.math.round_dec(value[3],chind))
else 
    if (whl[3] ~= 0) then
        term3 = term3 .. whl[3]
    end
    term3 = term3 .. "\(\frac{" .. math.floor(enum_p[3]) .. "}{" .. math.floor(denom[3]).. "}\)" 	
end	

term2 = ""
if (ceo ~= 0) then
    term2 = math.floor(ceo)
end
if (broj ~=0) then
    term2 =  term2 .. "\(\frac{" .. math.floor(broj) .. "}{" .. math.floor(imen).. "}\)" 
end

if (index == 1) then
   ans1 = term2 .. " : x" .. " " .. znak .. " " .. term3     
else
   ans1 = term3 .. " " .. znak .. " " .. term2 .. " : x"
end   

reply = ""                       
if (whl[1] == 0) then
    condition = "is_ok = math.eq(numerator/denominator, "..tostring(value[1])..");"	          
    solution = "numerator="..tostring(enum_p[1])..";denominator="..tostring(denom[1])..";"
    reply =  lib.check_fraction_condition(condition, nil, nil, solution)
else
    condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(value[1])..");"	          
    solution = "numerator="..tostring(enum_p[1])..";denominator="..tostring(denom[1])..";whole="..tostring(whl[1])..";"
    reply =  lib.check_fraction_condition(condition, true, nil, solution)
end	
           