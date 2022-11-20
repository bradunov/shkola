 
enum = {}
denom = {}
ch = {}
val = {}

equ = {""}

reply = {""}

choice = out[ITEM]
index = math.floor(0.1 * choice)
ind = choice - 10 * index
				
--[[koeficijenti c[3])*(c[1]x+c[2])+c[4] ]]--	

for i = 1,4 do	   
	ch[i] = 1 + math.random(2)
	if (index == 5) then
		enum[i] = max_range - math.random(2*max_range)	
    else
		enum[i] = math.random(2*max_range)
	end
	if (ch[i] == 2) then
		denom[i] = 1
	else
		denom[i] = 1 + math.random(max_range)
		qq = lib.math.gcd(enum[i], denom[i])
		enum[i] = math.floor(enum[i]/qq)
		denom[i] = math.floor(denom[i]/qq)
		if (denom[i] == 1) then
			ch[i] = 2
		else
			tmp = enum[i]/denom[i]
			rest = 10*tmp - math.floor(10*tmp)				
			if (rest == 0) then
				enum[i] = 10 * tmp
				denom[i] = 10
				ch[i] = 1			
			end	
		end	
	end
	val[i] = enum[i] / denom[i]
end

if (index == 5) then
	if (ind == 1) then     --[[c[1]*x = c[4] ]]--	
		term = ""
		if (math.abs(val[1]) == 1) then
			enum[1] = 0
			val[1] = 0
		end	
		if (ch[1] < 3) then
			term = term .. lib.dec_to_str(lib.math.round_dec(enum[1]/denom[1],1)) 		
		else		
			term = term .. "\(\frac{" .. tostring(enum[1]) .."}{" .. tostring(denom[1]) .. "}\)"
		end	
		term = term .. " x = "	
		fct = ""
		if (ch[4] < 3) then
			fct = lib.dec_to_str(lib.math.round_dec(enum[4]/denom[4],1)) 		
		else		
			fct =  "\(\frac{" .. tostring(enum[4]) .."}{" .. tostring(denom[4]) .. "}\)"
		end			
		equ[ITEM] = term .. fct
		if (val[1] == 0) then

			if (val[4] == 0) then
				reply[ITEM] = msg[3]
			else
				reply[ITEM] = msg[2]	
			end
		else
			reply[ITEM] = msg[1]	
			broj = enum[4] * denom[1]
			imen = denom[4] * enum[1]
			qq = lib.math.gcd(broj, imen)
			broj = math.floor(broj/qq)
			imen = math.floor(imen/qq)	
			if (imen < 0) then
				broj = - broj
				imen = - imen
			end			
			valac = broj/imen
			rest = 10*valac - math.floor(10*valac)	       		

		end		
	else                                          --[[c[1]/x = c[4] ]]--	
		term = ""
		if (ch[1] == 2) then
			term = term .. lib.frac_start() .. tostring(math.floor(enum[1])) .. lib.frac_mid() .. "x" .. lib.frac_end() 		
		else		
			term = term .. lib.frac_start() .. tostring(math.floor(enum[1])) .. lib.frac_mid() .. denom[1] .. " x" .. lib.frac_end() 		
		end	
		fct = ""
		if (ch[4] < 3) then
			fct = lib.dec_to_str(lib.math.round_dec(enum[4]/denom[4],1)) 		
		else		
			fct =  "\(\frac{" .. tostring(enum[4]) .."}{" .. tostring(denom[4]) .. "}\)"
		end			
		equ[ITEM] = term .. " = " .. fct
		if (enum[1] * enum[4] ~= 0) then
			reply[ITEM] = msg[1]	
			broj = enum[1] * denom[4]
			imen = denom[1] * enum[4]
			qq = lib.math.gcd(broj, imen)
			broj = math.floor(broj/qq)
			imen = math.floor(imen/qq)	
			if (imen < 0) then
				broj = - broj
				imen = - imen
			end			
			valac = broj/imen
			rest = 10*valac - math.floor(10*valac)	       		

		else
	
			if (enum[1] == 0 and enum[4] == 0) then
				reply[ITEM] = msg[4]
			else
				reply[ITEM] = msg[2]				
			end	
		end	
    end	
	
else
 
	term = ""
		if (val[1] ~= 1) then
			if (ch[1] < 3) then
				term = term .. lib.dec_to_str(lib.math.round_dec(val[1],1)) 		
			else		
				term = term .. "\(\frac{" .. tostring(enum[1]) .."}{" .. tostring(denom[1]) .. "}\)"
			end	
		end
	term = term .. "x"	
	free = ""
		if (ch[2] < 3) then
			free = lib.dec_to_str(lib.math.round_dec(val[2],1)) 		
		else		
			free =  "\(\frac{" .. tostring(enum[2]) .."}{" .. tostring(denom[2]) .. "}\)"
		end				
	coef = ""	
		if (ch[3] < 3) then
			coef = lib.dec_to_str(lib.math.round_dec(val[3],1)) 		
		else		
			coef =  "\(\frac{" .. tostring(math.floor(enum[3])) .."}{" .. tostring(math.floor(denom[3])) .. "}\)"
		end	
	fct = " "	
		if (ch[4] < 3) then
			fct = fct .. lib.dec_to_str(lib.math.round_dec(val[4],1)) 		
		else		
			fct =  fct .. "\(\frac{" .. tostring(math.floor(enum[4])) .."}{" .. tostring(math.floor(denom[4])) .. "}\)"
		end		
	qst = math.random(4)
	term_left = ""
	if (qst < 3) then		
		term_left = coef .. brac[1] .. term .. " + " .. free .. brac[2]  
	else
		term_left = coef .. brac[1] ..term .. " - " .. free .. brac[2] 					        	
	end
	if (qst == 2 or qst == 4) then			
		term_left = fct .. " - " .. term_left
	else
		term_left = term_left	.. " + " .. fct	
	end
	
	term_right = ""

	if (index == 1) then	
		term = ""
			broj = enum[1] * enum[3]
			imen = denom[1] * denom[3]
			qq = lib.math.gcd(broj, imen)
			broj = math.floor(broj/qq)
			imen = math.floor(imen/qq)		
			value = broj/imen
			rest = 10*value - math.floor(10*value)		
			if (value ~= 1) then
				if (rest == 0) then
					term = term .. lib.dec_to_str(lib.math.round_dec(value,1)) 		
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
			value = broj/imen
			rest = 10*value - math.floor(10*value)
			tmp = math.abs(broj)		
			if (rest == 0) then
				fct = lib.dec_to_str(lib.math.round_dec(tmp/imen,1)) 				
			else
				fct = "\(\frac{" .. tostring(tmp) .."}{" .. tostring(imen) .. "}\)"		
			end  	
		if (value < 0) then
			term_right = term_right .. " - " .. fct 
		else
			term_right = term_right .. " + " .. fct 		
		end 

	end

	if (index == 2) then	
		term = ""
			value = enum[3]/denom[3]
			if (value ~= 1) then
				if (ch[3] < 3) then
					term = term .. lib.dec_to_str(lib.math.round_dec(value,1)) 		
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
			if (val[1] ~= 1) then
				if (ch[1] < 3) then
					coef = lib.dec_to_str(lib.math.round_dec(val[1],1)) 		
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
			value = broj/imen
			rest = 10*value - math.floor(10*value)		
			if (rest == 0) then
				fct = lib.dec_to_str(lib.math.round_dec(value,1)) 				
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
			if (val[1] ~= 1) then
				if (ch[1] < 3) then
					term = term .. lib.dec_to_str(lib.math.round_dec(val[1],1)) 		
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
			value = broj/imen
			rest = 10*value - math.floor(10*value)		
			if (rest == 0) then
				free = lib.dec_to_str(lib.math.round_dec(broj/imen,1)) 				
			else
				free = "\(\frac{" .. tostring(broj) .."}{" .. tostring(imen) .. "}\)"		
			end 
		coef = ""	
			if (ch[3] < 3) then
				coef = lib.dec_to_str(lib.math.round_dec(val[3],1)) 		
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
			if (value < 0) then
				term_right = " - " .. free .. " - " .. term_right  	
			else
				term_right = free .. " - " .. term_right		
			end 
		else
			if (value < 0) then
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
			if (val[3] ~= 1) then
				if (ch[3] < 3) then
					term = term .. lib.dec_to_str(lib.math.round_dec(val[3],1)) 		
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
			value = broj/imen
			rest = 10*value - math.floor(10*value)		
			if (rest == 0) then
				free = lib.dec_to_str(lib.math.round_dec(value,1)) 				
			else
				free = "\(\frac{" .. tostring(math.floor(broj)) .."}{" .. tostring(math.floor(imen)) .. "}\)"		
			end 
		coef = ""	
			if (ch[1] < 3) then
				coef = lib.dec_to_str(lib.math.round_dec(val[1],1)) 		
			else		
				coef =  "\(\frac{" .. tostring(math.floor(enum[1])) .."}{" .. tostring(math.floor(denom[1])) .. "}\)"
			end	
		fct = " "					
			if (ch[4] < 3) then
				fct = lib.dec_to_str(lib.math.round_dec(val[4],1)) 		
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
	
    equ[ITEM] = term_left .. " = " .. term_right
	
		if (ind == qst) then
			reply[ITEM] = msg[3]		

		end	
        if ((ind == 1 and qst == 2 or ind == 2 and qst == 1) or (ind == 3 and qst == 4 or ind == 4 and qst == 3)) then
			reply[ITEM] = msg[1]				
			broj = enum[2] * denom[1]
			imen = enum[1] * denom[2]
			qq = lib.math.gcd(broj, imen)
			broj = math.floor(broj/qq) 
			imen = math.floor(imen/qq)
			value = broj/imen			
			rest = 10*value - math.floor(10*value)	  
			if (ind == 1 and qst == 2 or ind == 2 and qst == 1) then  
				broj = - broj 
				value = - value
			end	

		end
        if ((ind == 1 and qst == 4 or ind == 4 and qst == 1) or (ind == 2 and qst == 3 or ind == 3 and qst == 2)) then
			reply[ITEM] = msg[1]			
			
		end			
		if(math.abs(ind - qst) == 2) then
			reply[ITEM] = msg[2]						
		end			
end	  
            
