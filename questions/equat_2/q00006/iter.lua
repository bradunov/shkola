
ch = math.random(4)

for i = 1,3 do
    qq = lib.math.random_shuffle(set)
    ind = math.random(2)
	denom[i] = 1
	for j = 1,ind do
	    if (i == ch) then 
		    if (qq[j] == 3 or qq[j] == 7) then
                denom[i] = denom[i] * 5;
			else
                denom[i] = denom[i] * qq[j];
            end	
        else			
            denom[i] = denom[i] * qq[j];
		end	
	end 
    enum[i] = 5 + math.random(max);	 
    value[i] = enum[i] / denom[i]
    if (value[i] == math.floor(value[i])) then
	    enum[i] = enum[i] + 1
		value[i] = enum[i] / denom[i]
	end		
end

for i = 1,3 do
    q = lib.math.gcd(enum[i], denom[i])
	enum[i] = enum[i] / q
	denom[i] = denom[i] / q	
    whl[i] =  math.floor(enum[i]/denom[i])
	enum_p[i] = enum[i] - denom[i] * whl[i]
end

if (ch < 4) then		
    chind = 3
    for j = 1,3 do
        temp = value[ch] * 10^(4-j) 
        if (math.abs(lib.math.round(temp) - temp) < 0.0001) then
           chind = 4-j
        end	
    end
    out = lib.dec_to_str(lib.math.round_dec(value[ch], chind))	
end	


index = math.random(4)

if (index < 3 ) then
    if (value[1] > value[2]) then
	    sign[1] = "-"
	    sum1_e = enum[1]*denom[2]  - enum[2]*denom[1] 
		res1 = value[1] - value[2]
	else
	    sign[1] = "+"
	    sum1_e = enum[1]*denom[2]  + enum[2]*denom[1] 
		res1 = value[1] + value[2]		
    end		
	sum1_d = denom[1] * denom[2]
	if (index == 1) then                                        --[[((a+b):c, x=c)]]--
	    sign[2] = ":"
        brojilac = sum1_e * denom[3]
        imenilac = sum1_d * enum[3]	
		result = (res1/value[3]) 
	else                                                          --[[((a+b)*c), x=c]]--
	    sign[2] = "*"	
        brojilac  = sum1_e * enum[3]
        imenilac = sum1_d * denom[3]	
		result = (res1*value[3]) 		
	end	
else	
    if (index == 3) then                                         --[[(a+b:c), x=c]]--
	    sign[2] = ":"
        if (value[1]*value[3] > value[2]) then
	        sign[1] = "-"
	        brojilac = enum[1]*denom[2]*enum[3]  - denom[1]*enum[2]*denom[3] 
		    result = value[1] - value[2]/value[3]
	    else
	        sign[1] = "+"
	        brojilac = enum[1]*denom[2]*enum[3]  + denom[1]*enum[2]*denom[3] 
		    result = value[1] + value[2]/value[3]		
        end		
	    imenilac = denom[1] * denom[2]*enum[3] 
	else                        
        sign[2] = "*"                                                  --[[(a+b*c), x=c]]--
		if (value[1] > value[2]*value[3]) then                       
	        sign[1] = "-"
	        brojilac = enum[1]*denom[2]*denom[3]  - denom[1]*enum[2]*enum[3] 
		    result = value[1] - value[2]*value[3]
	    else
	        sign[1] = "+"
	        brojilac = enum[1]*denom[2]*denom[3]  + denom[1]*enum[2]*enum[3] 
		    result = value[1] + value[2]*value[3]		
        end		
	    imenilac = denom[1] * denom[2]*denom[3]	
	end
end	

quest = ""

if (index < 3 ) then
    quest = left_b   
    for i = 1,2 do 	
		if (i == ch) then
			fr = j
		else
            fr = 0			
		end	
		if (fr == 0) then
            if (whl[i] ~= 0) then
                quest = quest .. whl[i] 
            end
	        if (enum_p[i] ~= 0) then
                quest = quest .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\) "   
		    end				
		else
            quest = quest .. out 
		end
		if (i == 1) then
            quest = quest .. sign[i] .. " "
        end			
		if (i == 2) then
            quest = quest .. right_b .. sign[i]	.. " "	
		end 				 		
    end
else
    quest = "" 
    for i = 1,2 do 
		if (i == ch) then
			fr = j
		else
            fr = 0				
		end	
		if (fr == 0) then
            if (whl[i] ~= 0) then
                quest = quest .. whl[i] 
            end
	        if (enum_p[i] ~= 0) then
                quest = quest .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\) "   
		    end				
		else
            quest = quest .. out 
		end
		if (i == 1) then
            quest = quest .. sign[i] .. " "
        end			
		if (i == 2) then
            quest = quest  .. sign[i]	.. " "	
		end 
    end	
end
quest = quest  .. " x "
	
q = lib.math.gcd(imenilac, brojilac)
broj = brojilac/ q
imen = imenilac / q
ceo = math.floor(broj/imen)
broj = broj - ceo * imen

ans = ""
if (ceo ~= 0) then
    ans = ans .. ceo
end
if (broj ~= 0) then
    ans = ans .. "\(\frac{" .. math.floor(broj) .. "}{" .. math.floor(imen).. "}\)" 
end	
	
reply = ""                       
if (whl[3] == 0) then
    condition = "is_ok = math.eq(numerator/denominator, "..tostring(value[3])..");"	          
    solution = "numerator="..tostring(enum_p[3])..";denominator="..tostring(denom[3])..";"
    reply =  lib.check_fraction_condition(condition, nil, nil, solution)
else
    condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(value[3])..");"	          
    solution = "numerator="..tostring(enum_p[3])..";denominator="..tostring(denom[3])..";whole="..tostring(whl[3])..";"
    reply =  lib.check_fraction_condition(condition, true, nil, solution)
end	
    
                          
            
   
                      
            
            

            
	 
            



	 