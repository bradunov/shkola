
choice = math.random(4)
for i = 1,4 do
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
		
chind = 3
for j = 1,3 do
    temp = value[choice] * 10^(4-j) 
    if (math.abs(lib.math.round(temp) - temp) < 0.0001) then
	    chind = 4-j
	end	
end
denom[choice] = 10^chind	    
enum[choice] = value[choice] * denom[choice]

for i = 1,4 do
    if (i ~= choice) then
        whl[i] =  math.floor(enum[i]/denom[i])
	    enum_p[i] = enum[i] - denom[i] * whl[i]
	end	
end

out = lib.dec_to_str(lib.math.round_dec(value[choice], chind))

reply = ""
for i = 1,4 do   
    if (i == 4) then
	    sg = ""
	else
        sg = " * " 
    end 		
    if (i == choice) then
        reply = reply .. out .. " " .. sg .. " "
    else
        if (whl[i] ~= 0) then
            reply = reply .. whl[i] 
        end
	    if (enum_p[i] ~= 0) then
            reply = reply .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\) "   
		end
        reply = reply .. sg .. " "   		
    end
end

result = 1
imenilac = 1
brojilac = 1
for i = 1,4 do
    imenilac = imenilac * denom[i]
    brojilac = brojilac * enum[i]	
	result = result * value[i]
end	
		
q = lib.math.gcd(imenilac, brojilac)
broj = brojilac/ q
imen = imenilac / q
ceo = math.floor(broj/imen)
broj = broj - ceo * imen

ans = ""
if (result == 0) then
    ans = lib.check_number(0,20)
else	
    if (ceo ~= 0) then
        ans = ans .. lib.check_number(ceo,40) 
    end
	if (broj ~= 0) then
        ans = ans .. lib.check_fraction_simple(broj, imen)   	
    end
end	         
	 
            




	 