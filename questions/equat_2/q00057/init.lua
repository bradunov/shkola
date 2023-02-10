
include("terms")

rel = {" < ", " > ", " ≤ ", " ≥ "}
dg2 = "²"

numb = {}
quest = {""}
value = {}
denom = {}
coef = {}

opqu = math.random(4)
if (opqu < 3) then
    opcont = 3 - opqu
else	
    opcont = 7 - opqu
end 
op = opqu

max_range = 5
choice = math.random(2)
ind = math.random(3)

for j = 1,2 do
	numb[j] = {}
	for i = 1,11 do
        min_range = 0	
		if (i < 3) then
			min_range = 1
		end
		if (i > 7) then
			min_range = 1
		end		
		numb[j][i] = min_range + math.random(max_range - min_range) 
        if (i < 8) then		
			sg = math.random(2)	
			if (sg == 2) then
				numb[j][i] = - numb[j][i]			
			end
		end
	end	
end	
if (choice == 2) then
	fct = math.random(4)
	if (ind == 1) then
		numb[2][8] = numb[1][8]
		numb[2][2] = fct * numb[1][2]
		numb[1][1] = fct * fct * numb[2][1]
	end	
	if (ind == 2) then
		numb[2][2] = numb[1][2]
		numb[2][1] = fct * numb[1][1]
		numb[2][8] = fct * numb[1][8]
	end	
	if (ind == 3) then
		numb[2][1] = numb[1][1]
		numb[2][2] = fct * numb[1][2]
		numb[2][8] = fct * fct * numb[1][8]
	end	
end

for j = 1,2 do
	quest[j] = ""
	if (choice == 2) then
		term = ""		
		if (math.abs(numb[j][2]) ~= 1) then
			term = term .. tostring(numb[j][2])
		else
			if (numb[j][2] == -1) then	
				term = term .. "-"
			end
		end		
		term = term .. " x "			
		if (numb[j][3] ~= 0) then
			if (numb[j][3] < 0) then
				sg = " - "
			else
				sg = " + "
			end
			term = term .. sg .. tostring(math.abs(numb[j][3]))	
		end 
		term = "( " .. term .. " )" .. dg2
		if (math.abs(numb[j][1]) ~= 1) then
			term = tostring(numb[j][1]) .. " " .. term
		else
			if (numb[j][1] == -1) then	
				term = "-" .. term
			end
		end		
		quest[j] = quest[j] .. lib.frac_start() .. term .. lib.frac_mid() .. tostring(numb[j][8]) .. lib.frac_end()  .. " + "
	end
	
--[[ linearni deo]]--	
	term = ""
	if (numb[j][4] ~= 0) then
		if (math.abs(numb[j][4]) ~= 1) then
			term = term .. tostring(numb[j][4])
		else
			if (numb[j][4] == -1) then	
				term = term .. "-"
			end
		end			
		term = term .. " x "
    end		
	if (numb[j][5] ~= 0) then
		if (numb[j][5] < 0) then
			sg = " - "
		else
			if (numb[j][4] ~= 0) then
				sg = " + "
			end
		end
		term = term .. sg .. tostring(math.abs(numb[j][5]))			
	end	
	if (numb[j][4] ~= 0 or numb[j][5] ~= 0) then	
		quest[j] = quest[j] .. lib.frac_start() .. term .. lib.frac_mid() .. tostring(numb[j][9]) .. lib.frac_end() 				
	end
	
	term = ""			
	if (numb[j][6] ~= 0) then	
	    if (numb[j][6] < 0) then
		    sg = " - "
		else
		    sg = " + "
		end	
		quest[j] = quest[j] .. sg  
		if (math.abs(numb[j][6]) ~= 1) then
			term = term .. tostring(math.abs(numb[j][6]))
		end			
		term = term .. " x "		
		quest[j] = quest[j] .. lib.frac_start() .. term .. lib.frac_mid() .. tostring(math.floor(numb[j][10])) .. lib.frac_end() 		
    end		

	if (numb[j][7] ~= 0) then
		if (numb[j][7] < 0) then
			sg = " - "
		else
			sg = " + "
		end
		tmp = math.abs(numb[j][7]/numb[j][11])
		if (tmp == math.floor(tmp)) then
			quest[j] = quest[j] .. sg .. tostring(math.floor(tmp)) 
		else
			quest[j] = quest[j] .. sg .. lib.frac_start() .. tostring(math.floor(math.abs(numb[j][7]))) .. lib.frac_mid() .. tostring(math.floor(numb[j][11])) .. lib.frac_end() 
		end
	end	
end

if (choice == 1) then
    quest[1] = quest[1] .. rel[opqu] .. quest[2]
	quest[2] = ""
	for j = 1,2 do
	    for i = 1,3 do
			numb[j][i] = 0
        end
		numb[j][8] = 1
    end		
else
    quest[1] = quest[1] .. rel[opqu]
end	

equ = ""
for j = 1,2 do
	denom[j] = 1
	for i = 8, 11 do
		denom[j] = denom[j] * numb[j][i] 
	end	
end	
for j = 1,2 do
	value[j] = {}
	value[j][1] = numb[j][1] * numb[j][2] * numb[j][2] * (denom[j]/numb[j][8])
	value[j][2] = 2 * numb[j][1] * numb[j][2] * numb[j][3] * (denom[j]/numb[j][8]) + numb[j][4] * (denom[j]/numb[j][9]) + numb[j][6] * (denom[j]/numb[j][10])
	value[j][3] = numb[j][1] * numb[j][3] * numb[j][3] * (denom[j]/numb[j][8]) + numb[j][5] * (denom[j]/numb[j][9]) + numb[j][7] * (denom[j]/numb[j][11])	
end	
for i = 1,3 do
	coef[i] =  lib.math.round(value[1][i] * denom[2] - value[2][i] * denom[1]) 
end

aa = lib.math.round(coef[2])
bb = lib.math.round(coef[3])
if (aa < 0) then
	aa = - aa
	bb = - bb
	op = opcont
end

equ = ""
reply = ""
if (aa ~= 0) then
	q = lib.math.gcd(aa,bb)
	aa = aa/q
	bb = bb/q 
	val = -bb/aa	
	reply  = msg[1]		
	equ = " x " .. lib.check_one_option_dropdown(rel, rel[op])	
	rest = val - lib.math.round(val)	  
	if (rest == 0) then
		equ = equ .. lib.check_number(val, 20)			
	else		
		condit = "is_ok = math.eq(numerator/denominator, "..tostring(val)..");"	
		solut = "numerator="..tostring(-bb)..";denominator="..tostring(aa)..";"
		equ = equ .. lib.check_fraction_condition(condit, nil, nil, solut)
	end 
else
    if (bb == 0) then 	
	    if (op > 2) then
			reply = msg[3]
		else
			reply = msg[2]
        end			
    else		
		if (op == 1 or op == 3) then
			if (bb > 0) then 
				reply = msg[3]
			else				
				reply = msg[2]	
			end	
		else
			if (bb > 0) then 
				reply = msg[2]
			else				
				reply = msg[3]	
			end			
        end			
	end
	equ = lib.check_number(0,20) .. " x " .. lib.check_one_option_dropdown(rel, rel[op])  .. lib.check_number(bb,20)	
end	      
            

--[[
n(j,1)=/=0,  n(j,2)}, n(j,3), n(j,4)   proizvoljan znak 
n(j,5), n(j,6)}, n(j,7)                 > 1

##  ind = 1  
{n(1,4)x+n(1,5)}/n(1,9)+n(1,6)x/n(1,10)+n(1,7)/n(1,11) =                   LIN[1]
		{n(2,4)x+n(2,5)}/n(2,9)+n(2,6)x/n(2,10)+n(2,7)/n(2,11)             LIN[2]        


##  ind = 2   sa kvadratnim clanom (svodi se na linearnu)
n(1,1)*[n(1,2)x+n(1,3)]^2/n(1,8) + LIN[1] = n(2,1)*[n(2,2)x+n(2,3)]^2/n(2,8) + LIN[2]      


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

]]--
	        