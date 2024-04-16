 
enum = {}
denom = {}
ch = {}
val = {}

equ = {""}
sol = {""}
reply = {""}

choice = out[ITEM]
index = math.floor(0.1 * choice)
ind = choice - 10 * index

opqu = math.random(4)
if (opqu < 3) then
    opcont = 3 - opqu
else	
    opcont = 7 - opqu
end

qst = math.random(4)

if (qst == 2 or qst == 4) then
	op = opcont
else
	op = opqu
end	
				
--[[koeficijenti c[3]*(c[1]x+c[2])+c[4]) ]]--	

for i = 1,4 do	   
	ch[i] = 1 + math.random(2)
	enum[i] = math.random(2*max_range)
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
term_left = ""
if (qst < 3) then		
	term_left = coef .. " (" .. term .. " + " .. free .. " )"  
else
	term_left = coef .. " (" ..term .. " - " .. free .. " )" 					        	
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
	term_right = coef .. " (" .. term_right .. ") " 
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
	term_right = coef .. " (" .. term_right .. ") " 			
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
	term_right = coef .. " (" .. term_right .. ") " 			
	if (ind == 2 or ind == 3) then
		term_right = fct .. " - " .. term_right 
	else
		term_right = term_right .. " + " .. fct	
	end			
end

equ[ITEM] = term_left .. " " .. rel[opqu] .. " " .. term_right

if (ind == qst) then
	if (op > 2) then
		reply[ITEM] = msg[3]	
	else
		reply[ITEM] = msg[2]	
	end			
	sol[ITEM] = "0 · x " .. lib.check_one_option_dropdown(rel, rel[op]) .. lib.check_number(0,20)	
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
	sol[ITEM] = "x " .. lib.check_one_option_dropdown(rel, rel[op])		
	if (rest == 0) then
		sol[ITEM] = sol[ITEM] .. lib.check_number(lib.math.round_dec(value,1))			
	else		
		condit = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"	
		solut = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
		sol[ITEM] = sol[ITEM] .. lib.check_fraction_condition(condit, nil, nil, solut) 
	end 
end
if ((ind == 1 and qst == 4 or ind == 4 and qst == 1) or (ind == 2 and qst == 3 or ind == 3 and qst == 2)) then
	broj =  2* enum[1] * enum[3]
	imen = denom[1] * denom[3]
	qq = lib.math.gcd(broj, imen)
	broj = math.floor(broj/qq) 
	imen = math.floor(imen/qq)
	value = broj/imen

    if (value ~= 0) then
		reply[ITEM] = msg[1]
		sol[ITEM] =  " x " .. lib.check_one_option_dropdown(rel, rel[op]) .. " " .. lib.check_number(0)				
	else
	    if (op > 2) then
			reply[ITEM] = msg[3]
		else	
			reply[ITEM] = msg[2]
        end		
		rest = 10*value - math.floor(10*value)	
		if (rest == 0) then
			sol[ITEM] =  lib.check_number(value,20)			
		else		
			condit = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"	
			solut = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
			sol[ITEM] =  lib.check_fraction_condition(condit, nil, nil, solut) 
		end 			
		sol[ITEM] = sol[ITEM] .. " x " .. lib.check_one_option_dropdown(rel, rel[op]) .. " " .. lib.check_number(0)				
	end		
end	
if(math.abs(ind - qst) == 2) then
	broj =  2* enum[2] * enum[3]
	imen = denom[2] * denom[3]
	qq = lib.math.gcd(broj, imen)
	broj = math.floor(broj/qq) 
	imen = math.floor(imen/qq)
	value = broj/imen		  	
	if (qst < ind) then  
		broj = - broj 
		value = - value
	end
	rest = 10*value - math.floor(10*value)	
	sol[ITEM] = "0 · x " .. lib.check_one_option_dropdown(rel, rel[op])	
	if (rest == 0) then
		sol[ITEM] = sol[ITEM] .. " " .. lib.check_number(lib.math.round_dec(value,1))			
	else		
		condit = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"	
		solut = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
		sol[ITEM] = sol[ITEM] .. " " .. lib.check_fraction_condition(condit, nil, nil, solut) 
	end 		
	if (value == 0) then
		if (op > 2) then
			reply[ITEM] = msg[3]	
		else
			reply[ITEM] = msg[2]	
		end			
	else
		if (value > 0) then
			if (op == 1 or op == 3) then
				reply[ITEM] = msg[3]	
			else
				reply[ITEM] = msg[2]	
			end	
		else
			if (op == 2 or op == 4) then
				reply[ITEM] = msg[3]	
			else
				reply[ITEM] = msg[2]	
			end	
		end	
    end		
end			
