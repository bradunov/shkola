 
choice = out[ITEM]
index = math.floor(0.1 * choice)
ind = choice - 10 * index

if (ind == qst) then
    reply = msg[1]
else
    reply = msg[2]
end
	

term_right = ""

if (index == 1) then	
	term = ""
		broj = enum[1] * enum[3]
		imen = denom[1] * denom[3]
		qq = lib.math.gcd(broj, imen)
		broj = math.floor(broj/qq)
		imen = math.floor(imen/qq)		
		val = broj/imen
		rest = 10*val - math.floor(10*val)		
		if (val ~= 1) then
			if (rest == 0) then
				term = term .. lib.dec_to_str(lib.math.round_dec(val,1)) 		
			else		
				term = term .. "\(\frac{" .. tostring(broj) .."}{" .. tostring(imen) .. "}\)"
			end	
		end
		term = term .. "x"	
	free = ""
	coef = ""	
	term_right = term
	if (ind == 2 or ind == 4) then
		term_right = "- " .. term_right
	end	
	fct = " "
		brojilac = enum[3] * enum[2]
		imenilac = denom[3] * denom[2]		
		if (ind == 2 or ind == 3) then	
			broj = enum[4] * imenilac - brojilac * denom[4]	
		else
			broj = enum[4] * imenilac + brojilac * denom[4]	
		end	
		imen = imenilac * denom[4]	
		qq = lib.math.gcd(broj, imen)
		broj = math.floor(broj/qq)
		imen = math.floor(imen/qq)
		val = broj/imen
		rest = 10*val - math.floor(10*val)
		tmp = math.abs(broj)		
		if (rest == 0) then
			fct = lib.dec_to_str(lib.math.round_dec(tmp/imen,1)) 				
		else
			fct = "\(\frac{" .. tostring(tmp) .."}{" .. tostring(imen) .. "}\)"		
		end  	
	if (val < 0) then
		term_right = term_right .. " - " .. fct 
	else
		term_right = term_right .. " + " .. fct 		
	end   						        	
end

if (index == 2) then	
	term = ""
		val = enum[3]/denom[3]
		if (val ~= 1) then
			if (ch[3] < 3) then
				term = term .. lib.dec_to_str(lib.math.round_dec(val,1)) 		
			else		
				term = term .. "\(\frac{" .. tostring(enum[3]) .."}{" .. tostring(denom[3]) .. "}\)"
			end	
		end
	term = term .. "x"	
	free = ""
		brojilac = enum[4] * denom[1]
		imenilac = denom[4] * enum[1]
		qq = lib.math.gcd(brojilac, imenilac)
		brojilac = math.floor(brojilac/qq)
		imenilac = math.floor(imenilac/qq)	
		valac = brojilac/imenilac
		rest = 10*valac - math.floor(10*valac)		
		if (rest == 0) then
			free = lib.dec_to_str(lib.math.round_dec(valac,1)) 				
		else
			free = "\(\frac{" .. tostring(brojilac) .."}{" .. tostring(imenilac) .. "}\)"		
		end  			
	if (ind == 2 or ind == 4) then
		term_right = free .. " - " .. term
	else
		term_right = term .. " + " .. free	
	end	
	coef = ""
		val = enum[1]/denom[1]
		if (val ~= 1) then
			if (ch[1] < 3) then
				coef = lib.dec_to_str(lib.math.round_dec(val,1)) 		
			else		
				coef = "\(\frac{" .. tostring(enum[1]) .."}{" .. tostring(denom[1]) .. "}\)"
			end	
		end	
	term_right = coef .. brac[1] .. term_right .. brac[2] 
	fct = ""
		broj = enum[2] * enum[3] 
		imen = denom[2] * denom[3]	
		qq = lib.math.gcd(broj, imen)
		broj = math.floor(broj/qq)
		imen = math.floor(imen/qq)
		val = broj/imen
		rest = 10*val - math.floor(10*val)		
		if (rest == 0) then
			fct = lib.dec_to_str(lib.math.round_dec(val,1)) 				
		else
			fct = "\(\frac{" .. tostring(broj) .."}{" .. tostring(imen) .. "}\)"		
		end  	
	if (ind == 2 or ind == 3) then	
		term_right = term_right .. " - " .. fct 
	else
		term_right = term_right .. " + " .. fct 	
	end   						        		
end

if (index == 3) then	
	term = ""
		val = enum[1]/denom[1]
		if (val ~= 1) then
			if (ch[1] < 3) then
				term = term .. lib.dec_to_str(lib.math.round_dec(enum[1]/denom[1],1)) 		
			else		
				term = term .. "\(\frac{" .. tostring(enum[1]) .."}{" .. tostring(denom[1]) .. "}\)"
			end	
		end
		term = term .. "x"
	free = ""	
		broj = enum[4] * denom[3]
		imen = denom[4] * enum[3]
		qq = lib.math.gcd(broj, imen)
		broj = math.floor(broj/qq)
		imen = math.floor(imen/qq)		
		val = broj/imen
		rest = 10*val - math.floor(10*val)		
		if (rest == 0) then
			free = lib.dec_to_str(lib.math.round_dec(broj/imen,1)) 				
		else
			free = "\(\frac{" .. tostring(broj) .."}{" .. tostring(imen) .. "}\)"		
		end 
	coef = ""	
		if (ch[3] < 3) then
			coef = lib.dec_to_str(lib.math.round_dec(enum[3]/denom[3],1)) 		
		else		
			coef =  "\(\frac{" .. tostring(math.floor(enum[3])) .."}{" .. tostring(math.floor(denom[3])) .. "}\)"
		end	
	fct = " "			
		brojilac = enum[2] * enum[3] 
		imenilac = denom[2] * denom[3] 			
		qq = lib.math.gcd(brojilac, imenilac)
		brojilac = math.floor(brojilac/qq)
		imenilac = math.floor(imenilac/qq)
		valac = brojilac/imenilac
		rest = 10*valac - math.floor(10*valac)		
		if (rest == 0) then
			fct = lib.dec_to_str(lib.math.round_dec(brojilac/imenilac,1)) 				
		else
			fct = "\(\frac{" .. tostring(brojilac) .."}{" .. tostring(imenilac) .. "}\)"		
		end  			
	term_right = term	
	if (ind == 2 or ind == 4) then
		if (val < 0) then
			term_right = " - " .. free .. " - " .. term_right  	
		else
			term_right = free .. " - " .. term_right		
		end 
	else
		if (val < 0) then
			term_right = term_right .. " - " .. free	
		else
			term_right = term_right .. " + " .. free		
		end 
	end		
	term_right = coef .. brac[1] .. term_right .. brac[2] 			
	if (ind == 2 or ind == 3) then
		term_right = term_right .. " - " .. fct
	else
		term_right = term_right .. " + " .. fct	
	end				
end

if (index == 4) then	
	term = ""
		val = enum[3]/denom[3]
		if (val ~= 1) then
			if (ch[3] < 3) then
				term = term .. lib.dec_to_str(lib.math.round_dec(enum[3]/denom[3],1)) 		
			else		
				term = term .. "\(\frac{" .. tostring(enum[3]) .."}{" .. tostring(denom[3]) .. "}\)"
			end	
		end
		term = term .. "x"
	free = ""	
		broj = enum[2] * enum[3] * denom[1]
		imen = denom[2] * denom[3] * enum[1]	
		qq = lib.math.gcd(broj, imen)
		broj = math.floor(broj/qq)
		imen = math.floor(imen/qq)		
		val = broj/imen
		rest = 10*val - math.floor(10*val)		
		if (rest == 0) then
			free = lib.dec_to_str(lib.math.round_dec(val,1)) 				
		else
			free = "\(\frac{" .. tostring(math.floor(broj)) .."}{" .. tostring(math.floor(imen)) .. "}\)"		
		end 
	coef = ""	
		if (ch[1] < 3) then
			coef = lib.dec_to_str(lib.math.round_dec(enum[1]/denom[1],1)) 		
		else		
			coef =  "\(\frac{" .. tostring(math.floor(enum[1])) .."}{" .. tostring(math.floor(denom[1])) .. "}\)"
		end	
	fct = " "					
		if (ch[4] < 3) then
			fct = lib.dec_to_str(lib.math.round_dec(enum[4]/denom[4],1)) 		
		else		
			fct =  "\(\frac{" .. tostring(math.floor(enum[4])) .."}{" .. tostring(math.floor(denom[4])) .. "}\)"
		end			
	term_right = term	
	if (ind > 2)  then
		term_right = free .. " - " .. term_right  	
	else
		term_right = term_right .. " + " .. free		
	end	
	term_right = coef .. brac[1] .. term_right .. brac[2] 			
	if (ind == 2 or ind == 3) then
		term_right = fct .. " - " .. term_right 
	else
		term_right = term_right .. " + " .. fct	
	end			
end