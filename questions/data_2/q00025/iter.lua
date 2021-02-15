
set = {2, 2, 2, 3, 3, 5}
dim = 6

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
qq = {}
reply = {""}
                                                                                                                                                                                                                                                                                                
ind = 1 + math.random(3)
choice = math.random(4)
aver = 0
for i = 1,ind do
    qq = lib.math.random_shuffle(set)
    index = math.random(2)
	denom[i] = 1
	for j = 1,index do
	    if (i == choice and qq[j] == 3) then
            denom[i] = denom[i] * 5;
        else			
            denom[i] = denom[i] * qq[j];
		end	
	end 
    enum[i] = 1 + math.random(5*denom[i] - 1);	 
    value[i] = enum[i] / denom[i]
	aver = aver + value[i]
end

aver = aver / ind

for i = 1,ind do
	q = lib.math.gcd(enum[i], denom[i])
	enum[i] = enum[i]/q
	denom[i] = denom[i]/q
    whl[i] =  math.floor(enum[i]/denom[i])
	enum_p[i] = enum[i] - denom[i] * whl[i]
end		

imenilac = 1
brojilac = 0
for i = 1,ind do
    imenilac = imenilac * denom[i] 
    temp = 1
    for j = 1,ind do
		if (j ~= i) then
		    temp = temp * denom[j]
		end
	end	
	brojilac = brojilac + enum[i] * temp 
end
imenilac = imenilac * ind	

g = lib.math.gcd(imenilac, brojilac)
broj = brojilac/ g
imen = imenilac / g
ceo = math.floor(broj/imen)
broj = broj - ceo * imen

out = ""
if (choice <= ind) then    
    chind = 3
    for j = 1,3 do
        temp = value[choice] * 10^(4-j) 
        if (lib.math.round(temp) == temp) then
	        chind = 4-j
	    end	
    end
    out = lib.dec_to_str(lib.math.round_dec(value[choice], chind))
end	


for i = 1,ind do  
    reply[i] = ""
    if (i == choice) then
        reply[i] = out   
    else
        if (whl[i] ~= 0) then
            reply[i] = reply[i] .. whl[i]
        end			
		if (enum_p[i] ~= 0) then		
            reply[i] = reply[i] .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"    		
        end
	end
	if (i < ind) then
	   reply[i] = reply[i] .. ", "
	end   
end

ans = ""
if (ceo == 0) then
    condition = "is_ok = math.eq(numerator/denominator, "..tostring(aver)..");"
    sln = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
    ans = lib.check_fraction_condition(condition, nil, nil, sln) 
else
	if (broj == 0) then
		ans = lib.check_number(ceo,20) 
	else
        condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(aver)..");"
        sln = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";whole="..tostring(ceo)..";"
        ans = lib.check_fraction_condition(condition, true, nil, sln)	   	
    end
end	   	 
      