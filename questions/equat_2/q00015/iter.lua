
enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
qq = {}

choice = math.random(2)
max_range = 50
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
    enum[i] = 5 + math.random(max_range);	 
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

for i = 1,2 do
    q = lib.math.gcd(enum[i],denom[i])
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


sign = math.random(2)

if (sign == 1) then
    result = value[1] * value[2]
	imen = denom[1] * denom[2]
    broj = enum[1] * enum[2]
else
    result = value[1] / value[2]
	imen = denom[1] * enum[2]
    broj = enum[1] * denom[2]	
end	
q = lib.math.gcd(imen, broj)
broj = broj / q
imen = imen / q
ceo = math.floor(broj/imen)
broj = broj - ceo * imen	

term3 = ""
if (ceo ~= 0) then
    term3 = math.floor(ceo)
end
if (broj ~=0) then
    term3 =  term3 .. "\(\frac{" .. math.floor(broj) .. "}{" .. math.floor(imen).. "}\)" 
end
	
index = math.random(2)	
fct = math.random(2) -1
sg = sign + 2*fct
  
quest = ""
if (index == 1) then
    quest = msg1[1] .. oper[sign] .. msg1[2] .. term1 .. msg1[3] .. comp[sg] .. msg1[4] .. term3
else
    quest = msg2[1] .. oper[sign] .. term2 .. msg2[2] .. comp[sg] .. msg1[4] .. term3
end

if (index == 2) then  
    if (sign == 2) then
        reply = "0 " .. lib.check_one_option_dropdown(relat, relat[4]) .. " x " .. lib.check_one_option_dropdown(relat, relat[sg]) 	
	else
        reply = "x " .. lib.check_one_option_dropdown(relat, relat[sg])
    end		
    if (whl[1] == 0) then
        condition = "is_ok = math.eq(numerator/denominator, "..tostring(value[1])..");"	          
        solution = "numerator="..tostring(enum_p[1])..";denominator="..tostring(denom[1])..";"
        reply = reply .. lib.check_fraction_condition(condition, nil, nil, solution)
    else
        condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(value[1])..");"	          
        solution = "numerator="..tostring(enum_p[1])..";denominator="..tostring(denom[1])..";whole="..tostring(whl[1])..";"
        reply = reply .. lib.check_fraction_condition(condition, true, nil, solution)
    end	
else
    reply = "x " .. lib.check_one_option_dropdown(relat, relat[1+2*fct]) 
    if (whl[2] == 0) then            
        condition = "is_ok = math.eq(numerator/denominator, "..tostring(value[2])..");"	          
        solution = "numerator="..tostring(enum_p[2])..";denominator="..tostring(denom[2])..";"
        reply = reply .. lib.check_fraction_condition(condition, nil, nil, solution)
    else
        condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(value[2])..");"	          
        solution = "numerator="..tostring(enum_p[2])..";denominator="..tostring(denom[2])..";whole="..tostring(whl[2])..";"
        reply = reply .. lib.check_fraction_condition(condition, true, nil, solution)
    end	
end	                  
          