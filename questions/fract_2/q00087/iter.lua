
whole = {}
enum = {}
denom = {}
broj = {}
value = {}
term = {""}
answ1 = ""
answ2 = ""

dim = 5

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
        whole[i] = whole[i] + 1		
    end
    broj[i] = whole[i] * denom[i] + enum[i]
	value[i] = broj[i] / denom[i]
end 

index = math.random(3)
if (index < 2) then
    broj_y = broj[4] * broj[1] * denom[5] + denom[4] * denom[1] * broj[5] 
    val_y = value[4] * value[1] + value[5]
    sol = -2 * value[5] / value[4] - value[1]
    broj_sol = 	-2 * broj[5] * denom[4] * denom[1] - broj[1] * denom[5] * broj[4]
	imen_sol = denom[1] * denom[5] * broj[4]
else
    broj_y = broj[4] * broj[1] * denom[5] - denom[4] * denom[1] * broj[5]
    val_y = value[4] * value[1] - value[5]	
    sol = 2 * value[5] / value[4] - value[1]
    broj_sol = 	2 * broj[5] * denom[4] * denom[1] - broj[1] * denom[5] * broj[4]
	imen_sol = denom[1] * denom[5] * broj[4]	
end	
imen_y = denom[4] * denom[1] * denom[5]  

q = lib.math.gcd(broj_sol, imen_sol)
broj_sol = broj_sol/q
imen_sol = imen_sol/q 
if (sol > 0) then
    ceo_sol = math.floor(broj_sol/imen_sol)
else
    ceo_sol = math.ceil(broj_sol/imen_sol)
end			
brojilac_sol = math.abs(broj_sol - ceo_sol * imen_sol)	
if (sol < 0 and ceo_sol == 0) then
    brojilac_sol = - brojilac_sol
end	 

ind = math.random(4)

broj_x = broj[2] * broj_y * broj_y
imen_x = denom[2] * imen_y * imen_y

if (ind == 1) then
    result = value[2] * val_y * val_y + value[3]
	brojilac = broj_x * denom[3] + imen_x * broj[3]
	imenilac = imen_x * denom[3]
end	
if (ind == 2) then
    result = value[2] * val_y * val_y - value[3]
	brojilac = broj_x * denom[3] - imen_x * broj[3]
	imenilac = imen_x * denom[3]
end	
if (ind == 3) then
    result = 0
	brojilac = 0
	imenilac = 1
	ceo = 0
	brojilac_p = 0
	value[3] = value[2] * val_y * val_y  
	broj[3] =  broj_x
	denom[3] = imen_x
    q = lib.math.gcd(broj[3], denom[3])
    broj[3] = broj[3]/q
    denom[3] = denom[3]/q 	
    whole[3] =  math.floor(broj[3]/denom[3])	
	enum[3] = broj[3] - denom[3] * whole[3]			
end	
if (ind == 4) then
    result = value[3] - value[2] * val_y * val_y  
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
			    round = 5
			else
			    round = 1
			end
            term[i] = lib.dec_to_str(lib.math.round_dec(value[i], round)) 			
		else
            term[i] = tostring(whole[i])		
	    end
    end	
end 	

term[6] = ""
if (choice == 1) then 
    if (ceo == 0 and brojilac_p == 0) then 
	    term[6] = tostring(ceo)
    else		
        if (ceo ~= 0) then
	        term[6] = tostring(ceo)
        end
	    if (brojilac_p ~= 0) then
            term[6] = term[6] .. "\(\frac{" .. tostring(math.floor(brojilac_p)) .. "}{" .. tostring(math.floor(imenilac)) .. "}\)"
		end	
	end
else 
    if (choice == 2) then    
        term[6] = lib.dec_to_str(lib.math.round_dec(result, 6)) 
	else
        term[6] = tostring(ceo)		
	end
end	   
            
quest = ""
if (ind == 1) then
    if (index == 1) then 
        quest = quest .. term[2] .. " * (" .. term[4] .. " * x + " .. term[5] .. ")² + " .. term[3] .. " = " .. term[6]
	end	
    if (index == 2) then 
        quest = quest .. term[2] .. " * (" .. term[4] .. " * x - " .. term[5] .. ")² + " .. term[3] .. " = " .. term[6]
	end	
    if (index == 3) then 
        quest = quest .. term[2] .. " * (" .. term[5] .. " - " .. term[4] .." * x )² + " .. term[3] .. " = " .. term[6]
	end		
end 
if (ind == 2) then
        if (index == 1) then 
            quest = quest .. term[2] .. " * (" .. term[4] .. " * x + " .. term[5] .. ")² - " .. term[3] .. " = " .. term[6]
	    end	
        if (index == 2) then 
            quest = quest .. term[2] .. " * (" .. term[4] .. " * x - " .. term[5] .. ")² - " .. term[3] .. " = " .. term[6]
	    end	
        if (index == 3) then 
            quest = quest .. term[2] .. " * (" .. term[5] .. " - " .. term[4] .." * x )² - " .. term[3] .. " = " .. term[6]
	    end			
end
if (ind == 3) then
        if (index == 1) then 
            quest = quest .. term[2] .. " * (" .. term[4] .. " * x + " .. term[5] .. ")² = " .. term[3] 
	    end	
        if (index == 2) then 
            quest = quest .. term[2] .. " * (" .. term[4] .. " * x - " .. term[5] .. ")² = " .. term[3] 
	    end	
        if (index == 3) then 
            quest = quest .. term[2] .. " * (" .. term[5] .. " - " .. term[4] .." * x )² = " .. term[3] 
	    end			
end

 if (ind == 4) then	
        if (index == 1) then 
            quest = quest .. term[3] .. " - " .. term[2] .. " * (" .. term[4] .. " * x + " .. term[5] .. ")² = " .. term[6]
	    end	
        if (index == 2) then 
            quest = quest .. term[3] .. " - " .. term[2] .. " * (" .. term[4] .. " * x - " .. term[5] .. ")² = " .. term[6]
	    end	
        if (index == 3) then 
            quest = quest .. term[3] .. " - " .. term[2] .. " * (" .. term[5] .. " - " .. term[4] .. " * x)² = " .. term[6]
	    end					
end	            

           
answ1 = "x₁ = " 
answ2 = "x₂ = " 

if (choice == 1) then   	 				
    if (whole[1] ~= 0) then
	    answ1 = answ1 .. lib.check_number(whole[1],20) 
    end	
    tmp1 = enum[1]/denom[1]		
    condition1 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp1)..");"
    sln1 = "numerator="..tostring(enum[1])..";denominator="..tostring(denom[1])..";"	
    answ1 = answ1 .. lib.check_fraction_condition(condition1, nil, nil, sln1)			   	
    if (ceo_sol ~= 0) then
		answ2 = answ2 .. lib.check_number(ceo_sol,20)
    end  
    if (brojilac_sol ~= 0) then 
        tmp2 = brojilac_sol/imen_sol 	
        condition2 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp2)..");"
        sln2 = "numerator="..tostring(brojilac_sol)..";denominator="..tostring(imen_sol)..";"	
        answ2 = answ2 .. lib.check_fraction_condition(condition2, nil, nil, sln2)			
	end		
    if (ceo_sol == 0 and brojilac_sol == 0) then
        answ2 = answ2 .. lib.check_number(0, 20) 		
	end		
else 
    res1 = lib.math.round_dec(value[1], 1)
    res2 = lib.math.round_dec(sol, 5)
    answ1 = answ1 .. lib.check_number(res1, 60) 
    answ2 = answ2 .. lib.check_number(res2, 60) 			
end   

