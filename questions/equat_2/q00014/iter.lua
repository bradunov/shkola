
set = {2, 2, 2, 3, 3, 5}

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
qq = {}

comp = {"\(\leq\)", "\(\lt\)", "\(\geq\)", "\(\gt\)"}

ineq = math.random(4)

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

sign = math.random(2)
index = math.random(2)

if (sign == 1) then
    znak = "+"
    result = value[1] * value[2] + value[3]
else
    znak = "-"	 
    result = value[1] * value[2] - value[3]
    index = 1
    if (result < 0 ) then   
        result = value[3] - value[1] * value[2] 
        index = 2
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

term2 = ""
if (choice == 2) then
    term2 = term2 .. lib.dec_to_str(lib.math.round_dec(value[2],chind))
else 
    if (whl[2] ~= 0) then
        term2 = term2 .. whl[2]
    end
    term2 = term2 .. "\(\frac{" .. math.floor(enum_p[2]) .. "}{" .. math.floor(denom[2]).. "}\)" 	
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

imenilac = denom[1] * denom[2]
brojilac = enum[1] * enum[2]
imen = imenilac * denom[3]
if (sign == 1) then
    broj = brojilac * denom[3] + imenilac * enum[3]
	relat = comp[ineq]
else
    if (index == 1) then
        broj = brojilac * denom[3] - imenilac * enum[3]
		relat = comp[ineq]
	else
        broj = imenilac * enum[3] - brojilac * denom[3]	
		if (ineq < 3) then
		    relat = comp[ineq+2]
		else
		    relat = comp[ineq-2]
        end			
    end		
end	
q = lib.math.gcd(imen, broj)
broj = broj / q
imen = imen / q
ceo = math.floor(broj/imen)
broj = broj - ceo * imen


if (index == 1) then
   ans1 = term2 .. "x" .. " " .. znak .. " " .. term3       
else
   ans1 = term3 .. " " .. znak .. " " .. term2 .. "x"
end   

ans2 = ""
if (ceo ~= 0) then
    ans2 = math.floor(ceo)
end
if (broj ~=0) then
    ans2 =  ans2 .. "\(\frac{" .. math.floor(broj) .. "}{" .. math.floor(imen).. "}\)" 
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
