 
include("terms") 

coef = {}

max_range = 5
ind = math.random(2)

term = ""
answ = "x = "

if (ind == 1) then
	for i = 1,2 do
		coef[i] = max_range - math.random(2*max_range)
	end	
    term = coef[1] .. " x = " .. coef[2]
	if (coef[1] * coef[2] == 0) then
		value = max_range - math.random(2*max_range)	
	    if (coef[1] == 0 and coef[2] == 0) then
			reply = msg[1]
		else
			if (coef[1] == 0) then 
			    reply = msg[2]
			else
				if (value == 0) then
			        reply = msg[1]		
				else
			        reply = msg[2]	
				end	
			end
		end			
	else
		res = coef[2]/coef[1]
		sg = 1
        if (res < 0) then
            sg = 2
        end          		
		ch = math.random(4)
		if (ch == 1) then
		    enum = coef[1]
			denom = coef[2]	
    	end
		if (ch == 2) then
		    enum = coef[2]
			denom = coef[1]			
    	end		
		if (ch == 3) then
		    enum = -coef[2]
			denom = coef[1]			
            sg = 3 - sg			
    	end	
		if (ch == 4) then
		    enum = -coef[1]
			denom = coef[2]			
            sg = 3 - sg			
    	end	
		value = enum/denom		
		if (value == res) then
			reply = msg[1]	
        else	
			reply = msg[2]
        end	
	end	
	if (value - lib.math.round(value) == 0) then
		answ = answ .. tostring(math.floor(value))
	else
		enum = math.abs (enum)
		denom = math.abs (denom)	
		if (sg == 2) then
			sign = " - "		
		else 
			sign = ""	
		end
		answ = answ .. sign .. "\(\frac{" .. enum .. "}{" .. denom .. "}\)"			
	end	
end

if (ind == 2) then	
	for i = 1,2 do
		coef[i] = max_range - math.random(2*max_range)
		coef[i+2] = 1 + math.random(max_range + 3)
	end	
	if (coef[1] == 0) then
	    coef[1] = math.random(max_range + 3)
	end	
	if (math.abs(coef[1]) == coef[3]) then
	    coef[1] = coef[3] - 1
	end		
	if (coef[2] == 0) then
			term = "\(\frac{" .. coef[1] .. "}{" .. coef[3] .. "}\) x = 0"
	else
		qq = lib.math.gcd(coef[2], coef[4])
		coef[2] = math.floor(coef[2]/qq)
		coef[4] = math.floor(coef[4]/qq)	
	    if (coef[1] * coef[2] < 0) then
			if (coef[1] < 0) then	    
				term = "- \(\frac{" .. math.abs(coef[1]) .. "}{" .. coef[3] .. "}\) x = "            
			else	
				term = "\(\frac{" .. coef[1] .. "}{" .. coef[3] .. "}\) x = - "      
			end	
            if (coef[4] == 1) then
				term = term .. math.abs(coef[2]) 			
			else
				term = term .. "\(\frac{" .. math.abs(coef[2]) .. "}{" .. coef[4] .. "}\)"
            end				
		else
			if (coef[1] < 0 and coef[2] < 0) then
				term = "- \(\frac{" .. math.abs(coef[1]) .. "}{" .. coef[3] .. "}\) x = - " 
				if (coef[4] == 1) then
					term = term .. math.abs(coef[2])			
				else
					term = term .. "\(\frac{" .. math.abs(coef[2]) .. "}{" .. coef[4] .. "}\)"
				end		
			else
				term = "\(\frac{" .. coef[1] .. "}{" .. coef[3] .. "}\) x = "   
				if (coef[4] == 1) then
					term = term .. coef[2]			
				else
					term = term .. "\(\frac{" .. coef[2] .. "}{" .. coef[4] .. "}\)"
				end						
			end	
		end	
	end
    imen =	coef[1] * coef[4]
    broj =	coef[2] * coef[3]
	res = broj/imen        		
	ch = math.random(4)
	if (ch == 1) then
		enum = imen
		denom = broj		
	end
	if (ch == 2) then
		enum = broj
		denom = imen			
	end		
	if (ch == 3) then
		enum = -broj
		denom = imen				
	end	
	if (ch == 4) then
		enum = -imen
		denom = broj				
	end	
	if (denom == 0) then
	    enum = coef[3]
	    denom = coef[1]
    end		
	value = enum/denom	
	if (value < 0) then
		sign = "- "
	else
		sign = ""
	end			
	if (value == res) then
		reply = msg[1]	
	else	
		reply = msg[2]
	end		
	if (value - lib.math.round(value) == 0) then
		answ = answ .. tostring(math.floor(value))
	else
		enum = math.abs (enum)
		denom = math.abs (denom)	
		answ = answ .. sign .. "\(\frac{" .. enum .. "}{" .. denom .. "}\)"			
	end			
end	
	
	
