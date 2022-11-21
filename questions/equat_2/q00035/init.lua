 
include("terms") 

brac = {"\(\big ( \)", "\(\big ) \)"}

enum = {}
denom = {}
ch = {}
sifra = {}
out = {}

--[[koeficijenti c[3])*(c[1]x+c[2])+c[4] ]]--	
max_range = 5

for i = 1,4 do	   
	ch[i] = 1 + math.random(2)
	if (i == 4) then
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
end

enum[5] = enum[4]
denom[5] = denom[4]
ch[5] = ch[4]
tmp = enum[5]/denom[5]
if (ch[5] < 3) then
	sol_left = lib.check_number(lib.math.round_dec(tmp,1)) 		
else	
	condition = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"	
	solution = "numerator="..tostring(enum[5])..";denominator="..tostring(denom[5])..";"
	sol_left =  lib.check_fraction_condition(condition, nil, nil, solution)
end
xtbroj = enum[1] * enum[5]
xtimen = denom[1] * denom[5]

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
if (enum[2] ~= 0) then
	if (ch[2] < 3) then
		free = lib.dec_to_str(lib.math.round_dec(enum[2]/denom[2],1)) 		
	else		
		free =  "\(\frac{" .. tostring(enum[2]) .."}{" .. tostring(denom[2]) .. "}\)"
	end			
end	
coef = ""
if (enum[3]/denom[3] ~= 1) then	
	if (ch[3] < 3) then
		coef = lib.dec_to_str(lib.math.round_dec(enum[3]/denom[3],1)) 		
	else		
		coef =  "\(\frac{" .. tostring(math.floor(enum[3])) .."}{" .. tostring(math.floor(denom[3])) .. "}\)"
	end	
end	
		
qst = math.random(4)
	
term_left = ""
xcimen = denom[3] * xtimen * denom[2]
if (qst < 3) then	
	xcbroj = enum[3] * (xtbroj * denom[2] + xtimen * enum[2]) 
	term_left = coef .. brac[1] .. term .. " + " .. free .. brac[2]  
else
	xcbroj = enum[3] * (xtbroj * denom[2] - xtimen * enum[2]) 
	term_left = coef .. brac[1] ..term .. " - " .. free .. brac[2] 					        	
end
if (qst == 1 or qst == 3) then	
	enum[4] = - xcbroj	
else
	enum[4] = xcbroj	
end	
denom[4] = denom[3] * xtimen * denom[2]	
qq = lib.math.gcd(enum[4], denom[4])
enum[4] = math.floor(enum[4]/qq)
denom[4] = math.floor(denom[4]/qq)
fct = " "
tmp = math.abs(enum[4])		
val = tmp/denom[4]
rest = 10*val - math.floor(10*val)		
if (rest == 0) then
	ch[4] = 1
	fct = lib.dec_to_str(lib.math.round_dec(val,1)) 				
else
	ch[4] = 3
	fct = "\(\frac{" .. tostring(math.floor(tmp)) .."}{" .. tostring(math.floor(denom[4])) .. "}\)"		
end 

if (xcbroj < 0) then	
    term_left =  term_left .. " = - " .. fct	
else
    term_left = term_left .. " = " .. fct
end		
	
nr = 0
for i = 1,4 do
    for j = 1,4 do
	    nr = nr + 1
	    sifra[nr] = 10 * i + j
    end
end	

out = lib.math.random_shuffle(sifra)
                  
izbor = math.random(16)
choice = out[izbor]
index = math.floor(0.1 * choice)
ind = choice - 10 * index
	
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
	fct = " "
		imenilac = denom[3] * denom[2]
		brojilac = enum[3] * enum[2]	
		denom[6] = imenilac * denom[4]		
		if (ind == 2 or ind == 3) then	
			enum[6] =  brojilac * denom[4] - imenilac * enum[4] 
		else
			enum[6] = brojilac * denom[4] + imenilac * enum[4]				
		end	
		qq = lib.math.gcd(enum[6], denom[6])
		enum[6] = math.floor(enum[6]/qq)
		denom[6] = math.floor(denom[6]/qq)
		tmp = math.abs(enum[6])		
		valac = tmp/denom[6]
		rest = 10*valac - math.floor(10*valac)		
		if (rest == 0) then
		    ch[6] = 1
			fct = lib.dec_to_str(lib.math.round_dec(valac,1)) 				
		else
			ch[6] = 3
			fct = "\(\frac{" .. tostring(tmp) .."}{" .. tostring(denom[6]) .. "}\)"		
		end	
		enum[7] = imen * enum[6]		
	if (enum[6] < 0) then
	    if (ind == 3 or ind == 4) then
		    sg = 2
		else
			sg = 1 	
			enum[7] = - enum[7]					
		end 
    else		
	    if (ind == 3 or ind == 4) then
		    sg = 1		
		else
	        sg = 2		
			enum[7] = - enum[7]	
		end   
    end		
    if (sg == 1) then
        znak = 	" = "
	else
		znak = " = - "
	end
	term_right = term_right .. znak .. fct	
	denom[7] = broj * denom[6]	
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
		tmp = math.abs(brojilac)
		valac = tmp/imenilac
		rest = 10*valac - math.floor(10*valac)		
		if (rest == 0) then
			free = lib.dec_to_str(lib.math.round_dec(valac,1)) 				
		else
			free = "\(\frac{" .. tostring(tmp) .."}{" .. tostring(imenilac) .. "}\)"		
		end 		
	if (brojilac < 0) then
	    if (ind == 2 or ind == 4) then
		    sg = 1
		else
			sg = 2 		
		end 
    else		
	    if (ind == 2 or ind == 4) then
		    sg = 2		
		else
	        sg = 1		
		end   
    end		
    if (sg == 1) then
        znak = 	" + "
	else
		znak = " - "
	end	
	term_right = term .. znak .. free   
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
		enum[6] = enum[2] * enum[3] 
		denom[6] = denom[2] * denom[3]	
		qq = lib.math.gcd(enum[6], denom[6])
		enum[6] = math.floor(enum[6]/qq)
		denom[6] = math.floor(denom[6]/qq)
		val = enum[6]/denom[6]
		rest = 10*val - math.floor(10*val)		
		if (rest == 0) then
		    ch[6] = 1
			fct = lib.dec_to_str(lib.math.round_dec(val,1)) 				
		else
		    ch[6] = 3		
			fct = "\(\frac{" .. tostring(enum[6]) .."}{" .. tostring(denom[6]) .. "}\)"		
		end  	
	if (ind > 2 ) then	
		term_right = term_right .. " = " .. fct 
	else
		term_right = term_right .. " = - " .. fct 	
	end
	tmpp = enum[6] * denom[4] + enum[4] * denom[6]	
	tmpm = enum[6] * denom[4] - enum[4] * denom[6]	
	if (ind == 1) then
		broj = - tmpp
	end
	if (ind == 2) then
		broj = - tmpm
	end
	if (ind == 3) then
		broj = tmpm
	end	
	if (ind == 4) then
		broj = tmpp
	end	
	imen = denom[4] * denom[6]	
	enum[7] = broj * denom[1] * denom[3]
	denom[7] = imen * enum[1] * enum[3]		
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
		brojilac = enum[4] * denom[3]
		imenilac = denom[4] * enum[3]
		qq = lib.math.gcd(brojilac, imenilac)
		brojilac = math.floor(brojilac/qq)
		imenilac = math.floor(imenilac/qq)	
		tmp = math.abs(brojilac)
		valac = tmp/imenilac
		rest = 10*valac - math.floor(10*valac)		
		if (rest == 0) then
			free = lib.dec_to_str(lib.math.round_dec(valac,1)) 				
		else
			free = "\(\frac{" .. tostring(tmp) .."}{" .. tostring(imenilac) .. "}\)"		
		end 		
	if (brojilac < 0) then
	    if (ind == 2 or ind == 4) then
		    sg = 1
		else
			sg = 2 		
		end 
    else		
	    if (ind == 2 or ind == 4) then
		    sg = 2		
		else
	        sg = 1		
		end   
    end		
    if (sg == 1) then
        znak = 	" + "
	else
		znak = " - "
	end	
	term_right = term .. znak .. free   
	coef = ""
		val = enum[3]/denom[3]
		if (val ~= 1) then
			if (ch[3] < 3) then
				coef = lib.dec_to_str(lib.math.round_dec(val,1)) 		
			else		
				coef = "\(\frac{" .. tostring(enum[3]) .."}{" .. tostring(denom[3]) .. "}\)"
			end	
		end			
	term_right = coef .. brac[1] .. term_right .. brac[2] 
	fct = ""
		enum[6] = enum[2] * enum[3] 
		denom[6] = denom[2] * denom[3]	
		qq = lib.math.gcd(enum[6], denom[6])
		enum[6] = math.floor(enum[6]/qq)
		denom[6] = math.floor(denom[6]/qq)
		val = enum[6]/denom[6]
		rest = 10*val - math.floor(10*val)		
		if (rest == 0) then
		    ch[6] = 1
			fct = lib.dec_to_str(lib.math.round_dec(val,1)) 				
		else
		    ch[6] = 3		
			fct = "\(\frac{" .. tostring(enum[6]) .."}{" .. tostring(denom[6]) .. "}\)"		
		end  	
	if (ind > 2 ) then	
		term_right = term_right .. " = " .. fct 
	else
		term_right = term_right .. " = - " .. fct 	
	end
	tmpp = enum[6] * denom[4] + enum[4] * denom[6]	
	tmpm = enum[6] * denom[4] - enum[4] * denom[6]	
	if (ind == 1) then
		broj = - tmpp
	end
	if (ind == 2) then
		broj = - tmpm
	end
	if (ind == 3) then
		broj = tmpm
	end	
	if (ind == 4) then
		broj = tmpp
	end	
	imen = denom[4] * denom[6]	
	enum[7] = broj * denom[1] * denom[3]
	denom[7] = imen * enum[1] * enum[3]		
end	

if (index == 4) then
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
		brojilac = enum[2] * enum[3] * denom[1]
		imenilac = denom[2] * denom[3] * enum[1]
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
	if (ind < 3) then
		sg = 1
	else
		sg = 2 		
	end 	
    if (sg == 1) then
        znak = 	" + "
	else
		znak = " - "
	end	
	term_right = term .. znak .. free   
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
	    if (ind == 1 or ind == 3) then          		
			enum[6] = - enum[4] 
        else
			enum[6] = enum[4] 
        end			
		denom[6] = denom[4]
        ch[6] = ch[4]
        tmp = math.abs(enum[6])		
		val = tmp/denom[6]	
		if (ch[6] == 3) then
			fct = "\(\frac{" .. tostring(tmp) .."}{" .. tostring(denom[6]) .. "}\)"		
		else	
			fct = lib.dec_to_str(lib.math.round_dec(val,1)) 				
		end 
    if (enum[6] < 0) then		
		term_right = term_right .. " = - " .. fct 
	else
		term_right = term_right .. " = " .. fct  	
	end
	tmpp = enum[2] * enum[3] * denom[4] + enum[4] * denom[2] * denom[3]	
	tmpm = enum[2] * enum[3] * denom[4] - enum[4] * denom[2] * denom[3]	
	if (ind == 1) then
		broj = - tmpp
	end
	if (ind == 2) then
		broj = - tmpm
	end
	if (ind == 3) then
		broj = tmpm
	end	
	if (ind == 4) then
		broj = tmpp
	end	
	imen = denom[2] * denom[3] * denom[4]	
	enum[7] = broj * denom[1] * denom[3]
	denom[7] = imen * enum[1] * enum[3]		
end	

qq = lib.math.gcd(enum[7], denom[7])
enum[7] = math.floor(enum[7]/qq)
denom[7] = math.floor(denom[7]/qq)
val = enum[7]/denom[7]
rest = 10*val - math.floor(10*val)
if (rest == 0) then
	ch[7] = 1
	sol_right = lib.check_number(lib.math.round_dec(val,1)) 		
else
	ch[7] = 3	
	condit = "is_ok = math.eq(numerator/denominator, "..tostring(val)..");"	
	solut = "numerator="..tostring(enum[7])..";denominator="..tostring(denom[7])..";"
	sol_right =  lib.check_fraction_condition(condit, nil, nil, solut)
end

if (ind == qst or (enum[5] == enum[7] and denom[5] == denom[7] ))then
    reply = msg[1]
else
    reply = msg[2]
end		