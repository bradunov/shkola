
oper = {"+", "-", "*", ":"}
op = {}

enum = {}
denom = {}
arg = {""}
fct = {}
ch = {}
work = {}

quest = ""
term = ""
answ = ""

ind = math.random(4)
max_range = 5
dgr = 3

for i = 1,2 do
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
	sg = math.random(2)
	if (sg == 2) then
		enum[i] = - enum[i]
	end			 
end	
for i = 1,2 do	
	if (ch[i] < 3) then
		arg[i] = lib.dec_to_str(lib.math.round_dec(enum[i]/denom[i],1))
	else	
		arg[i] = "\(\frac{" .. tostring(enum[i]) .."}{" .. tostring(denom[i]) .. "}\)"
	end	
end	
quest =	"x = " .. arg[1] .. ", \( \ \ \)" .. "y = " .. arg[2]  						

if (ind == 1) then        --[[a*x +-*: b*y]]--
    for i = 1,2 do
	    fct[i] = math.random(5)
	end	
	op[1] = math.random(4)
	if (op[1] == 1) then
        broj = fct[1]*enum[1]*denom[2] + fct[2]*enum[2]*denom[1]
		imen = denom[1] * denom[2]
	end	
	if (op[1] == 2) then
        broj = fct[1]*enum[1]*denom[2] - fct[2]*enum[2]*denom[1]
		imen = denom[1] * denom[2]
	end	
	if (op[1] == 3) then
        broj = fct[1]*enum[1]*enum[2]
		imen = denom[1] * denom[2]
	end		
	if (op[1] == 4) then
        broj = fct[1]*enum[1]*denom[2]
		imen = denom[1] * enum[2]
	end	
	if (imen < 0) then
	    broj = - broj
		imen = - imen
	end	
	qq = lib.math.gcd(broj, imen)
	broj = math.floor(broj/qq)
	imen = math.floor(imen/qq)	
    value = broj/imen	
	rest = 10*value - math.modf(10*value)
	if (rest == 0) then
	    answ = lib.check_number(lib.math.round_dec(value,1))
	else	
	    condition = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"
        sln = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
        answ = lib.check_fraction_condition(condition, nil, nil, sln)
	end
	if (fct[1] == 1) then
	    term = " x " .. oper[op[1]]
	else
	    term =  fct[1] .. "x " .. " " .. oper[op[1]] .. " " 
    end 
	if (fct[2] == 1 or op[1] > 2) then
	    term = term .. " y"  
	else
	    term = term .. " " .. fct[2] .. "y " 
    end 	
end

if (ind == 2) then        --[[(x +- a) *: (y +- b)]]--
    for i = 1,2 do
	    fct[i] = math.random(5)
	end	
	op[1] = math.random(2)
	op[2] = math.random(2)
	op[3] = 2 + math.random(2)
	if (op[1] == 1) then
        broj1 = enum[1] + fct[1]*denom[1] 
	else
        broj1 = enum[1] - fct[1]*denom[1]		
	end	
	imen1 = denom[1]	
	if (op[2] == 1) then
        broj2 = enum[2] + fct[2]*denom[2] 
	else
        broj2 = enum[2] - fct[2]*denom[2]	
        if (broj2 == 0 and op[3] == 4) then
            fct[2] = fct[2]  + 1
            broj2 = enum[2] - fct[2]*denom[2] 
        end			
	end	
	imen2 = denom[2]	
	if (op[3] == 3) then
        broj = broj1 * broj2
		imen = imen1 * imen2
	else
        broj = broj1 * imen2
		imen = imen1 * broj2	
	end		
	if (imen < 0) then
	    broj = - broj
		imen = - imen
	end	
	qq = lib.math.gcd(broj, imen)
	broj = math.floor(broj/qq)
	imen = math.floor(imen/qq)	
    value = broj/imen	
	rest = 10*value - math.modf(10*value)
	if (rest == 0) then
	    answ = lib.check_number(lib.math.round_dec(value,1))
	else	
	    condition = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"
        sln = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
        answ = lib.check_fraction_condition(condition, nil, nil, sln)
	end	
	term = "(x " .. oper[op[1]] .. fct[1] .. ") " .. oper[op[3]] .. " ( y " .. oper[op[2]] .. fct[2] .. ") "
end

if (ind == 3) then        --[["3x^(1,2) *: y^(1,2)", "3x^2y", "3x^2y^2", "3(xy)^2", "3(x/y)^2", "3x/y^2", "3x^2/y"]]--
	fct[1] = math.random(5)	
	op[1] = math.random(dgr)
	if (op[1] == 1) then
	    min_range = 1
	else
        min_range = 0
    end	
	op[2] = min_range + math.random(dgr)
	op[3] = 2 + math.random(2)
	for j = 1,2 do
	    work[j] = 1
	    work[j+2] = 1		
	    for i = 1,op[j] do
	        work[j] = work[j] * enum[j] 		
	        work[j+2] = work[j+2] * denom[j]
        end		
    end	
    if (op[3] == 3) then
        broj = fct[1] * work[1]	* work[2]
		imen = work[3]	* work[4]
    else
        broj = fct[1] * work[1]	* work[4]
		imen = work[2]	* work[3]
    end	
	if (imen < 0) then
	    broj = - broj
		imen = - imen
	end	
	qq = lib.math.gcd(broj, imen)
	broj = math.floor(broj/qq)
	imen = math.floor(imen/qq)	
    value = broj/imen	
	rest = 10*value - math.modf(10*value)
	if (rest == 0) then
	    answ = lib.check_number(lib.math.round_dec(value,1))
	else	
	    condition = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"
        sln = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
        answ = lib.check_fraction_condition(condition, nil, nil, sln)
	end
	stampa = 0
	if (op[1] == op[2]) then
	    stampa = math.random(2) - 1
    end	
	if (fct[1] ~= 1) then
        term = fct[1]
    end		
	if (op[1] == 1) then
	    term = term .. "x " .. oper[op[3]] .. " y" .. "\(^{" .. op[2]  .. "}\)"
    else
        if (stampa == 0) then
            term = term .. "x" .. "\(^{" .. op[1]  .. "}\)" .. " " .. oper[op[3]] .. " y"  
 		    if (op[2] ~= 1) then			
	            term = term .. "\(^{" .. op[2]  .. "}\)" 
            end			
		else
	        term = term .. "(x " .. oper[op[3]] .. " y)" .. "\(^{" .. op[2]  .. "}\)" 
        end
    end		
end

if (ind == 4) then        --[["x^2+y^2", "(x+y)^2", "x^2-y^2", "(x-y)^2",]]--	
	op[1] = 1 + math.random(dgr)
	op[2] = math.random(2)		
	for j = 1,2 do
	    work[j] = 1
	    work[j+2] = 1		
	    for i = 1,op[1] do
	        work[j] = work[j] * enum[j] 		
	        work[j+2] = work[j+2] * denom[j]
        end		
    end	
	stampa = math.random(2) - 1	
	if (stampa == 0) then	
		imen = work[3]	* work[4]    
		if (op[2] == 1) then
			broj = work[1]	* work[4] + work[2]	* work[3]
		else
			broj = work[1]	* work[4] - work[2]	* work[3]
		end	
	else
		imenilac = denom[1]	* denom[2]    
		if (op[2] == 1) then
			brojilac = enum[1]	* denom[2] + enum[2] * denom[1]
		else
			brojilac = enum[1]	* denom[2] - enum[2] * denom[1]
		end	
		broj = 1
		imen = 1
	    for i = 1,op[1] do
	        broj = broj * brojilac 		
	        imen = imen * imenilac
        end	
	end	
	qq = lib.math.gcd(broj, imen)
	broj = math.floor(broj/qq)
	imen = math.floor(imen/qq)	
    value = broj/imen	
	rest = 10*value - math.modf(10*value)
	if (rest == 0) then
	    answ = lib.check_number(lib.math.round_dec(value,1))
	else	
	    condition = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"
        sln = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
        answ = lib.check_fraction_condition(condition, nil, nil, sln)
	end
    if (stampa == 0) then
        term = "x" .. "\(^{" .. op[1]  .. "}\)" .. " " .. oper[op[2]] .. " y"  .. "\(^{" .. op[1]  .. "}\)"
	else
		term = "(x " .. oper[op[2]] .. " y)" .. "\(^{" .. op[1]  .. "}\)" 
	end	
end
        