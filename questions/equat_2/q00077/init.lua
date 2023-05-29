
coef = {}
imp = {""}
eq = {""}

separ = "- - - - - - - - - - - -"

numb = 2
xpoint = 8 - math.random(15)
ypoint = 5 - math.random(9)
max_range = 5
for i = 1,numb do
	coef[i] = {}
	for j = 1,2 do	
		coef[i][j] = max_range - math.random(2*max_range) 
	end
    if (coef[i][1] == 0 and coef[i][2] == 0) then
		coef[i][1] = math.random(max_range)	
    end		
	if (i == 2) then
	    if (coef[1][1]*coef[2][2]*coef[1][2]*coef[2][1] == 0) then
			if (coef[1][1] == 0 and coef[2][1] == 0) then
				coef[2][1] = math.random(max_range)	
			end	
			if (coef[1][2] == 0 and coef[2][2] == 0) then
				coef[2][2] = - math.random(max_range)	
			end				
        else			
			if (coef[1][1]*coef[2][2] == coef[1][2]*coef[2][1]) then
				coef[2][1] = coef[1][1] + math.random(max_range-1) + 1
				if (coef[2][1] == 0) then
					coef[2][1] = coef[1][1] + 1
				end 
			end
		end
    end	
	coef[i][3] = coef[i][1] * xpoint + coef[i][2] * ypoint	
end	

--[[lociranje minimalnog koeficijenta]]--

choice = max_range
chi = 1
chj = 1
for i = 1,2 do
    for j = 1,2 do
		if (choice > math.abs(coef[i][j])) then
			choice = math.abs(coef[i][j])
			chi = i
			chj = j
		end
	end
end	
par = 3 - chj

if (chi ~= 1) then
    chi = 1
	for j = 1,3 do
		tmp = coef[1][j]
		coef[1][j] = coef[2][j]
		coef[2][j] = tmp
	end
end	
if (coef[2][par] == 0 and choice == 0) then
    chi = 0
end	

for i = 1,numb do	
  	imp[i] = ""
	if (coef[i][1] ~= 0) then	
		if (math.abs(coef[i][1]) ~= 1) then
			imp[i] = imp[i] .. tostring(coef[i][1]) 
		else
            if (coef[i][1] == -1) then	
				imp[i] = imp[i] .. "-"	
            end				
		end		
		imp[i] = imp[i] .. "x"	
	end
	if (coef[i][2] ~= 0) then	
		if (coef[i][1] ~= 0) then	
			if (coef[i][2] < 0) then
				imp[i] = imp[i] .. " - "
			else	
				imp[i] = imp[i] .. " + "	
			end
			if (math.abs(coef[i][2]) ~= 1) then
				imp[i] = imp[i] .. tostring(math.abs(coef[i][2])) 
			end	
		else
			if (math.abs(coef[i][2]) ~= 1) then		
				imp[i] = imp[i] .. tostring(coef[i][2]) 
			else
				if (coef[i][2] == -1) then
					imp[i] = imp[i] .. "-"
                end					
            end				
		end	
		imp[i] = imp[i] .. "y "		
	end
	imp[i] = imp[i] .. " = " .. tostring(coef[i][3])		
end	          

if (chj == 1) then
	argl = "x"	
	argr = "y"						
else
	argl = "y"	
	argr = "x"										
end	
if (choice ~= 0) then	
	eq[1] = lib.check_string(argl,15) .. " = "	
	if (chj == 1) then
		eq[2] = lib.check_number(coef[2][chj],20)
	else
		eq[2] = lib.check_number(math.abs(coef[2][chj]),20) 
	end	
	eq[2] = eq[2] .. " ("	
	tmp = -coef[1][par]/coef[1][chj]	
	if (tmp == lib.math.round(tmp)) then	
		eq[1] = eq[1] .. lib.check_number(tmp,20)		
		eq[2] = eq[2] .. lib.check_number(tmp,20)		
	else
		if (coef[1][chj] > 0) then
			broj = -coef[1][par]
			imen = coef[1][chj]
		else
			broj = coef[1][par]
			imen = -coef[1][chj]
		end			
		eq[1] = eq[1] .. lib.check_fraction_simple(broj,imen)		
		eq[2] = eq[2] .. lib.check_fraction_simple(broj,imen)		
	end
	eq[1] = eq[1] .. lib.check_string(argr,15)	
	eq[2] = eq[2] .. lib.check_string(argr,15)	
	free = coef[1][3]/coef[1][chj]
	if (free ~= 0) then
		if (free < 0) then
			sg = "-"
		else					    
			sg = "+"
		end
		eq[1] = eq[1] .. lib.check_string(sg,10)
		eq[2] = eq[2] .. lib.check_string(sg,10)		
		if (free == lib.math.round(free)) then	
			eq[1] = eq[1] .. lib.check_number(math.abs(free),20)
			eq[2] = eq[2] .. lib.check_number(math.abs(free),20)
		else
			eq[1] = eq[1] .. lib.check_fraction_simple(math.abs(coef[1][3]),math.abs(coef[1][chj]))	
			eq[2] = eq[2] .. lib.check_fraction_simple(math.abs(coef[1][3]),math.abs(coef[1][chj]))				
		end					
	end		
	if (chj == 1) then
		if (coef[2][par] < 0) then
			znak = "-"
		else					    
			znak = "+"
		end
		eq[2] = eq[2] .. ") " .. lib.check_string(znak,10) .. lib.check_number(math.abs(coef[2][par]),20) .. lib.check_string(argr,15) 	
	else
		if (coef[2][chj] < 0) then
			znak = "-"
		else					    
			znak = "+"
		end
		eq[2] = lib.check_number(coef[2][par],20) .. lib.check_string(argr,15) .. lib.check_string(znak,10) .. eq[2] .. ")" 			
	end	
	eq[2] = eq[2] .. " = " .. lib.check_number(coef[2][3],20)		
else
	if (chi ~= 0) then
		eq[1] = lib.check_string(argr,15) .. " = "	
		if (chj == 2) then
			eq[2] = lib.check_number(coef[2][par],20)
		else
			eq[2] = lib.check_number(math.abs(coef[2][par]),20) 
		end	
		eq[2] = eq[2] .. " ("		
		free = coef[1][3]/coef[1][par]	
		if (free == lib.math.round(free)) then	
			eq[1] = eq[1] .. lib.check_number(free,20)
			eq[2] = eq[2] .. lib.check_number(free,20)		
		else
			eq[1] = eq[1] .. lib.check_fraction_simple(coef[1][3],coef[1][chj])	
			eq[2] = eq[2] .. lib.check_fraction_simple(coef[1][3],coef[1][chj])  
		end	
	
		if (chj == 1) then
			if (coef[2][par] < 0) then
				znak = "-"
			else					    
				znak = "+"
			end
			eq[2] = lib.check_number(coef[2][chj],20) .. lib.check_string(argl,15) .. lib.check_string(znak,10) .. eq[2] .. ")" 			
		else
			if (coef[2][chj] < 0) then
				znak = "-"
			else					    
				znak = "+"
			end
			eq[2] = eq[2] .. ") " .. lib.check_string(znak,10) .. lib.check_number(math.abs(coef[2][chj]),20) .. lib.check_string(argl,15) 	
		end
		eq[2] = eq[2] .. " = " .. lib.check_number(coef[2][3],20)	
	else
		eq[1] = lib.check_string(argr,15) .. " = "	
		tmp = coef[1][3]/coef[1][par]
		if (tmp == lib.math.round(tmp)) then	
			eq[1] = eq[1] .. lib.check_number(tmp,20)
		else
			eq[1] = eq[1] .. lib.check_fraction_simple(coef[1][3],coef[1][par])	
		end			
		eq[2] = lib.check_string(argl,15) .. " = "
		free = coef[2][3]/coef[2][chj]		
		if (free == lib.math.round(free)) then	
			eq[2] = eq[2] .. lib.check_number(free,20)
		else
			eq[2] = eq[2] .. lib.check_fraction_simple(coef[2][3],coef[2][chj])	
		end	
	end		
end

if (chi ~= 0) then
	if (choice == 0) then
		eq[3] = argl .. " = "
		broj = coef[2][3]*coef[1][par] - coef[2][par]*coef[1][3]
		imen = coef[2][chj]*coef[1][par]
	else	
		eq[3] = argr .. " = "		
		broj = coef[2][3]*coef[1][chj] - coef[2][chj]*coef[1][3]
		imen = coef[2][par]*coef[1][chj] - coef[2][chj]*coef[1][par]
	end
	qq = lib.math.gcd(broj,imen)
	broj = broj/qq
	imen = imen/qq
	if (imen < 0) then
		broj = - broj
		imen = - imen
	end
	if (imen == 1) then
		eq[3] = eq[3] .. lib.check_number(broj,20)
	else
		eq[3] = eq[3] .. lib.check_fraction_simple(broj,imen) 
	end
end	