
ch[1] = math.random(4)
ch[2] = ch[1] + math.random(6 - ch[1])
for i = 1,6 do
    qq = lib.math.random_shuffle(set)
    ind = math.random(2)
	denom[i] = 1
	for j = 1,ind do
	    if (i == ch[1] or i == ch[2]) then 
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

for i = 1,6 do
    q = lib.math.gcd(enum[i], denom[i])
	enum[i] = enum[i] / q
	denom[i] = denom[i] / q	
end	

for i = 1,6 do
    if (i ~= ch[1] and i ~= ch[2]) then
        whl[i] =  math.floor(enum[i]/denom[i])
	    enum_p[i] = enum[i] - denom[i] * whl[i]
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
    if (value[5] > value[6]) then
	    sign[5] = "-"
	    sum2_e = enum[5]*denom[6]  - enum[6]*denom[5] 
		res2 = value[5] - value[6]		
	else
	    sign[5] = "+"
	    sum2_e = enum[5]*denom[6]  + enum[6]*denom[5] 
		res2 = value[5] + value[6]		
    end		
	sum2_d = denom[5] * denom[6]	
	if (index == 1) then                                        --[[((a+b):c):(d*(e-f))]]--
	    sign[2] = ":"
		sign[4] = "*"
        term1_e = sum1_e * denom[3]
        term1_d = sum1_d * enum[3]	
        term2_e = sum2_e * enum[4]
        term2_d = sum2_d * denom[4]	
		result = (res1/value[3]) / (value[4]*res2)
	else                                                          --[[((a+b)*c):(d:(e-f))]]--
	    sign[2] = "*"
		sign[4] = ":"	
        term1_e = sum1_e * enum[3]
        term1_d = sum1_d * denom[3]	
        term2_e = sum2_d * enum[4]
        term2_d = sum2_e * denom[4]	
		result = (res1*value[3]) / (value[4]/res2)		
	end	
else	
    if (index == 3) then                                         --[[(a+b:c):(d*e-f)]]--
	    sign[2] = ":"
		sign[4] = "*"	
        if (value[1]*value[3] > value[2]) then
	        sign[1] = "-"
	        term1_e = enum[1]*denom[2]*enum[3]  - denom[1]*enum[2]*denom[3] 
		    res1 = value[1] - value[2]/value[3]
	    else
	        sign[1] = "+"
	        term1_e = enum[1]*denom[2]*enum[3]  + denom[1]*enum[2]*denom[3] 
		    res1 = value[1] + value[2]/value[3]		
        end		
	    term1_d = denom[1] * denom[2]*enum[3]
        if (value[4]*value[5] > value[6]) then
	        sign[5] = "-"
	        term2_e = enum[4]*enum[5]*denom[6]  - enum[6]*denom[4]*denom[5] 
		    res2 = value[4] * value[5] - value[6]		
	    else
	        sign[5] = "+"
	        term2_e = enum[4]*enum[5]*denom[6]  + enum[6]*denom[4]*denom[5] 
		    res2 = value[4] * value[5] + value[6]		
        end		
	    term2_d = denom[4] * denom[5] * denom[6]	
	    result = res1 / res2	
	else                        
        sign[2] = "*"                                                  --[[(a+b*c):(d:e-f)]]--
		sign[4] = ":"
		if (value[1] > value[2]*value[3]) then                       
	        sign[1] = "-"
	        term1_e = enum[1]*denom[2]*denom[3]  - denom[1]*enum[2]*enum[3] 
		    res1 = value[1] - value[2]*value[3]
	    else
	        sign[1] = "+"
	        term1_e = enum[1]*denom[2]*denom[3]  + denom[1]*enum[2]*enum[3] 
		    res1 = value[1] + value[2]*value[3]		
        end		
	    term1_d = denom[1] * denom[2]*denom[3]
        if (value[4] > value[5]*value[6]) then
	        sign[5] = "-"
	        term2_e = enum[4]*denom[5]*denom[6]  - enum[6]*denom[4]*enum[5] 
		    res2 = value[4] / value[5] - value[6]		
	    else
	        sign[5] = "+"
	        term2_e = enum[4]*denom[5]*denom[6]  + enum[6]*denom[4]*enum[5] 
		    res2 = value[4] / value[5] + value[6]		
        end		
	    term2_d = denom[4] * enum[5] * denom[6]	
	    result = res1 / res2	
	end
end	
brojilac = term1_e * term2_d
imenilac = term1_d * term2_e	
sign[3]	= ":"
sign[6] = ""
	
quest = ""

if (index < 3 ) then
    quest = left_b .. left_b  
    for i = 1,6 do 
        fr = 0	
        for j = 1,2 do
		    if (i == ch[j]) then
			    fr = j
			end	
		end	
		if (fr == 0) then
            if (whl[i] ~= 0) then
                quest = quest .. whl[i] 
            end
	        if (enum_p[i] ~= 0) then
                quest = quest .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\) "   
		    end				
		else
            quest = quest .. out[fr] 
		end
		if (i == 1 or i == 5) then
            quest = quest .. sign[i] .. " "
        end			
		if (i == 2) then
            quest = quest .. right_b .. sign[i]	.. " "	
		end
		if (i == 3) then
            quest = quest .. right_b .. sign[i] .. " " .. left_b		
		end   			
		if (i == 4) then
            quest = quest .. sign[i] .. " " .. left_b 
        end		
		if (i == 6) then
            quest = quest .. right_b .. right_b 
        end		 		
    end
else
    quest = left_b  
    for i = 1,6 do 
        fr = 0	
        for j = 1,2 do
		    if (i == ch[j]) then
			    fr = j
			end	
		end	
		if (fr == 0) then
            if (whl[i] ~= 0) then
                quest = quest .. whl[i] 
            end
	        if (enum_p[i] ~= 0) then
                quest = quest .. "\(\frac{" .. tostring(math.floor(enum_p[i])) .. "}{" .. tostring(math.floor(denom[i])) .. "}\) "   
		    end				
		else
            quest = quest .. out[fr] 
		end
		if (i == 3) then
            quest = quest .. right_b .. sign[i] .. " " .. left_b	
        else
			if (i == 6) then
                quest = quest .. right_b 
			else	
                quest = quest .. sign[i] .. " "		
		    end   			
        end		 		
    end	
end
	
q = lib.math.gcd(imenilac, brojilac)
broj = brojilac/ q
imen = imenilac / q
ceo = math.floor(broj/imen)
broj = broj - ceo * imen

ans = ""
if (result == 0) then
    ans = lib.check_number(0,40)
else	
    if (ceo ~= 0 and broj ~= 0) then
        condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(result)..");"	          
        solution = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";whole="..tostring(ceo)..";"
        ans = lib.check_fraction_condition(condition, true, nil, solution)		
	else
	    if (ceo == 0) then
            condition = "is_ok = math.eq(numerator/denominator, "..tostring(result)..");"	          
            solution = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
            ans = lib.check_fraction_condition(condition, nil, nil, solution)	
        else			
	        ans = ans .. lib.check_number(ceo,40) 
        end	
    end
end	      

            
	 
            



	 