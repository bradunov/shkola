
include("terms")

numb = {}
fct = {}
op = {}
free = {}
coef = {}
broj = {}
imen = {}

eq = {""}
arg = {"a", "b"}
ans = ""
sum = {""}
pro = {""}

space = "\( \ \ \ \ \) "
separ = "- - - - - - - - - - - -"

ind = math.random(3)
sing = 1
max_range = 8
fct[1] = 1 + math.random(max_range-3)
fct[2] = 3 + math.random(max_range)

for i = 1,3 do
    numb[i] = {}
end	
if (ind == 3) then                    --[[ a/b ]]--
	for j = 2,3 do 
		numb[1][j] = max_range - math.random(2*max_range)
		if (numb[1][j] == 0) then
			numb[1][j] = math.random(max_range)	
		end
	end
	numb[1][1] = numb[1][2] * numb[1][3]
else	                                  --[[ a +/- b ]]--
	for j = 1,2 do		
		numb[1][j] = max_range - math.random(2*max_range)
	end
    if (ind == 1) then
		numb[1][3] = numb[1][1] + numb[1][2]	   
    else
		numb[1][3] = numb[1][1] - numb[1][2]	
    end
end	

eq[1] = ""
if (ind < 3) then
	eq[1] = lib.check_string(arg[1], 15)
    if (ind == 1) then
	    sg = "+"
    else
	    sg = "-"	
    end		
	eq[1] = eq[1] .. " " .. lib.check_string(sg, 10) .. " " .. lib.check_string(arg[2], 15) .. " = " .. lib.check_number(numb[1][3],20)
else
	eq[1] = lib.frac_start() .. lib.check_string(arg[1], 15) .. lib.frac_mid() .. lib.check_string(arg[2],20) .. lib.frac_end() ..	" = " .. lib.check_number(numb[1][3],20) 
end

eq[2] = ""
newn3 = ""
for j = 1,2 do	
	term = "( "
	broj[j] = 1
	imen[j] = 1		
    free[j] = 0
	op[j] = math.random(2)
	act = math.random(2)
	if (act == 1) then
		sum[j] = activ[1]
	    pro[j] = ""	
	else
		sum[j] = ""
	    pro[j] = activ[2]
    end		
	if (op[j] == 1) then
	    if (act == 1) then
			numb[2][j] = numb[1][j] + fct[j]
			term = term .. lib.check_string(arg[j], 15)	.. lib.check_string("+", 10) .. lib.check_number(fct[j], 20)  	
			free[j] = free[j] + fct[j]			
		else
			numb[2][j] = numb[1][j] * fct[j]	
			term = term .. lib.check_number(fct[j], 20) .. lib.check_string(arg[j], 15)	 
            broj[j] = fct[j]			
		end
    else		
	    if (act == 1) then
			numb[2][j] = numb[1][j] - fct[j]
			term = term .. lib.check_string(arg[j], 15)	.. lib.check_string("-", 10) .. lib.check_number(fct[j], 20)  
			free[j] = free[j] - fct[j]			
		else
			numb[2][j] = numb[1][j] / fct[j]  	
			term = term .. lib.frac_start() .. lib.check_string(arg[j], 15) .. lib.frac_mid() .. lib.check_number(fct[j], 20) .. lib.frac_end()	
            imen[j] = fct[j]			
		end
	end	
	term = term .. " )"
	if (j == 1) then
        if (ind == 3) then
		    eq[2] = term .. " / " 
		else
			if (ind == 1) then
				sg = "+"
			else
				sg = "-"	
			end	
			eq[2] = term .. lib.check_string(sg, 10)
		end
	else
--[[ singularnost sistema]]--	
		if (ind < 3) then 
			if (free[1] * free[2] ~= 0) then
				sing = 3
			end
		else
			if (free[1] == 0 and free[2] == 0) then
				sing = 3
			end	
		end	
		if (ind == 3) then
			numb[2][3] = numb[2][1] / numb[2][2]
			broj[3] = (numb[1][1] * broj[1] + free[1] * imen[1]) * imen[2]
			imen[3] = (numb[1][2] * broj[2] + free[2] * imen[2]) * imen[1]									
			q = lib.math.gcd(broj[3], imen[3])
			broj[3] = lib.math.round(broj[3] / q)
			imen[3] = lib.math.round(imen[3] / q)
			rest = numb[2][3] - lib.math.round(broj[3] / imen[3])
		else	
		    if (ind == 1) then 
				free[3] = free[1] + free[2]
            else
				free[3] = free[1] - free[2]	
            end				
		    if (imen[1] ~= 1 or imen[2] ~= 1) then
				imen[3] = imen[1] * imen[2]				
				if (ind == 1) then
				    broj[3] = numb[1][1] * broj[1] * imen[2] + numb[1][2] * broj[2] * imen[1] + free[3] * imen[3]
					numb[2][3] = numb[2][1] + numb[2][2]             					
				else
				    broj[3] = numb[1][1] * broj[1] * imen[2] - numb[1][2] * broj[2] * imen[1] + free[3] * imen[3]			
					numb[2][3] = numb[2][1] - numb[2][2]			
				end
				q = lib.math.gcd(broj[3], imen[3])
				broj[3] = lib.math.round(broj[3] / q)
				imen[3] = lib.math.round(imen[3] / q)				
				rest = numb[2][3] - lib.math.round(broj[3] / imen[3])
			else			
				if (ind == 1) then
					numb[2][3] = numb[2][1] + numb[2][2]						
				else
					numb[2][3] = numb[2][1] - numb[2][2]				
				end
				broj[3] = numb[2][3]
				imen[3] = 1									
				rest = 0
			end
		end	
		eq[2] = eq[2] .. term .. " = "
		if (sing == 3) then
		    mod = 3 - math.random(5)
			if (mod ~= 0) then
				sing = 2
			    broj[3] = broj[3] + mod
				numb[2][3] = broj[3] / imen[3]
				q = lib.math.gcd(broj[3], imen[3])
				broj[3] = lib.math.round(broj[3] / q)
				imen[3] = lib.math.round(imen[3] / q)				
				rest = numb[2][3] - lib.math.round(broj[3] / imen[3])				
			end
        end		
		if (rest == 0) then
			eq[2] = eq[2] .. lib.check_number(numb[2][3],20)
			newn3 = tostring(lib.math.round(numb[2][3]))
		else	
            if (imen[3] < 0) then
                broj[3] = - broj[3]
                imen[3] = - imen[3]
            end				
			eq[2] = eq[2] .. lib.check_fraction_simple(broj[3],imen[3])
			newn3 = "\(\frac{" .. broj[3] .. "}{" .. imen[3] .. "}\)"			
        end				
    end		
end

eq[3] = lib.check_string(arg[1], 15)
if (ind < 3) then	
    if (ind == 1) then
	    sg = "+"
    else
	    sg = "-"	
    end		
	eq[3] = eq[3] .. " " .. lib.check_string(sg, 10) .. " " .. lib.check_string(arg[2], 15) .. " = " .. lib.check_number(numb[1][3],20)
else
    if (numb[1][3] < 0) then
	    sg = "+"
    else
	    sg = "-"	
    end			   
	eq[3] = eq[3] .. " " .. lib.check_string(sg, 10) .. " " .. lib.check_number(math.abs(numb[1][3]),20) .. lib.check_string(arg[2], 15) .. " = " .. lib.check_number(0,20)
end

eq[4] = ""
if (ind == 3) then
	broj[2] = broj[2] * broj[3]
	imen[2] = imen[2] * imen[3]
	brojilac = broj[3] * free[2] - imen[3] * free[1]
else
	brojilac = broj[3] - free[3] * imen[3]
end	
tmp = imen[1] * imen[2] * imen[3]
for j = 1,2 do
    coef[j] = tmp * broj[j] / imen[j]
end	
coef[3] = tmp * brojilac / imen[3]
q = lib.math.gcd(coef[1], coef[2])
for j = 1,3 do
	coef[j] = lib.math.round(coef[j] / q)
end
if (ind < 3) then	
    if (ind == 1) then
	    sg = "+"
    else
	    sg = "-"	
    end		
else	
    if (coef[2] < 0) then
	    sg = "+"
		coef[2] = math.abs(coef[2])
    else
	    sg = "-"	
    end			   
end
for j = 1,2 do
	eq[4] = eq[4] .. lib.check_number(coef[j],20) .. lib.check_string(arg[j], 15)	
	if (j == 1) then
		eq[4] = eq[4] .. lib.check_string(sg, 10) 
	else 
		eq[4] = eq[4] .. " = "	
	end
end	      
eq[4] = eq[4] .. lib.check_number(coef[3],30)

if (sing == 1) then
	ans = "a = " .. lib.check_number(numb[1][1],20) .. "," .. space .. "b = " .. lib.check_number(numb[1][2],20)
else
    ans = ""
end



	
--[[
x +/- y = C1     (x +/- fct1) +/- (y +/- fct2) = C2  (odredjen fct1=/=fct2; neodredjen fct1=fct2, C2=fct1*C1; nemoguc  C2=/=fct1*C1)
x/y = C1 (x - C1y = 0)   [(fct1*x / x+fct1)] / [(fct2*y /y+fct2)] = C2
]]--