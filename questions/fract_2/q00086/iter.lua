
whole = {}
enum = {}
denom = {}
broj = {}
value = {}
term = {""}
answ1 = ""
answ2 = ""

dim = 3

choice = math.random(3) 

for i = 1,dim do
    whole[i] = math.random(5) - 1 	--[[10]]--
    if (choice < 3) then
        if (choice == 1) then    	
            denom[i] = math.random(4) + 1    --[[8]]--
        else
	        denom[i] = 10
        end		
        enum[i] = math.random(denom[i] - 1)
        q = lib.math.gcd(denom[i], enum[i])
        denom[i] = denom[i]/q
        enum[i] = enum[i]/q 
    else
        denom[i] = 1
        enum[i] = 0
        whole[i] = whole[i] + 1		
    end
    broj[i] = whole[i] * denom[i] + enum[i]
	value[i] = broj[i] / denom[i]
end 

if (choice == 3 and value[2] == 1) then
    denom[2] = 1
    enum[2] = 0
    whole[2] = 2
    value[2] = whole[2]	
	broj[2] = whole[2]
end	

ind = math.random(4)

broj_x = broj[2] * broj[1] * broj[1]
imen_x = denom[2] * denom[1] * denom[1]

if (ind == 1) then
    result = value[2] * value[1] * value[1] + value[3]
	brojilac = broj_x * denom[3] + imen_x * broj[3]
	imenilac = imen_x * denom[3]
end	
if (ind == 2) then
    result = value[2] * value[1] * value[1] - value[3]
	brojilac = broj_x * denom[3] - imen_x * broj[3]
	imenilac = imen_x * denom[3]
end	
if (ind == 3) then
    result = 0
	brojilac = 0
	imenilac = 1
	ceo = 0
	brojilac_p = 0
	value[3] = value[2] * value[1] * value[1]  
	broj[3] =  broj_x
	denom[3] = imen_x
    q = lib.math.gcd(broj[3], denom[3])
    broj[3] = broj[3]/q
    denom[3] = denom[3]/q 	
    whole[3] =  math.floor(broj[3]/denom[3])	
	enum[3] = broj[3] - denom[3] * whole[3]			
end	
if (ind == 4) then
    result = value[3] - value[2] * value[1] * value[1]  
	brojilac = imen_x * broj[3] - broj_x * denom[3]  
	imenilac = imen_x * denom[3]
end	

if (ind ~= 3) then
    q = lib.math.gcd(brojilac, imenilac)
    brojilac = brojilac/q
    imenilac = imenilac/q 
    if (result > 0) then
        ceo = math.floor(brojilac/imenilac)
    else
        ceo =  math.ceil(brojilac/imenilac)
    end			
    brojilac_p = math.abs(brojilac - ceo * imenilac)	
    if (result < 0 and ceo == 0) then
	    brojilac_p = - brojilac_p
    end	 
end	

for i = 1,dim do	
	term[i] = ""
    if (choice == 1) then    	
        if (whole[i] ~= 0) then
	        term[i] = tostring(whole[i])
        end
        term[i] = term[i] .. "\(\frac{" .. tostring(math.floor(enum[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\)"
    else 
        if (choice == 2) then    
			if (ind == 3) then
			    round = 3
			else
			    round = 1
			end
            term[i] = lib.dec_to_str(lib.math.round_dec(value[i], round)) 			
		else
            term[i] = tostring(whole[i])		
	    end
    end	
end 	

term[4] = ""
if (choice == 1) then 
    if (ceo == 0 and brojilac_p == 0) then 
	    term[4] = tostring(ceo)
    else		
        if (ceo ~= 0) then
	        term[4] = tostring(ceo)
        end
	    if (brojilac_p ~= 0) then
            term[4] = term[4] .. "\(\frac{" .. tostring(math.floor(brojilac_p)) .. "}{" .. tostring(math.floor(imenilac)) .. "}\)"
		end	
	end
else 
    if (choice == 2) then    
        term[4] = lib.dec_to_str(lib.math.round_dec(result, 4)) 
	else
        term[4] = tostring(ceo)		
	end
end	   
            
quest = ""
if (ind == 1) then
    quest = quest .. term[2] .. " * x² + " .. term[3] .. " = " .. term[4]
else 
    if (ind < 4) then
        quest = quest .. term[2] .. " * x² - " .. term[3] .. " = " .. term[4] 	
    else 	
        quest = quest .. term[3] .. " - " .. term[2] .. " * x² = " .. term[4] 
	end
end	            
            
answ1 = "x₁ = " 
answ2 = "x₂ = " 

if (choice == 1) then   	   	
    res = -whole[1]
    tmp1 = enum[1]/denom[1]		
    b2 = -enum[1]
    tmp2 = b2/denom[1]				
    if (whole[1] ~= 0) then
	    answ1 = answ1 .. lib.check_number(whole[1],20)
		answ2 = answ2 .. lib.check_number(res,20)    	
        condition = "is_ok = math.eq(numerator/denominator, "..tostring(tmp1)..");"
        sln = "numerator="..tostring(enum[1])..";denominator="..tostring(denom[1])..";"	
        answ1 = answ1 .. lib.check_fraction_condition(condition, nil, nil, sln)
        answ2 = answ2 .. lib.check_fraction_condition(condition, nil, nil, sln)			
	else		
	    condition1 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp1)..");"
        sln1 = "numerator="..tostring(enum[1])..";denominator="..tostring(denom[1])..";"
        answ1 = answ1 .. lib.check_fraction_condition(condition1, nil, nil, sln1)	
	    condition2 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp2)..");"
        sln2 = "numerator="..tostring(b2)..";denominator="..tostring(denom[1])..";"	
        answ2 = answ2 .. lib.check_fraction_condition(condition2, nil, nil, sln2)		
	end	
else 
    res1 = lib.math.round_dec(value[1], 1)
    res2 = -res1
    answ1 = answ1 .. lib.check_number(res1, 30) 
    answ2 = answ2 .. lib.check_number(res2, 30) 			
end