
whole = {}
enum = {}
denom = {}
broj = {}
value = {}
term = {""}
root = {""}


dim = 6
dim2 = 3

choice = math.random(3) 

for i = 1,dim do
    whole[i] = math.random(4) - 1 	--[[10]]--
    if (choice < 3) then
        if (choice == 1) then    	
            denom[i] = math.random(4) + 1    --[[8]]--
            enum[i] = math.random(denom[i] - 1)
        else
	        denom[i] = 10
            enum[i] = math.random(denom[i] - 5)
        end		
        q = lib.math.gcd(denom[i], enum[i])
        denom[i] = denom[i]/q
        enum[i] = enum[i]/q 
    else
        denom[i] = 1
        enum[i] = 0
        whole[i] = whole[i] + 3		
    end
    broj[i] = whole[i] * denom[i] + enum[i]	
	fct = math.random(2)
	if (i ~= 2 * math.floor(i/2) and fct == 2) then
        broj[i] = - broj[i]  
        whole[i] =  math.ceil(broj[i]/denom[i])
        if (whole[i] == 0) then
	        enum[i] = - enum[i]
        end	 			
    end				
	value[i] = broj[i] / denom[i]
end 

for i = 1,dim do	
	term[i] = ""
    if (choice == 1) then    	
        if (whole[i] ~= 0) then
	        term[i] = tostring(whole[i])
        end
        term[i] = term[i] .. "\(\frac{" .. tostring(math.floor(enum[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"
    else 
        term[i] = lib.dec_to_str(lib.math.round_dec(value[i], 1)) 			
    end	
end 

for i = 1,dim2 do
	ind = math.random(4)
	if (ind == 1) then
	    root[i] =  "√(" .. term[2*i] .. ")² "  
	end	
	if (ind == 2) then
	    root[i] =  "√(-" .. term[2*i] .. ")² "  
	end	
	if (ind == 3) then
	    root[i] =  "(√" .. term[2*i] .. ")² "  
	end		
	if (ind == 4) then
        broj_r = broj[2*i] * broj[2*i]
        imen_r = denom[2*i] * denom[2*i]
		val_r = broj_r/imen_r		
		ceo_r = math.floor(val_r)
		broj_r = broj_r - ceo_r * imen_r
		tmp = ""
        if (choice == 1) then    	
            if (ceo_r ~= 0) then
	            tmp = tmp .. tostring(ceo_r)
            end
            tmp = tmp .. "\(\frac{" .. tostring(math.floor(broj_r)) .. "}{" .. tostring(math.floor(imen_r)) .. "}\)"
        else 
            tmp = tmp .. lib.dec_to_str(lib.math.round_dec(val_r, 2)) 			
        end					
	    root[i] =  "√(" .. tmp .. ") "  
	end		
end

quest = "(" .. term[1] .. ") * " .. root[1] 

result = value[1] * value[2]
brojilac = broj[1] * broj[2]
imenilac = denom[1] * denom[2]
	
for i = 2,dim2 do
	sign = math.random(2)		
    if (sign == 1) then
	    result = result + value[2*i-1] * value[2*i]
        x = brojilac * denom[2*i-1] * denom[2*i] + imenilac * broj[2*i-1] * broj[2*i] 		
        quest = quest .. " + " .. "(" .. term[2*i-1] .. ") * " .. root[i]			
	else
	    result = result - value[2*i-1] * value[2*i]	
        x = brojilac * denom[2*i-1] * denom[2*i] - imenilac * broj[2*i-1] * broj[2*i]	
        quest = quest .. " - " .. "(" .. term[2*i-1] .. ") * " .. root[i]						
    end	
    y = imenilac * denom[2*i-1] * denom[2*i]	
    brojilac = x	
    imenilac = y		
end

q = lib.math.gcd(brojilac, imenilac)
brojilac = brojilac/q
imenilac = imenilac/q 
if (result > 0) then
    ceo = math.floor(result)
else
    ceo = math.ceil(result)
end		
brojilac_res = math.abs(brojilac - ceo * imenilac)	
if (result < 0 and ceo == 0) then
    brojilac_res = - brojilac_res
end	

answ = "" 

if (choice == 1) then   	 						   	
    if (ceo ~= 0) then
		answ = answ .. lib.check_number(ceo,20)
    end  
    if (brojilac_res ~= 0) then 
        tmp2 = brojilac_res/imenilac 	
        condition = "is_ok = math.eq(numerator/denominator, "..tostring(tmp2)..");"
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
