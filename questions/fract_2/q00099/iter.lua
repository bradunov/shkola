
broj = {}
imen = {}
value = {}
meas = {""}
quest = {""}
out = {}

ch = math.random(3)
meas[1] = measure[2*ch - 1]
meas[2] = measure[2*ch] 
if (ch == 1) then
    fct = 1000
else
	if (ch == 2) then
		fct = 100
	else
		fct = 10
    end
end	

out = lib.math.random_shuffle(denom)
for i = 1,2 do
    broj[i] = math.random(15)
	imen[i] = out[i]
	value[i] = broj[i] / imen[i]
	imen[i+2] = out[i+2]
	broj[i+2] = math.ceil(value[i]) * imen[i+2] - 2+ math.random(3)
	if (broj[i+2] == imen[i+2]) then
		broj[i+2] = broj[i+2] + 1
    end		
	value[i+2] = broj[i+2] / imen[i+2]	
end	
for i = 1,2 do
    i1 = 2*i-1
	i2 = 2*i
	if (value[i1] < value[i2]) then
		tmp = value[i2]
		value[i2] = value[i1]
		value[i1] = tmp
		tmp = broj[i2]
		broj[i2] = broj[i1]
		broj[i1] = tmp
		tmp = imen[i2]
		imen[i2] = imen[i1]
		imen[i1] = tmp
	end
end	

sg = math.random(4)
for i = 1,4 do 
	if (sg < 3) then
	    valueleft = value[1] + value[2]
	else
	    valueleft = value[1] - value[2]
    end		
	if (sg == 2*math.floor(sg/2)) then
		valueright = value[3] - value[4]
	else
		valueright = value[3] + value[4]		
	end	
end	
if (valueleft == valueright) then
   sign = "="
else
	if (valueleft > valueright) then
	  sign = ">"
	else
	  sign = "<"
	end
end	

for j = 1,2 do 
	quest[j] = ""
	for i = 1,2 do
		i1 = 2*(j-1) + i
		ind = math.random(3)	
		if (ind == 3) then
			quest[j] =  quest[j] .. "\(\frac{" .. math.floor(broj[i1]) .. "}{" .. math.floor(imen[i1]) .. "}\) " .. " " .. meas[2]
		else
			if (ind == 1) then
				quest[j] = quest[j] .. lib.dec_to_str(lib.math.round_dec(value[i1],2)) .. " " .. meas[2] 
			else	   
				quest[j] = quest[j] .. lib.dec_to_str(lib.math.round_dec(value[i1]*fct,2)) .. " " .. meas[1] 
			end		
		end
		if (i == 1) then
			if (j == 1) then
				if (sg < 3) then
					quest[j] = quest[j] .. " + "
				else
					quest[j] = quest[j] .. " - "
				end
			else
				if (sg == 2*math.floor(sg/2)) then
					quest[j] = quest[j] .. " - "
				else
					quest[j] = quest[j] .. " + "	
				end
			end
		end
	end
end
	


