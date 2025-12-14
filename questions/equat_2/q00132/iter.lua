
term = {""}
coef = {}
sg = {}

minb = -7
maxb = 13
for i = 1,6 do
 	coef[i] = minb + math.random(maxb) 
end
for i = 1,3 do
	if (coef[2*i-1] == 0 and coef[2*i] == 0) then
		coef[2*i-1] = - math.random(5)
	end
end	
for i = 1,2 do
	sg[i] = math.random(2)
end

coef[7] = coef[1]
coef[8] = coef[2]
term[1] = ""
if ( coef[1] ~= 0) then
    if (coef[1] == -1) then
	    term[1] = "-"  
	else
		if (coef[1] ~= 1) then	
			term[1] = coef[1]
		end
	end
	term[1] = term[1] .. "a" 
end
if (coef[2] ~= 0) then
    if (math.abs(coef[2]) == 1) then
		if (coef[2] == -1) then
			term[1] = term[1] .. " - 1 " 
		else
			term[1] = term[1] .. " + 1 " 	
		end	
	else
		if (coef[2] < 0) then	
			term[1] = term[1] .. " - " 	
		else
			term[1] = term[1] .. " + " 				
		end
		term[1] = term[1] .. math.abs(coef[2])
	end
end
if (coef[1] * coef[2] ~= 0) then
	term[1] = "(" .. term[1] .. ")"
end	

	
for i = 2,3 do
    if (sg[i-1] == 1) then
		coef[7] = coef[7] + coef[2*i-1]
		coef[8] = coef[8] + coef[2*i]
	else
		coef[7] = coef[7] - coef[2*i-1]
		coef[8] = coef[8] - coef[2*i]
	end
	term[i] = ""
	if ( coef[2*i-1] ~= 0) then
		if (coef[2*i-1] == -1) then
			term[i] = "-"  
		else
			if (coef[2*i-1] ~= 1) then	
				term[i] = coef[2*i-1]
			end
		end
		term[i] = term[i] .. "a" 
	end
	if (coef[2*i] ~= 0) then
		if (math.abs(coef[2*i]) == 1) then
			if (coef[2*i] == -1) then
				term[i] = term[i] .. " - 1 " 
			else
				term[i] = term[i] .. " + 1 " 	
			end	
		else
			if (coef[2*i] < 0) then	
				term[i] = term[i] .. " - " 	
			else
				term[i] = term[i] .. " + " 				
			end
			term[i] = term[i] .. math.abs(coef[2*i])
		end
	end
end	

quest = term[1]
for i = 2,3 do    
	if (sg[i-1] == 1) then
		quest = quest .. " + (" 
	else
		quest = quest .. " - (" 
	end
	quest = quest .. term[i] ..")"
end
answ = lib.check_number(coef[7],20) .. "a + (" .. lib.check_number(coef[8],20) .. ")"
       