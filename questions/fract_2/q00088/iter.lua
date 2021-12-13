
choice = math.random(3) 

whole = math.random(5) - 1 	--[[10]]--
if (choice < 3) then
    if (choice == 1) then    	
        denom = math.random(4) + 1    --[[8]]--
    else
	    denom = 10
    end		
    enum = math.random(denom - 1)
    q = lib.math.gcd(denom, enum)
    denom = denom/q
    enum = enum/q 
else
    denom = 1
    enum = 0
    whole = whole + 1		
end
broj = whole * denom + enum
value = broj / denom
 
 
term = ""
if (choice == 1) then    	
    if (whole ~= 0) then
	    term = tostring(whole)
    end
    term = term .. "\(\frac{" .. tostring(math.floor(enum)) .. "}{" .. tostring(math.floor(denom)) .. "}\)"
else 
    term = lib.dec_to_str(lib.math.round_dec(value,1)) 			
end	

ind = math.random(6)

quest = ""
if (ind == 1) then
    quest = quest .. "√(" .. term .. ")² " 
end
if (ind == 2) then
    quest = quest .. "√(-" .. term .. ")² " 
end	
if (ind == 3) then
     quest = quest .. "√-(" .. term .. ")² "
end	
if (ind == 4) then
    quest = quest .. "- √-(" .. term .. ")² " 	
end	
if (ind == 5) then
     quest = quest .. "- √(" .. term .. ")² " 	
end	
if (ind == 6) then
    quest = quest .. "- √(-" .. term .. ")² " 
end	

reply = ""
if (ind < 3) then
    if (choice == 1) then   	   					
        if (whole ~= 0) then
	        reply = reply .. lib.check_number(whole,30)  
        end	
	    reply = reply .. lib.check_fraction_simple(enum, denom)		
	else		
        reply = reply .. lib.check_number(value, 30)
	end	
else 
    if (ind > 4) then
	    ceo = - whole
		sol = - value
        if (choice == 1) then   	   					
            if (ceo ~= 0) then
	            reply = reply .. lib.check_number(ceo,30)  
				broj = enum
            else
                broj = - enum			
            end	
	        reply = reply .. lib.check_fraction_simple(broj, denom)		
	    else		
            reply = reply .. lib.check_number(sol, 30)
	    end
    else
	    reply = reply .. lib.check_string("n", 30)   
    end		
end 
