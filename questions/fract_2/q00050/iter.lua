
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
        whole = math.random(9)			
    else
        enum = math.random(denom - 1)
    end		
end
broj = whole * denom + enum
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

answ = ""
if (broj == 1) then
    answ = answ .. lib.check_number(lib.math.round(denom))
else	
    answ = answ .. lib.check_fraction_simple(denom, broj)
end	

