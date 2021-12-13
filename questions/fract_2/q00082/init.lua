
include("terms")

answ = {"\(\small \leq\)",  "\(\small \geq\)"}
                                                                                                              
set = {2, 2, 2, 3, 3, 5}
dim = 6
  
max = 15        

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
qq = {}
ch = {}

out = {}
dg = {}
term = {}
add = {}
ind = {}

quest = {""}
reply = {""}
sln = {}
cond = {}

dimv = 6

ch[1] = math.random(dimv-2)
ch[2] = ch[1] + math.random(dimv - ch[1])
for i = 1,dimv do
    qq = lib.math.random_shuffle(set)
    choice = math.random(2)
	denom[i] = 1
	for j = 1,choice do
	    if (i == ch[1] or i == ch[2]) then 
		    if (qq[j] == 3) then
                denom[i] = denom[i] * 5;
			else
                denom[i] = denom[i] * qq[j];
            end	
        else			
            denom[i] = denom[i] * qq[j];
		end	
	end 
    enum[i] = 5 + math.random(max);	 
	fct = math.random(2)
    if (fct == 1) then
	    enum[i] = -enum[i]
	end
	value[i] = enum[i] / denom[i]	
end

for i = 1,dimv do
    q = lib.math.gcd(enum[i], denom[i])
	enum[i] = enum[i] / q
	denom[i] = denom[i] / q	
end	

for i = 1,dimv do
    if (i ~= ch[1] and i ~= ch[2]) then
	    if (value[i] > 0) then
            whl[i] =  math.floor(enum[i]/denom[i])
		else
            whl[i] =  math.ceil(enum[i]/denom[i])
        end			
	    enum_p[i] = math.abs (enum[i] - denom[i] * whl[i])
	end	
end

for i = 1,2 do		
    chind = 3
    for j = 1,3 do
        temp = value[ch[i]] * 10^(4-j) 
        if (math.abs(lib.math.round(temp) - temp) < 0.0001) then
	        chind = 4-j
	    end	
    end
    out[i] = lib.math.round_dec(value[ch[i]], chind)	
end	


for i = 1,dimv do 
    quest[i] = ""
    reply[i] = ""	
    fr = 0	
    for j = 1,2 do
		if (i == ch[j]) then
			fr = j
		end	
	end	
    dg[i] = math.random(2)
    if (dg[i] == 1) then
        term[i] = value[i] * value[i]
		sign = ""
    else
        term[i] = - value[i] * value[i]
		sign = "-"		
    end	
    quest[i] = quest[i] .. sign .. " ( "   	
    reply[i] = reply[i] .. lib.check_string(sign,10) .. " ( " 	
	if (fr == 0) then
        if (whl[i] ~= 0) then
            quest[i] = quest[i] .. whl[i] 	
		    reply[i] = reply[i] .. lib.check_number(whl[i],15)			
        end
	    if (enum_p[i] ~= 0) then			
            quest[i] = quest[i] .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\) "    
            cond[i] = enum_p[i]/ denom[i]			
            condition = "is_ok = math.eq(numerator/denominator, "..tostring(cond[i])..");"
            sln[i] = "numerator="..tostring(math.floor(enum_p[i]))..";denominator="..tostring(math.floor(denom[i]))..";"	   
            reply[i] = reply[i] .. lib.check_fraction_condition(condition, nil, nil, sln[i])	     			
		end		
	else
        quest[i] = quest[i] .. lib.dec_to_str(out[fr]) 
        reply[i] = reply[i] .. lib.check_number(out[fr],30) 		
	end
    quest[i] = quest[i] .. " )² "	
    reply[i] = reply[i] .. " )² "	
end	

qq = lib.math.argsort(term);

opt = math.random(2)
relat = msg[opt]

for i = 1,dimv do
    out[i] = 0
    if (opt == 1) then
        out[i] = qq[i]
	else
        out[i] = qq[dimv+1-i]
    end
end	        
                  