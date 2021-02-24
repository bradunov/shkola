
index = math.random(4) 
sg = math.random(2)

choice = 5 - math.random(4)
max = 50
for i = 1,2 do
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
    enum[i] = 5 + math.random(max);	 
    value[i] = enum[i] / denom[i]
    if (value[i] == math.floor(value[i])) then
	    enum[i] = enum[i] + 1
		value[i] = enum[i] / denom[i]
	end	
end	

if (choice < 3) then
    chind = 3
    for j = 1,3 do
        temp = value[choice] * 10^(4-j) 
        if (math.abs(lib.math.round(temp) - temp) < 0.0001) then
	        chind = 4-j
	    end	
    end
    denom[choice] = 10^chind	    
    enum[choice] = value[choice] * denom[choice]
end

for i = 1,2 do
    q = lib.math.gcd(enum[i], denom[i])
    enum[i] = enum[i] / q
    denom[i] = denom[i] / q
    whl[i] =  math.floor(enum[i]/denom[i])
	enum_p[i] = enum[i] - denom[i] * whl[i]
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

term3 = ""
if (ceo ~= 0) then
    term3 = term3 .. ceo
end
if (broj ~= 0) then
    term3 = term3 .. "\(\frac{" .. math.floor(broj) .. "}{" .. math.floor(imen).. "}\)"
end	

ans = ""
if (index < 3) then
    if (whl[1] ~= 0) then
       ans = ans .. lib.check_number(math.floor(whl[1]),15)
    end
    if (enum_p[1] ~= 0) then
	    temp = value[1] - whl[1]
        condition = "is_ok = math.eq(numerator/denominator, "..tostring(temp)..");"	          
        solution = "numerator="..tostring(enum_p[1])..";denominator="..tostring(denom[1])..";"
        ans = ans .. lib.check_fraction_condition(condition, nil, nil, solution)	
    end	
else
    if (whl[2] ~= 0) then
       ans = ans .. lib.check_number(math.floor(whl[2]),15)
    end
    if (enum_p[2] ~= 0) then
	    temp = value[2] - whl[2]
        condition = "is_ok = math.eq(numerator/denominator, "..tostring(temp)..");"	          
        solution = "numerator="..tostring(enum_p[2])..";denominator="..tostring(denom[2])..";"
        ans = ans .. lib.check_fraction_condition(condition, nil, nil, solution)		
    end	
end	

neq = ""
if (index == 1) then
    neq = "x * " .. term2 .. " " .. comp_g[sg] .. term3
	reply = "x " .. comp_g[sg] .. ans	
end
if (index == 2) then
    neq = "x * " .. term2 .. " " .. comp_l[sg] .. term3
	reply = lib.check_number(0,15) .. comp_l[1] .. " x " .. comp_l[sg] .. ans
end
if (index == 3) then
    neq = term1 .. " * x " .. comp_g[sg] .. term3	
	reply = "x " .. comp_g[sg] .. ans		
end
if (index == 4) then
    neq = term1 .. " * x " .. comp_l[sg] .. term3
	reply = lib.check_number(0,15) .. comp_l[1] .. " x " .. comp_l[sg] .. ans		
end
	
  	
      