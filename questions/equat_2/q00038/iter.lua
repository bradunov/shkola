
include("terms") 

cond = " , x ≠ "
numb = {}
term = {""}
note = " "

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
    numb[2][4] = fct * numb[1][4]   
    numb[2][7] = fct * numb[1][7] 
	tmp1 = -numb[1][2]/ numb[1][1]	
	tmp2 = -numb[2][2]/ numb[2][1]	
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
			op = " - "
		else
			op = " + "
        end
     	term[j] = term[j] .. op .. tostring(math.abs(numb[j][2]))	
	end 
	if (ind == 1) then
		quest = quest .. lib.frac_start() .. term[j] .. lib.frac_mid() .. tostring(math.abs(numb[j][5])) .. lib.frac_end() 
		if (numb[j][4] ~= 0) then
			if (numb[j][4] < 0) then
				op = " - "
			else
				op = " + "
			end
			tmp = math.abs(numb[j][4]/numb[j][7])
			if (tmp == math.floor(tmp)) then
				quest = quest .. op .. tostring(math.floor(tmp)) 
			else
				qq = lib.math.gcd(numb[j][4],numb[j][7])
				numb[j][4] = numb[j][4]/qq
				numb[j][7] = numb[j][7]/qq
				quest = quest .. op .. lib.frac_start() .. tostring(math.floor(math.abs(numb[j][4]))) .. lib.frac_mid() .. tostring(math.floor(math.abs(numb[j][7]))) .. lib.frac_end() 
			end
		end
	else
		quest = quest .. lib.frac_start() .. tostring(math.abs(numb[j][5])) .. lib.frac_mid() .. term[j] .. lib.frac_end() 
		if (numb[j][4] ~= 0) then
			if (numb[j][4] < 0) then
				op = " - "
			else
				op = " + "
			end
			tmp = math.abs(numb[j][7]/numb[j][4])
			if (tmp == math.floor(tmp)) then
				quest = quest .. op .. tostring(math.floor(tmp)) 
			else
				quest = quest .. op .. lib.frac_start() .. tostring(math.floor(math.abs(numb[j][7]))) .. lib.frac_mid() .. tostring(math.floor(math.abs(numb[j][4]))) .. lib.frac_end() 
			end
		end		
	end
	if (j == 1) then
		quest = quest .. " = "
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
if (aa < 0) then
	aa = - aa
	bb = - bb
end

equ = ""
reply = ""
if (aa * bb ~= 0) then
	q = lib.math.gcd(aa,bb)
	aa = aa/q
	bb = bb/q 
	value = bb/aa	
	if (ind == 2 and (value == tmp1 or value == tmp2)) then
		reply = msg[2]
	else
		reply  = msg[1]				
		rest = value - lib.math.round(value)	  
		if (rest == 0) then
			equ = lib.check_number(value, 20)			
		else		
			condit = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"	
			solut = "numerator="..tostring(bb)..";denominator="..tostring(aa)..";"
			equ = lib.check_fraction_condition(condit, nil, nil, solut)
		end 
	end
else
    if (aa == 0 and bb == 0) then 
	    reply = msg[3]
		if (ind == 2 ) then
			note = cond
			if (tmp1 == lib.math.round(tmp1)) then
				note = note .. lib.check_number(lib.math.round(tmp1),20)
			else
				q = lib.math.gcd(numb[1][2],numb[1][1])
				broj = numb[1][2]/q
				imen = numb[1][1]/q
				if (tmp1 < 0) then
					broj = -math.abs(broj)
				else
					broj = math.abs(broj)	
				end	
				imen = math.abs(imen)
				note = note .. lib.check_fraction_simple(broj, imen) 	
			end		
		end		
	else
		if (aa ~= 0) then
			reply = msg[1] 		
			equ = equ .. lib.check_number(0,20)
		else
			reply = msg[2] 
		end
	end
end	  
