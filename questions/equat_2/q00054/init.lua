
include("terms") 

elem = " ∈ "   
infty = {" ( -∞ , ", " , ∞ )"}
rel = {" < ", " > ", " ≤ ", " ≥ "}
brac = {"(", ")", "[", "]"}
space = " \(  \ \ \ \ \ \ \ \ \ \ \ \)"

numb = {}
broj = {}
imen = {}
val = {}

term = {""}
note = ""
bound = {""}
equ = {""}
op = {}

opqu = math.random(4)
if (opqu < 3) then
    opcont = 3 - opqu
else	
    opcont = 7 - opqu
end
for i = 1,3 do   
	op[i] = opqu
end	

ind = math.random(2)

max_range = 6

for j = 1,2 do
	numb[j] = {}
	fct = 1 + math.random(4)
	for i = 1,7 do
        min_range = 0	
	    if (ind == 1) then
     		if( i > 4) then
				min_range = 1
			else
				if (i > 1) then
					min_range = -1
				end	
			end
		else
		  	if( i == 4) then
				min_range = 1
			end			
        end 		
		numb[j][i] = min_range + math.random(max_range) 
        if (i < 5) then		
			sg = math.random(2)	
			if (sg == 2) then
				numb[j][i] = - numb[j][i]			
			end
		end
	end	
end	

if (ind == 2) then
	fct = 1 + math.random(4)
	note = msg[1] .. space .. space .. msg[2]
    numb[2][4] = fct * numb[1][4]   
    numb[2][7] = fct * numb[1][7] 
	for j = 1,2 do
		val[j] = -numb[j][2]/ numb[j][1]
	end
	if (val[2] == val[1]) then	
	    if (numb[2][2] < 0) then 
			numb[2][2] = numb[2][2] - math.random(3)
		else
			numb[2][2] = numb[2][2] + math.random(3)		
		end
	end
	for j = 1,2 do
		val[j] = -numb[j][2]/ numb[j][1]
		if (val[j] < 0) then
			broj[j] = -math.abs(numb[j][2])
		else
			broj[j] = math.abs(numb[j][2])	
		end		
		imen[j] = math.abs(numb[j][1])		
	end
	if (val[2] < val[1]) then
		tmp = val[1]
		val[1] = val[2]
		val[2] = tmp
		tmp = broj[1]
		broj[1] = broj[2]
		broj[2] = tmp
		tmp = imen[1]
		imen[1] = imen[2]
		imen[2] = tmp				
		inv = 1
	end
	if (val[1] == lib.math.round(val[1])) then	
		bound[1] = "x " .. elem .. lib.check_one_option_dropdown(infty, infty[1]) .. lib.check_number(lib.math.round(val[1]),20) .. brac[2] 
		bound[2] = "x " .. elem .. " " .. brac[1] .. lib.check_number(lib.math.round(val[1]),20) .. " , "			
	else
		bound[1] = "x " .. elem .. lib.check_one_option_dropdown(infty, infty[1]) .. lib.check_fraction_simple(broj[1], imen[1]) .. brac[2] 
		bound[2] = "x " .. elem .. " " .. brac[1] .. lib.check_fraction_simple(broj[1], imen[1]) .. " , "			
	end
	if (val[2] == lib.math.round(val[2])) then
		bound[2] = bound[2] .. lib.check_number(lib.math.round(val[2]),20) .. brac[2]  				
		bound[3] = "x " .. elem .. " " .. brac[1] .. lib.check_number(lib.math.round(val[2]),20) .. lib.check_one_option_dropdown(infty, infty[2])
	else	
		bound[2] = bound[2] .. lib.check_fraction_simple(broj[2], imen[2]) .. brac[2] 
		bound[3] = "x " .. elem .. " " .. brac[1] .. lib.check_fraction_simple(broj[2], imen[2]) .. lib.check_one_option_dropdown(infty, infty[2])			
	end	
	if (numb[1][1] * numb[2][1] > 0) then
		op[2] = opcont
	else
		op[1] = opcont
		op[3] = opcont			
	end	   		
end	
	
quest = ""
for j = 1,2 do
	term[j] = ""	
	if (math.abs(numb[j][1]) ~= 1) then
		term[j] = term[j] .. tostring(numb[j][1])
    else
        if (numb[j][1] == -1) then	
		    term[j] = term[j] .. "-"
		end
	end	
	term[j] = term[j] .. " x "	
	if (numb[j][2] ~= 0) then
	    if (numb[j][2] < 0) then
			sign = " - "
		else
			sign = " + "
        end
     	term[j] = term[j] .. sign .. tostring(math.abs(numb[j][2]))	
	end 
	if (ind == 1) then
		quest = quest .. lib.frac_start() .. term[j] .. lib.frac_mid() .. tostring(math.abs(numb[j][5])) .. lib.frac_end() 
		if (numb[j][4] ~= 0) then
			if (numb[j][4] < 0) then
				sign = " - "
			else
				sign = " + "
			end
			tmp = math.abs(numb[j][4]/numb[j][7])
			if (tmp == math.floor(tmp)) then
				quest = quest .. sign .. tostring(math.floor(tmp)) 
			else
				qq = lib.math.gcd(numb[j][4],numb[j][7])
				numb[j][4] = numb[j][4]/qq
				numb[j][7] = numb[j][7]/qq
				quest = quest .. sign .. lib.frac_start() .. tostring(math.floor(math.abs(numb[j][4]))) .. lib.frac_mid() .. tostring(math.floor(math.abs(numb[j][7]))) .. lib.frac_end() 
			end
		end
	else
		quest = quest .. lib.frac_start() .. tostring(math.abs(numb[j][5])) .. lib.frac_mid() .. term[j] .. lib.frac_end() 
		if (numb[j][4] ~= 0) then
			if (numb[j][4] < 0) then
				sign = " - "
			else
				sign = " + "
			end
			tmp = math.abs(numb[j][7]/numb[j][4])
			if (tmp == math.floor(tmp)) then
				quest = quest .. sign .. tostring(math.floor(tmp)) 
			else
				quest = quest .. sign .. lib.frac_start() .. tostring(math.floor(math.abs(numb[j][7]))) .. lib.frac_mid() .. tostring(math.floor(math.abs(numb[j][4]))) .. lib.frac_end() 
			end
		end		
	end
	if (j == 1) then
		quest = quest .. rel[opqu]
	end
end

if (ind == 1) then
	coef = numb[1][5] * numb[1][7] * numb[2][5] * numb[2][7]
	a = coef * (numb[1][1] / numb[1][5] - numb[2][1] / numb[2][5])
	b = coef * (numb[2][2] / numb[2][5] + numb[2][4] / numb[2][7] - numb[1][2] / numb[1][5] - numb[1][4] / numb[1][7])
else
	a = numb[2][1] * numb[1][5] - numb[1][1] * numb[2][5]
	b = numb[1][2] * numb[2][5] - numb[2][2] * numb[1][5] 
end
aa = lib.math.round(a)
bb = lib.math.round(b)
if (aa * bb ~= 0) then
	q = lib.math.gcd(aa,bb)
	aa = aa/q
	bb = bb/q
end	

if (aa < 0) then
	aa = - aa
	bb = - bb
	for i = 1,3 do
		if (op[i] == opqu) then
			op[i] = opcont
		else
			op[i] = opqu
		end
	end	
else
    if (aa == 0) then
	    bb = 1
	end
end

if (ind == 1) then
	equ[1] = lib.check_number(aa,30) .. " x " .. lib.check_one_option_dropdown(rel, rel[op[1]]) .. lib.check_number(bb,30)  
else
    for i = 1,3 do
		equ[i] = lib.check_number(aa,30) .. " x " .. lib.check_one_option_dropdown(rel, rel[op[i]]) .. lib.check_number(bb,30)  
    end
end	

--[[
n(j,1)=/=0,  n(j,2)}, n(j,3), n(j,4)   proizvoljan znak 
n(j,5), n(j,6)}, n(j,7)                 > 1

ind = 1
{n(1,1)x+n(1,2)}/n(1,5)+n(1,4)/n(1,7) = {n(2,1)x+n(2,2)}/n(2,5)+n(2,4)/n(2,7)                       


ind = 2
n(1,5)/{n(1,1)x+n(1,2)}+n(1,7)/n(1,4) = n(2,5)/{n(2,1)x+n(2,2))+n(2,7)/n(2,4) 

----------------------------------------------------------------------------------
              | (-infty, val[1])   |   (val[1],val[2])    |   (val[2],infty)
---------------------------------------------------------------------------------
numb[1][1]>0  |     -         opqu       +     opcont            +    opqu
numb[2][1]>0  |     -                    -                       +
----------------------------------------------------------------------------------
numb[1][1]>0  |     -         opcont     +     opqu              +    opcont
numb[2][1]<0  |     +                    +                       -
----------------------------------------------------------------------------------
numb[1][1]<0  |     +         opcont     -     opqu              -    opcont
numb[2][1]>0  |     -                    -                       +
----------------------------------------------------------------------------------
numb[1][1]<0  |     +         opqu       -     opcont            -    opqu
numb[2][1]<0  |     +                    +                       -
----------------------------------------------------------------------------------

n(j,3),{n(j,6)  slobodno
]]--
	
            