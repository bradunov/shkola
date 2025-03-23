
enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
term = {}
qq = {}
ch = {}

max_range = 20
for i = 1,2 do
    qq = lib.math.random_shuffle(set)
	denom[i] = qq[1]
    enum[i] = 2 + math.random(max_range);	 
    value[i] = enum[i] / denom[i]
    if (value[i] == math.floor(value[i])) then
	    enum[i] = enum[i] + 1
	end	
	if (i == 2 and fact == 2) then
	    fact = 1
    else		
	    fact = math.random(2)
	end	
	if (fact == 1) then
        enum[i] = - enum[i]
	end	
	value[i] = enum[i] / denom[i]		
end	

choice = math.random(2)
op = math.random(2)
if (op == 2) then
    value[3] = value[1] * value[2]
	denom[3] = denom[1] * denom[2]
    enum[3] = enum[1] * enum[2]
else
    if (choice == 1) then
        value[3] = value[1] / value[2]
	    denom[3] = denom[1] * enum[2]
        enum[3] = enum[1] * denom[2]
    else
        value[3] = value[2] / value[1]
	    denom[3] = denom[2] * enum[1]
        enum[3] = enum[2] * denom[1]
    end		
end
if (denom[3] < 0) then
    denom[3] = - denom[3]
    enum[3]	= - enum[3]
end

for i = 1,3 do
    term[i] = ""
    q = lib.math.gcd(enum[i],denom[i])
    enum[i] = enum[i] / q
    denom[i] = denom[i] / q
    value[i] = enum[i]/denom[i]	
    tmp = math.floor(value[i] * 10)
	rest = value[i] * 10 - tmp		
    if (value[i] > 0) then
        whl[i] = math.floor(value[i])
    else 
        whl[i] = math.ceil(value[i])
    end
    enum_p[i] = enum[i]	- whl[i] * denom[i]
    if (rest == 0) then	
	    term[i] = lib.dec_to_str(lib.math.round_dec(value[i], 1))
        ch[i] = 1
	else		
        if (whl[i] ~= 0) then
            term[i] = term[i] .. tostring(whl[i])  
			enum_p[i] = math.abs(enum_p[i])
        end
        term[i] = term[i] .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"	
        ch[i] = 2
	end
end

answ1 = ""
answ2 = ""

if (ch[1] == 1) then	
        answ1 = lib.check_number(value[1],30)	
else 
    if (whl[1] ~= 0) then
        answ1 = lib.check_number(whl[1],20)  
    end
	tmp = enum_p[1]/denom[1]	
 	condition2 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"
    sln2 = "numerator="..tostring(enum_p[1])..";denominator="..tostring(denom[1])..";"
    answ2 = answ2 .. lib.check_fraction_condition(condition2, nil, nil, sln2)
end

fact = 2
if (op == 2) then 
	if (value[2] < 0) then
		fact = 1
	end
else	
	if (choice == 1 and value[2] < 0) then 
		fact = 1
	end	
	if (choice == 2 and value[1] * value[3] > 0) then	
		fact = 1	
	end
end	

index = math.random(4)
if (fact == 1) then
    if (index < 3) then
        if (index == 1) then
            ind = 2
        else
            ind = 1
        end	
	else	
        if (index == 3) then
            ind = 4
        else
            ind = 3
		end	
    end		
else
 	ind = index 
end 

reply = "x " .. lib.check_one_option_dropdown(sign, sign[ind]) .. " " .. answ1 .. answ2
 
if (choice == 2 and op == 1) then
    if (value[1] < 0 ) then
	    if (ind == 2 or ind == 4) then
            reply = lib.check_number(0,20) .. " " .. lib.check_one_option_dropdown(sign, sign[2]) .. " " .. reply 	
		end	
	else	
        if ( ind == 1 or ind == 3) then
            reply = lib.check_number(0,20) .. " " .. lib.check_one_option_dropdown(sign, sign[1]) .. " " .. reply
	    end	
	end	
end	
