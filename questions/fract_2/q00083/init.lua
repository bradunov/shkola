
include("terms")
                                                                                                                                                                                             
set = {2, 2, 2, 3, 3, 5}
dim = 6
  
max = 15        

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
out = {}

broj = {}
imen = {}
value2 = {}
brojilac = {}
imenilac = {}
ceo = {}
res = {}

qq = {}
ch = {}
dg = {}


quest = {""}
reply = {""}
cond = {}
condition = {}
sln = {}

dimv = 2

ch[1] = math.random(2)
ch[2] = math.random(2)
for i = 1,dimv do
    qq = lib.math.random_shuffle(set)
    choice = math.random(2)
	denom[i] = 1
	for j = 1,choice do
	    if (ch[i] == 1) then 
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
	if (value[i] > 0) then
        whl[i] =  math.floor(enum[i]/denom[i])
	else
        whl[i] =  math.ceil(enum[i]/denom[i])
    end			
	enum_p[i] = math.abs (enum[i] - denom[i] * whl[i])	
    if (value[i] < 0 and whl[i] == 0) then
	    enum_p[i] = - enum_p[i]
	end	 	
end

for i = 1,dimv do		
    chind = 2
    for j = 1,2 do
        temp = value[i] * 10^(3-j) 
        if (math.abs(lib.math.round(temp) - temp) < 0.0001) then
	        chind = 3-j
			ch[i] = 1
	    end	
    end
    out[i] = lib.math.round_dec(value[i], chind)	
end	


for i = 1,dimv do 
    quest[i] = ""	
	if (ch[i] == 2) then
        if (whl[i] ~= 0) then
            quest[i] = quest[i] .. whl[i] 			
        end
	    if (enum_p[i] ~= 0) then			
            quest[i] = quest[i] .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\) "    
		end		
	else
        quest[i] = quest[i] .. lib.dec_to_str(out[i]) 
	end
end	      

for i = 1,dimv do
    value2[i] = value[i] * value[i]
	broj[i] = enum[i] * enum[i]
	imen[i] = denom[i] * denom[i]
end	 
	
ind = math.random(7)
check = 5

if (ind == 1) then 	
    if (ch[1] * ch[2] == 1) then
	    check = 1
	    res[1] = out[1] * out[1] + out[2] * out[2]
		res[1] = lib.math.round_dec(res[1], 4)
		res[2] = (out[1] + out[2]) * (out[1] + out[2])
	    res[2] = lib.math.round_dec(res[2], 4)			
    else
	    res[1] = value2[1] + value2[2]
		brojilac[1]= broj[1] * imen[2] + broj[2] * imen[1] 
		imenilac[1] = imen[1] * imen[2]	
		res[2] = (value[1] + value[2]) * (value[1] + value[2])
		brojilac[2] = (enum[1] * denom[2]  + enum[2] * denom[1]) * (enum[1] * denom[2]  + enum[2] * denom[1])
		imenilac[2] = imenilac[1]		
	end	
end	


if (ind == 2) then 	
    if (ch[1] * ch[2] == 1) then
	    check = 1	
	    res[1] = out[1] * out[1] - out[2] * out[2]
		res[1] = lib.math.round_dec(res[1], 4)
		res[2] = (out[1] - out[2]) * (out[1] - out[2])
	    res[2] = lib.math.round_dec(res[2], 4)		
    else
	    res[1] = value2[1] - value2[2]
		brojilac[1]= broj[1] * imen[2] - broj[2] * imen[1] 
		imenilac[1] = imen[1] * imen[2]	
		res[2] = (value[1] - value[2]) * (value[1] - value[2])
		brojilac[2] = (enum[1] * denom[2]  - enum[2] * denom[1]) * (enum[1] * denom[2]  - enum[2] * denom[1])
		imenilac[2] = imenilac[1]				
	end	
end	


if (ind == 3) then 
   if (ch[1] * ch[2] == 1) then
	    check = 1   
	    res[1] = out[1] * out[1] * out[2] * out[2]
		res[1] = lib.math.round_dec(res[1], 8)
		res[2] = (out[1] * out[2]) * (out[1] * out[2])
	    res[2] = lib.math.round_dec(res[2], 8)			
    else
	    res[1] = value2[1] * value2[2]
		brojilac[1]= broj[1] * broj[2] 
		imenilac[1] = imen[1] * imen[2]	
		res[2] = (value[1] * value[2]) * (value[1] * value[2])
		brojilac[2] = (enum[1] * enum[2]) * (enum[1] * enum[2])
		imenilac[2] = imenilac[1]	
	end	
end	

if (ind == 4) then 
	res[1] = value2[1] / value2[2]
    for j = 1,4 do
        temp = res[1] * 10^(5-j) 
        if (math.abs(lib.math.round(temp) - temp) < 0.00001) then
	        check = 5-j				
	    end		
    end
    if (check < 5) then
	    res[1] = (out[1] * out[1]) / (out[2] * out[2])
		res[1] = lib.math.round_dec(res[1], check)
		res[2] = (out[1] / out[2]) * (out[1] / out[2])
	    res[2] = lib.math.round_dec(res[2], check)			
    else
	    res[1] = value2[1] / value2[2]
		brojilac[1]= broj[1] * imen[2] 
		imenilac[1] = imen[1] * broj[2]	
		res[2] = (value[1] / value[2]) * (value[1] / value[2])
		brojilac[2] = (enum[1] * denom[2]) * (enum[1] * denom[2])
		imenilac[2] = imenilac[1]			
	end	
end	

if (ind == 5) then 
	res[1] = value[1] / value2[2]
	res[2] = value2[1] / value[2]	
	for i = 1,2 do
        dg[i] = 5	
        for j = 1,4 do
            temp = res[i] * 10^(5-j) 
            if (math.abs(lib.math.round(temp) - temp) < 0.00001) then
	            dg[i] = 5-j				
	        end		
        end
	end	
	if (dg[1] < dg[2]) then
	    check = dg[2]	
    else
	    check = dg[1]
    end			
    if (check < 5) then
	    res[1] = out[1]  / (out[2] * out[2])
		res[1] = lib.math.round_dec(res[1], check)
		res[2] = (out[1] * out[1]) / out[2]
	    res[2] = lib.math.round_dec(res[2], check)			
    else
	    res[1] = value[1] / value2[2]
		brojilac[1]= enum[1] * imen[2] 
		imenilac[1] = denom[1] * broj[2]	
		res[2] = value2[1] / value[2]
		brojilac[2] = broj[1] * denom[2] 
		imenilac[2] = imen[1] * enum[2]	
		if (imenilac[2] < 0) then
		    brojilac[2] = - brojilac[2]
			imenilac[2] = - imenilac[2]
		end		
	end	
end	

if (ind == 6) then 
    if (ch[1] * ch[2] == 1) then
	    check = 1	
	    res[1] = (out[1] + out[2]) * (out[1] - out[2])
		res[1] = lib.math.round_dec(res[1], 4)
		res[2] = (out[1] * out[1]) - (out[2] * out[2])
	    res[2] = lib.math.round_dec(res[2], 4)		
    else
	    res[1] = (value[1] + value[2]) * (value[1] - value[2]) 
		brojilac[1]= (enum[1] * denom[2] + enum[2] * denom[1]) * (enum[1] * denom[2] - enum[2] * denom[1])
		imenilac[1] = denom[1] * denom[2] * denom[1] * denom[2]	
		res[2] = value2[1] - value2[2] 
		brojilac[2] = broj[1] * imen[2] - broj[2] * imen[1]
		imenilac[2] = imen[1] * imen[2]				
	end	
end	

if (ind == 7) then 
    if (ch[1] * ch[2] == 1) then
	    check = 1	
	    res[1] = (out[1] + out[2]) * (out[1] - out[2])
		res[1] = lib.math.round_dec(res[1], 4)
		res[2] = (out[1] * out[1]) + (out[2] * out[2])
	    res[2] = lib.math.round_dec(res[2], 4)			
    else
        res[1] = (value[1] + value[2]) * (value[1] - value[2]) 
		brojilac[1]= (enum[1] * denom[2] + enum[2] * denom[1]) * (enum[1] * denom[2] - enum[2] * denom[1])
		imenilac[1] = denom[1] * denom[2] * denom[1] * denom[2]	
		res[2] = value2[1] + value2[2] 
		brojilac[2] = broj[1] * imen[2] + broj[2] * imen[1]
		imenilac[2] = imen[1] * imen[2]	
	end	
end	
            
if (check < 5) then			
    reply[1] = lib.check_number(res[1],80)
    reply[2] = lib.check_number(res[2],80)		
else
	for i = 1,2 do
		q = lib.math.gcd(brojilac[i], imenilac[i])
	    brojilac[i] = brojilac[i] / q
	    imenilac[i] = imenilac[i] / q	
	    if (res[i] > 0) then
            ceo[i] =  math.floor(brojilac[i]/imenilac[i])
	    else
            ceo[i] =  math.ceil(brojilac[i]/imenilac[i])
        end			
	    brojilac[i] = math.abs (brojilac[i] - imenilac[i] * ceo[i])
	    if (res[i] < 0 and ceo[i] == 0) then
			brojilac[i] = - brojilac[i]
		end	 			
        reply[i] = ""			
        if (ceo[i] ~= 0) then 	
		    reply[i] = reply[i] .. lib.check_number(ceo[i],30)			
        end
	    if (brojilac[i] ~= 0) then			
            cond[i] = brojilac[i]/ imenilac[i]		
            condition[i] = "is_ok = math.eq(numerator/denominator, "..tostring(cond[i])..");"
            sln[i] = "numerator="..tostring(math.floor(brojilac[i]))..";denominator="..tostring(math.floor(imenilac[i]))..";"	   
            reply[i] = reply[i] .. lib.check_fraction_condition(condition[i], nil, nil, sln[i])	     			
		end		
    end	
end	
            