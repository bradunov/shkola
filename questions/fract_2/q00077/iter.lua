
choice = math.random(2) 

whole = math.random(10) - 1 	
if (choice == 1) then	
    denom = math.random(8) + 1
    enum = math.random(denom - 1)	
else
    ind = math.random(3) - 1
	denom = 10^ind
	if (ind == 0) then
        enum = 0			
    else
        enum = math.random(denom - 1)
    end		
end
broj = whole * denom + enum
 
sign = math.random(2)
if (sign == 1) then
    broj = - broj
	whole = - whole
	if (whole == 0) then
	    enum = - enum
	end
end	
value = broj / denom	


quest = ""
if (choice == 1) then
    if (whole ~= 0) then
	    quest = quest .. whole
    end
    quest = quest .. "\(\frac{" .. enum .. "}{" .. denom .. "}\)"
else 
    if (ind == 0) then
        quest = quest .. whole 	
    else 	
        quest = quest .. lib.dec_to_str(lib.math.round_dec(value, ind)) 
	end
end	

q = lib.math.gcd(denom, broj)
brojilac = denom/q
imenilac = broj/q 
if (sign == 1) then
    brojilac = - brojilac
	imenilac = - imenilac
end	
result = brojilac/imenilac

answ1= ""
answ2= ""
if (result > 0) then
    swhole = math.floor(result)
else 
    swhole = math.ceil(result)
end	
rest = brojilac - swhole * imenilac
if (swhole ~= 0) then   	
    answ1 = lib.check_number(swhole,20)
    rest = math.abs (rest)	
end	
if (rest ~= 0) then	
    tmp = rest/imenilac
	condition2 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"
    sln2 = "numerator="..tostring(rest)..";denominator="..tostring(imenilac)..";"
    answ2 = answ2 .. lib.check_fraction_condition(condition2, nil, nil, sln2)
end	


