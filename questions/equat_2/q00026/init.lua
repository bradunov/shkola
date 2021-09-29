
include("terms")

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
term = {""}
ch = {}

max_range = 8

for i = 1,2 do
    denom[i] = 2 + math.random(max_range);
    enum[i] =  math.random(2*max_range);
	value[i] = enum[i] / denom[i]
    if (value[i] == math.floor(value[i])) then
        denom[i] = denom[i] + 1
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
if (math.abs(value[1]) == math.abs(value[2]) ) then
    denom[1] = denom[1] + 2
end	

ind = math.random(4)

if (ind < 3) then
	enum[3] = enum[1] * enum[2]
    denom[3] = denom[1] * denom[2] 
else
    if (ind == 3) then			
	    enum[3] = enum[1] * denom[2]
        denom[3] = denom[1] * enum[2] 
    else
	    enum[3] = enum[2] * denom[1]
        denom[3] = denom[2] * enum[1] 
    end   
end	
if (denom[3] < 0) then
    denom[3] = - denom[3]
    enum[3]	= - enum[3]
end

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
