
coef = {}
imp = {""}
eq = {""}
numb = {}
fct = {}
arg = {"x", "y"}

separ = "- - - - - - - - - - - -"


xpoint = 8 - math.random(15)
ypoint = 5 - math.random(9)
max_range = 5
for i = 1,2 do
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

--[[faktori mnozenja]]--

for i = 1,2 do
	numb[i] = {}
    for j = 1,3 do
		numb[i][j] = coef[i][j]
	end
end

choice = max_range
for i = 1,2 do
    for j = 1,2 do
		if (choice > math.abs(coef[i][j])) then
			choice = math.abs(coef[i][j])
			chi = i
			chj = j
		end
	end
end	

if (choice ~= 0) then
    chi = 1
end	

if ((coef[1][1] == -coef[2][1]) or (coef[1][2] == -coef[2][2])) then
	if (coef[1][1] == -coef[2][1]) then
	    chj = 1
	else
		chj = 2
	end
else
	if (choice == 0) then
	    chj = 3 - chj
	else
		chj = 1
    end		
	q = lib.math.gcd(coef[1][chj],coef[2][chj])	
	fct[1] = coef[1][chj]/q
	fct[2] = coef[2][chj]/q	
	if (fct[2] < 0) then
	    fct[2] = - fct[2]
    else
        fct[1] = - fct[1]
    end		
	for i = 1,2 do
	    for j = 1,3 do 
			numb[i][j] = coef[i][j] * fct[3-i]
		end
	end
end	
par = 3 - chj

for i = 1,2 do	
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

argl = arg[chj]	
argr = arg[par]						
	
for i = 1,2 do
    eq[i] = ""
    if (numb[i][1] ~= 0) then
		eq[i] = lib.check_number(numb[i][1],20) .. lib.check_string(arg[1],15) 
		if (numb[i][2] ~= 0) then	
			if (numb[i][2] < 0) then
				eq[i] = eq[i] .. lib.check_string("-",10)
			else	
				eq[i] = eq[i] .. lib.check_string("+",10)	
			end
			eq[i] = eq[i] .. lib.check_number(math.abs(numb[i][2]),20) .. lib.check_string(arg[2],15) 
		end	
	else
		eq[i] = eq[i] .. lib.check_number(numb[i][2],20) .. lib.check_string(arg[2],15) 
	end
	eq[i] = eq[i]	.. " = " .. lib.check_number(numb[i][3],20)
end

for j = 1,3 do
	numb[3-chi][j] = numb[1][j] + numb[2][j]
end

eq[3] = ""
eq[4] = ""	
if (choice > 0) then
		eq[3] = lib.check_number(coef[1][1],20) .. lib.check_string(arg[1],15) 	
		if (coef[1][2] < 0) then
			eq[3] = eq[3] .. lib.check_string("-",10)
		else	
			eq[3] = eq[3] .. lib.check_string("+",10)	
		end
		eq[3] = eq[3] .. lib.check_number(math.abs(coef[1][2]),20) .. lib.check_string(arg[2],15) .. " = " .. lib.check_number(coef[1][3],20)
	if (numb[2][1] ~= 0) then
		eq[4] = lib.check_number(numb[2][1],20) .. lib.check_string(arg[1],15) 
		if (numb[2][2] ~= 0) then	
			if (numb[2][2] < 0) then
				eq[4] = eq[4] .. lib.check_string("-",10)
			else	
				eq[4] = eq[4] .. lib.check_string("+",10)	
			end
			eq[4] = eq[4] .. lib.check_number(math.abs(numb[2][2]),20)			
		end
	else
		eq[4] = eq[4] .. lib.check_number(numb[2][2],20)  	
	end	
	eq[4] = eq[4] .. lib.check_string(arg[2],15) .. " = " .. lib.check_number(numb[2][3],20)	
else
    lev0 = 3 - chi
    lev1 = 2 + chi
	lev2 = 2 + lev0	
	if (coef[chi][1] ~= 0) then
		eq[lev1] = lib.check_number(coef[chi][1],20) .. lib.check_string(arg[1],15) 
		if (coef[chi][2] ~= 0) then	
			if (coef[chi][2] < 0) then
				eq[lev1] = eq[lev1] .. lib.check_string("-",10)
			else	
				eq[lev1] = eq[lev1] .. lib.check_string("+",10)	
			end
			eq[lev1] = eq[lev1] .. lib.check_number(math.abs(coef[chi][2]),20) .. lib.check_string(arg[2],15)
        end
	else	
		eq[lev1] = eq[lev1] .. lib.check_number(coef[chi][2],20) .. lib.check_string(arg[2],15)	
	end		
	eq[lev1] = eq[lev1] 	.. " = " .. lib.check_number(coef[chi][3],20)		
	if (numb[lev0][1] ~= 0) then
		eq[lev2] = lib.check_number(numb[lev0][1],20) .. lib.check_string(arg[1],15) 	
		if (numb[lev0][2] ~= 0) then	
			if (numb[lev0][2] < 0) then
				eq[lev2] = eq[lev2] .. lib.check_string("-",10)
			else	
				eq[lev2] = eq[lev2] .. lib.check_string("+",10)	
			end
			eq[lev2] = eq[lev2] .. lib.check_number(math.abs(numb[lev0][2]),20) .. lib.check_string(arg[2],15) 
		end
	else
		eq[lev2] = eq[lev2] .. lib.check_number(numb[lev0][2],20) .. lib.check_string(arg[2],15)
	end		
	eq[lev2] = eq[lev2]	.. " = " .. lib.check_number(numb[lev0][3],20)
end
	
eq[5] = ""
if (choice ~= 0) then
	broj = coef[1][3] - coef[1][2]*ypoint
	eq[5] = lib.check_number(coef[1][1],20) .. lib.check_string(arg[1],15) .. " = "	.. lib.check_number(broj,20)
end	            
                     