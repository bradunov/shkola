
whole = {}
enum = {}
denom = {}
broj = {}
value = {}
term = {""}

dim = 2

choice = math.random(3) 

brojilac = 1
imenilac = 1
for i = 1,dim do
    wh = math.random(4) - 1 	--[[10]]--
    if (choice < 3) then
        if (choice == 1) then    	
            den = math.random(4) + 1    --[[8]]--
            en = math.random(den - 1)
        else
	        den = 10
            en = math.random(den - 5)
        end		
        q = lib.math.gcd(den, en)
        den = den/q
        en = en/q 
    else
        den = 1
        en = 0
        wh = wh + 3		
    end
    br = wh * den + en	
    broj[i] = br * br
	denom[i] = den * den
    q = lib.math.gcd(broj[i] , denom[i])
    broj[i] = broj[i]/q
    denom[i] = denom[i]/q 
    whole[i] = math.floor(broj[i] / denom[i])	
    enum[i] = broj[i] - whole[i] * denom[i]	
	value[i] = broj[i] / denom[i] 
	brojilac = brojilac * br
	imenilac = imenilac * den
end 
result = brojilac / imenilac

q = lib.math.gcd(brojilac, imenilac)
brojilac = brojilac/q
imenilac = imenilac/q 
ceo = math.floor(brojilac / imenilac)	
brojilac_res = brojilac - ceo * imenilac	

for i = 1,dim do	
	term[i] = ""
    if (choice == 1) then    	
        if (whole[i] ~= 0) then
	        term[i] = tostring(whole[i])
        end
        term[i] = term[i] .. "\(\frac{" .. tostring(math.floor(enum[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"
    else 
        term[i] = lib.dec_to_str(lib.math.round_dec(value[i], 2)) 			
    end	
end 

quest = "√(" .. term[1]
for i = 2,dim do
	quest =  quest .. " * " .. term[i]   
end	
quest = quest .. ")" 

answ = "" 

if (choice == 1) then   	 						   	
    if (ceo ~= 0) then
		answ = answ .. lib.check_number(ceo,20)
    end  
    if (brojilac_res ~= 0) then 
        tmp = brojilac_res/imenilac 	
        condition = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"
        sln = "numerator="..tostring(brojilac_res)..";denominator="..tostring(imenilac)..";"	
        answ = answ .. lib.check_fraction_condition(condition, nil, nil, sln)			
	end		
    if (ceo == 0 and brojilac_res == 0) then
        answ = answ .. lib.check_number(0, 20) 		
	end		
else 
    res = lib.math.round_dec(result, 2)
    answ = answ .. lib.check_number(res, 40) 			
end   
