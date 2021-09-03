
include("terms")

set = {2, 2, 2, 3, 3, 5}
dim = 6
add = 4

brac = {"\(\big ( \)", "\(\big ) \)"}
oper = {" - ", " + "} 

enum = {}
denom = {}
whl = {}
enum_p = {}
value = {}
qq = {}
brojilac = {}
imenilac = {}
inds = {} 

quest = {""}    
task = {"", ""}
reply1 = ""
reply2 = ""

max = 100 

for i = 1,3 do
    inds[i] = math.random(2);
end

ch = 1
for i = 1,add do
    if (i < 3) then
	    out = 1
    else
        out = 2	
	end
    qq = lib.math.random_shuffle(set)
    index = math.random(3)
	denom[i] = 1
	for j = 1,index do
        denom[i] = denom[i] * qq[j];
	end	 
    enum[i] = max - math.random(2*max - 1);	
    if (enum[i] == 0) then
        enum[i] = - 1 - math.random(10)
    end		
    value[i] = enum[i] / denom[i]	
    tmp = math.floor(value[i] * 10)
	rest = value[i] * 10 - tmp	
    if (rest == 0) then
	    numb = lib.math.round_dec(value[i], 1)
        quest[i] = lib.dec_to_str(numb)		
	    if (i - 2*math.floor(i/2) == 0) then
            task[out] = task[out] .. "(" .. lib.check_number(numb,30) .. ") " .. brac[2]
        else
            task[out] = task[out] .. " " .. brac[1] .. " (" .. lib.check_number(numb,30) .. ") " 	
        end				
    else	    
	    q = lib.math.gcd(enum[i], denom[i])
		enum[i] = enum[i] / q
		denom[i] = denom[i] / q
        value[i] = enum[i]/denom[i]
        if (value[i] > 0) then
            whl[i] = math.floor(value[i])
        else 
            whl[i] = math.ceil(value[i])
        end	
        if (whl[i] == 0) then
            quest[i] = "\(\frac{" .. tostring(math.floor(enum[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"	
			answ = lib.check_fraction_simple(enum[i], denom[i])
        else
	        enum_p[i] = math.abs(enum[i] - denom[i] * whl[i])			     
	        quest[i] = tostring(whl[i]) .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"	      
			answ = lib.check_number(whl[i],20) .. lib.check_fraction_simple(enum_p[i], denom[i])			
        end	
		ch = 2			
	    if (i - 2*math.floor(i/2) == 0) then
            task[out] = task[out] .. "(" .. answ .. ") " .. brac[2]
        else
            task[out] = task[out] .. " " .. brac[1] .. " (" .. answ .. ") " 	
        end	
    end			
	if (i < add) then
        task[out] = task[out] .. " " .. lib.check_string(oper[inds[i]],10) 
	end
end   

sign1 = operat1[inds[1]]
if (inds[1] == 1) then 
    term1 = value[1] - value[2]
else
    term1 = value[1] + value[2]	
end	

sign3 = operat1p[inds[3]]
if (inds[3] == 1) then 
    term2 = value[3] - value[4]
else
    term2 = value[3] + value[4]	
end	

sign2 = operat2a[inds[2]];
if (inds[2] == 1) then 
    result = term1 - term2
else
    result = term1 + term2	
end	

if (ch == 2) then
   tmp = math.floor(result * 10)
   rest = result * 10 - tmp
   if (rest == 0) then
       ch = 1
   end	
end

if (ch == 2) then
    q = lib.math.gcd(denom[1], denom[2])
    imenilac[1] = denom[1] * denom[2] / q
    if (inds[1] == 1 ) then
	    brojilac[1] = (enum[1] * denom[2] - enum[2] * denom[1])/q
    else 
	    brojilac[1] = (enum[1] * denom[2] + enum[2] * denom[1])/q	
    end
    q = lib.math.gcd(denom[3], denom[4])
    imenilac[2] = denom[3] * denom[4] / q
    if (inds[3] == 1 ) then
	    brojilac[2] = (enum[3] * denom[4] - enum[4] * denom[3])/q
    else 
	    brojilac[2] = (enum[3] * denom[4] + enum[4] * denom[3])/q	
    end
    imen_t = imenilac[1] * imenilac[2] 
    if (inds[2] == 1 ) then
	    broj_t = brojilac[1] * imenilac[2] - brojilac[2] * imenilac[1]
    else 
	    broj_t = brojilac[1] * imenilac[2] + brojilac[2] * imenilac[1]
    end
    q = lib.math.gcd(imen_t, broj_t)
    broj = broj_t/ q
    imen = imen_t / q
    result = broj/imen
    if (result == 0) then
	    reply1 = lib.check_number(result,30)
    else
		if (result > 0) then
            ceo = math.floor(result)
	    else
            ceo = math.ceil(result)	
	    end	
        rest = broj - ceo * imen		
        if (ceo ~= 0) then
            reply1 = lib.check_number(ceo,30)
            rest = math.abs (rest)			
        end						
	    if (rest ~= 0) then		
			tmp = rest/imen				
            condition2 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"
            sln2 = "numerator="..tostring(rest)..";denominator="..tostring(imen)..";"
            reply2 = lib.check_fraction_condition(condition2, nil, nil, sln2)	
        end
	end	
else
    reply1 = lib.check_number(result, 30)		
end		


         
   

