
include("terms")
                                                                                                                                                                                               
sign = {" | ", " √ ", "²", "₁", "₂"}
numb = {}
note = " "

ind = math.random(2)
max_range = 6

for i = 1,4 do
	min_range = -1	
	if (i == 1) then
		min_range = 0
	end	
	numb[i] = min_range + math.random(max_range)  
    if (i < 4) then	
		sg = math.random(2)	
		if (sg == 2) then
			numb[i] = - numb[i]			
		end
	end
end	
	
if (ind == 2) then	
    numb[5] = numb[1] * numb[1] 
    numb[6] = 2 * numb[1] * numb[2]   
    numb[7] = numb[2] * numb[2] 		
end	

quest = ""
if (ind == 1) then
    quest = ""
	if (math.abs(numb[1]) ~= 1) then
		quest = quest .. numb[1]
	else 
		if (numb[1] < 0) then
			quest = quest .. " - "
		end		
	end
    quest = quest .. " x " 
	if (numb[2] ~= 0) then
		if (numb[2] > 0) then
		    if (numb[1] < 0) then
				quest = numb[2] .. quest 
			else
				quest = quest .. " + " .. numb[2]
			end
		else
			quest = quest .. " - " .. math.abs(numb[2])
		end
	end
	quest = sign[1] .. quest .. sign[1]
else
    quest = sign[2] .. "( "  
	if (math.abs(numb[5]) ~= 1) then
		quest = quest .. numb[5]
	else 
		if (numb[5] < 0) then
			quest = quest .. " - "
		end		
	end
    quest = quest .. " x" .. sign[3]
	if (numb[6] ~= 0) then
		if (numb[6] > 0) then
			quest = quest .. " + "
		else
			quest = quest .. " - "
		end
		if (math.abs(numb[6]) ~= 1) then
			quest = quest .. math.abs(numb[6]) 
		end
		quest = quest .. " x "
	end
	if (numb[7] ~= 0) then
		if (numb[7] > 0) then
			quest = quest .. " + "
		else
			quest = quest .. " - "
		end
		quest = quest .. math.abs(numb[7]) 
	end
	quest = quest .. " ) "
end	
if (numb[3] ~= 0) then
	if (numb[3] > 0) then
		quest = quest .. " + "
	else
		quest = quest .. " - "
	end
	quest = quest .. math.abs(numb[3])
end
quest = quest .. " = " .. numb[4]	

ftp = numb[4] - numb[3]
if (ftp < 0) then
    reply = msg[3]
else
	enum1 = ftp - numb[2] 
	value1 = enum1 / numb[1]	
	enum2 = -ftp - numb[2] 
	value2 = enum2 / numb[1]
    if (value1 ~= value2) then	
		reply  = msg[1]
		if (value1 > value2) then
		    tmp = value2
			value2 = value1
			value1 = tmp
			tmp = enum2
			enum2 = enum1
			enum1 = tmp
		end
    else
		reply  = msg[2]	
    end		
end

equ = ""
if (reply ~= msg[3]) then
	result1 = ""
	rest = value1 - lib.math.round(value1)	  
	if (rest == 0) then
		result1 = "x" .. sign[4] .. " = " .. lib.check_number(value1, 20)			
	else
		denom1 = numb[1]
		if (denom1 < 0) then
			denom1 = - denom1 
			enum1 = - enum1
		end	
		q = lib.math.gcd(enum1,denom1)
		enum1 = enum1/q
		denom1 = denom1/q	
		condit1 = "is_ok = math.eq(numerator/denominator, "..tostring(value1)..");"	
		solut1 = "numerator="..tostring(enum1)..";denominator="..tostring(denom1)..";"
		result1 = "x" .. sign[4] .. " = " .. lib.check_fraction_condition(condit1, nil, nil, solut1)
	end 
	equ = result1	
	result2 = ""
	if (reply == msg[1]) then
		rest = value2 - lib.math.round(value2)	  
		if (rest == 0) then
			result2 = "x" .. sign[5] .. " = " .. lib.check_number(value2, 20)			
		else
			denom2 = numb[1]
			if (denom2 < 0) then
				denom2 = - denom2 
				enum2 = - enum2
			end	
			q = lib.math.gcd(enum2,denom2)
			enum2 = enum2/q
			denom2 = denom2/q	
			condit2 = "is_ok = math.eq(numerator/denominator, "..tostring(value2)..");"	
			solut2 = "numerator="..tostring(enum2)..";denominator="..tostring(denom2)..";"
			result2 = "x" .. sign[5] .. " = " .. lib.check_fraction_condition(condit2, nil, nil, solut2)
		end 
		equ = equ .. ", " .. result2
	end	
end	
            