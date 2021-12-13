
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
sign = {}
dg = {}
term = {}
add = {}
ind = {}

dimv = 5

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
    out[i] = lib.dec_to_str(lib.math.round_dec(value[ch[i]], chind))	
end	

                      
for i = 1,dimv do
    dg[i] = math.random(2)
    if (dg[i] == 1) then
        term[i] = value[i]
    else
        term[i] = value[i] * value[i]
    end	
end	
                              
nr = 1
add[1] = term[1]
for i = 1,dimv-1 do
    index = math.random(3)
	if (index == 3) then
	    sign[i] = "*"
		add[nr] = add[nr] * term[i+1]
    else
		if (index == 1) then
	        sign[i] = "+"
			ind[nr] = 1
		else
	        sign[i] = "-"
			ind[nr] = 2			
	    end
		nr = nr + 1	
	    add[nr] = term[i+1]		
	end	
end	                      

result = add[1]
for i = 2,nr do
    if (ind[i-1] == 1) then
        result = result + add[i]
	else
        result = result - add[i]	
    end 
end

	
quest = ""

for i = 1,dimv do 
    fr = 0	
    for j = 1,2 do
		if (i == ch[j]) then
			fr = j
		end	
	end	
	if (fr == 0) then
        if (whl[i] ~= 0) then
            quest = quest .. "( " .. whl[i] 
		else
            quest = quest .. "( "           				
        end
	    if (enum_p[i] ~= 0) then			
            quest = quest .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\) "         				
		end		
	else
        quest = quest .. "(" .. out[fr] 
	end
    if (dg[i] == 1) then
	    quest = quest .. " ) "
	else
        quest = quest .. " )² "
    end	
    if (i < dimv) then
        quest = quest .. " " .. sign[i] .. " "
    end	
end	


reply1 = ""
reply2 = ""


err = lib.math.round(result*1000)
if (math.abs(err - result*1000) < 0.0001) then
    result = lib.math.round_dec(result,3)
    reply1 = lib.check_number(result,50)
else
    imenilac = 1	
    for i = 1,dim do
	    imenilac = imenilac * set[i] * set[i]
    end
	brojilac = result * imenilac
    q = lib.math.gcd(imenilac, brojilac)
    broj = brojilac/ q
    imen = imenilac / q
    if (imen < 0) then
        broj = - broj
	    imen = - imen
    end	
    if (result > 0) then
        swhole = math.floor(result)
    else 
        swhole = math.ceil(result)
    end
    rest = broj - swhole * imen		
    if (swhole ~= 0) then
        reply1 = lib.check_number(swhole,30)
        rest = math.abs (rest)			
     end
     rest = math.floor(rest)	 
	 if (rest ~= 0) then 
		tmp = rest/imen				
        condition2 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"
        sln2 = "numerator="..tostring(rest)..";denominator="..tostring(imen)..";"
        reply2 = lib.check_fraction_condition(condition2, nil, nil, sln2)	
     end
end		
 