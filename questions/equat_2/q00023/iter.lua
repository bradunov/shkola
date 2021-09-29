
brac = {"\(\big ( \)", "\(\big ) \)"}
enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
term = {""}
ch = {}

max = 8

for i = 1,2 do
    denom[i] = 2 + math.random(max);
    enum[i] =  math.random(2*max);
    if (enum[i] == denom[i]) then
        denom[i] = denom[i] + 1
    end
	fact = math.random(2)
	if (fact == 1) then
        enum[i] = - enum[i]
	end	
end	

enum[3] = enum[1] * enum[2]
denom[3] = denom[1] * denom[2]	

for i = 1,3 do
    term[i] = ""
    q = lib.math.gcd(enum[i], denom[i])
    denom[i] = denom[i] / q
    enum[i] = enum[i] / q
    value[i] = enum[i]/denom[i]
    tmp = math.floor(value[i] * 10)
	rest = value[i] * 10 - tmp	
    if (rest == 0) then	
	    term[i] = lib.dec_to_str(lib.math.round_dec(value[i], 1))
        ch[i] = 1
	else	
        if (value[i] > 0) then
            whl[i] = math.floor(value[i])
        else 
            whl[i] = math.ceil(value[i])
        end
        enum_p[i] = enum[i]	- whl[i] * denom[i]
        if (whl[i] ~= 0) then
            term[i] = term[i] .. tostring(whl[i])  
			enum_p[i] = math.abs(enum_p[i])
        end
        term[i] = term[i] .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"	
        ch[i] = 2
	end
end

ind = math.random(2)

quest = ""
if (ind == 1) then
    quest = "x * " .. brac[1] .. term[2] .. brac[2] .. " = " .. term[3]
else
    quest = brac[1] .. term[1] .. brac[2].. " * x  = " .. term[3]
end	

answ1 = ""
answ2 = ""
if (ch[ind] == 1) then	
    answ1 = lib.check_number(value[ind],30)	
else 
    if (whl[ind] ~= 0) then
        answ1 = lib.check_number(whl[ind],20)  
    end
	tmp = enum_p[ind]/denom[ind]	
 	condition2 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"
    sln2 = "numerator="..tostring(enum_p[ind])..";denominator="..tostring(denom[ind])..";"
    answ2 = answ2 .. lib.check_fraction_condition(condition2, nil, nil, sln2)
end
 	
 	




