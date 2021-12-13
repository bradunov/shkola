
sig = math.random(3)
ch = math.random(2) 

whole = math.random(10) - 1 	
if (ch == 2) then	
    denom = math.random(8) + 1
    enum = math.random(denom - 1)	
    q = lib.math.gcd(enum, denom)
	enum = enum / q
	denom = denom / q		
else
    index = math.random(2) - 1
	if (index == 0) then
	    denom = 1
	    enum = 0
        whole = whole + 1		
    else
	    denom = 10
        enum = math.random(denom - 1)
    end		
end
broj = whole * denom + enum
value = broj / denom	

ind = math.random(2)
area = value * value / ind
brojilac = broj * broj 
imenilac = denom * denom * ind
q = lib.math.gcd(brojilac, imenilac)
brojilac = brojilac / q
imenilac = imenilac/ q

chind = 2
for j = 1,2 do
    temp = area * 10^(3-j) 
    if (math.abs(lib.math.round(temp) - temp) < 0.0001) then
	    chind = 3-j
		ch = 1
	end	
end
out = lib.math.round_dec(area, 3)

if (ch == 2) then
    ceo =  math.floor(brojilac/imenilac)	
	brojilac_p = brojilac - imenilac * ceo	 
end	

quest = ""
if (ch == 2) then
    if (ceo ~= 0) then
	    quest = quest .. tostring(ceo)
    end
    quest = quest .. "\(\frac{" .. tostring(math.floor(brojilac_p)) .. "}{" .. tostring(math.floor(imenilac)) .. "}\)"
else 	
    quest = quest .. lib.dec_to_str(out) 
end	

answ = ""
if (ch == 1) then
    tmp = lib.math.round_dec(value,1)
	answ = answ .. lib.check_number(tmp, 30)
else 
    if (whole ~= 0) then   	
        answ = lib.check_number(whole,20)	
    end	
    tmp = enum/denom
	condition = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"
    sln = "numerator="..tostring(enum)..";denominator="..tostring(denom)..";"
    answ = answ .. lib.check_fraction_condition(condition, nil, nil, sln)
end	


