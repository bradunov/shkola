
include("terms") 

numb = {}

term = {""}
ans = {""}
opp = {""}
cl = {}
cr = {}

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

note = ""
remark = ""
if (ind == 2) then
	fct = 1 + math.random(4)
    numb[2][4] = fct * numb[1][4]   
    numb[2][7] = fct * numb[1][7] 
	tmp1 = -numb[1][2]/ numb[1][1]
	note = msg[1]
	remark = msg[2]	
	if (tmp1 == lib.math.round(tmp1)) then
		note = note .. lib.check_number(lib.math.round(tmp1),20)  .. " , "
		remark = remark .. lib.check_number(lib.math.round(tmp1),20)  .. " , "		
    else
		if (tmp1 < 0) then
			broj1 = -math.abs(numb[1][2])
		else
			broj1 = math.abs(numb[1][2])	
		end		
		note = note .. lib.check_fraction_simple(broj1, math.abs(numb[1][1])) .. " , "	
		enum1 = broj1
		denom1 = math.abs(numb[1][1]) 
		q = lib.math.gcd(enum1,denom1)
		enum1 = enum1/q
		denom1 = denom1/q		
		remark = remark .. lib.check_fraction_simple(enum1, denom1) .. " , "
	end
	tmp2 = -numb[2][2]/ numb[2][1]
	if (tmp2 == lib.math.round(tmp2)) then
		note = note .. lib.check_number(lib.math.round(tmp2),20)  .. " , "
		remark = remark .. lib.check_number(lib.math.round(tmp2),20) 
    else	
		if (tmp2 < 0) then
			broj2 = -math.abs(numb[2][2])
		else
			broj2 = math.abs(numb[2][2])	
		end		
		note = note .. lib.check_fraction_simple(broj2, math.abs(numb[2][1])) .. " , " 
		enum2 = broj2
		denom2 = math.abs(numb[2][1]) 
		q = lib.math.gcd(enum2,denom2)
		enum2 = enum2/q
		denom2 = denom2/q		
		remark = remark .. lib.check_fraction_simple(enum2, denom2) 		
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
				opp[j] = " - "
			else
				opp[j] = " + "
			end
			qq = lib.math.gcd(numb[j][4],numb[j][7])
			numb[j][4] = numb[j][4]/qq
			numb[j][7] = numb[j][7]/qq			
			if (numb[j][7] == 1) then
				tmp = math.abs(numb[j][4])			
				quest = quest .. opp[j] .. tostring(math.floor(tmp)) 
			else
				quest = quest .. opp[j] .. lib.frac_start() .. tostring(math.floor(math.abs(numb[j][4]))) .. lib.frac_mid() .. tostring(math.floor(numb[j][7])) .. lib.frac_end() 
			end
		end
	else
		quest = quest .. lib.frac_start() .. tostring(math.abs(numb[j][5])) .. lib.frac_mid() .. term[j] .. lib.frac_end() 
		if (numb[j][4] ~= 0) then
			if (numb[j][4] < 0) then
				opp[j] = " - "
			else
				opp[j] = " + "
			end
			tmp = math.abs(numb[j][7]/numb[j][4])
			if (tmp == math.floor(tmp)) then
				quest = quest .. opp[j] .. tostring(math.floor(tmp)) 
			else
				quest = quest .. opp[j] .. lib.frac_start() .. tostring(math.floor(math.abs(numb[j][7]))) .. lib.frac_mid() .. tostring(math.floor(math.abs(numb[j][4]))) .. lib.frac_end() 
			end
		end		
	end
	if (j == 1) then
		quest = quest .. " = "
	end
end

equ = ""
if (ind == 1) then
    if (numb[1][4] == 0) then
		numb[1][7] = 1
	end
    if (numb[2][4] == 0) then
		numb[2][7] = 1
	end	
    cl[1] = numb[1][7] * numb[2][5] * numb[2][7]	
    cr[1] = numb[1][5] * numb[1][7] * numb[2][7]
    cl[2] = numb[1][5] * numb[2][5] * numb[2][7]	
    cr[2] = numb[1][5] * numb[1][7] * numb[2][5]		
	ans[1] = lib.check_number(cl[1],25) .. "*(" .. term[1]	.. ") " 
    if (numb[1][4] ~= 0) then 
		ans[1] = ans[1] .. opp[1] .. lib.check_number(cl[2],25) .. "*" ..  tostring(math.floor(math.abs(numb[1][4]))) 
	end
	ans[1] = ans[1] .. " = " .. lib.check_number(cr[1],25) .. "*(" .. term[2]	.. ") " 
    if (numb[2][4] ~= 0) then		
		ans[1] = ans[1] .. opp[2] .. lib.check_number(cr[2],25) .. "*" ..  tostring(math.floor(math.abs(numb[2][4]))) 
	end
	cl[3] = cl[1] * numb[1][1] - cr[1] * numb[2][1]
	cr[3] = cr[1] * numb[2][2] + cr[2] * numb[2][4] - cl[1] * numb[1][2] - cl[2] * numb[1][4]
    ans[2] = lib.check_number(cl[3]) .. " x = " .. lib.check_number(cr[3])	
else
    cl[1] = numb[1][5] 	
    cr[1] = numb[2][5] 
	ans[1] = lib.check_number(cl[1],25) .. "*(" .. term[2]	.. ") = " .. lib.check_number(cr[1],25) .. "*(" .. term[1]	.. ")" 
	cl[3] = cl[1] * numb[2][1] - cr[1] * numb[1][1]
	cr[3] = cr[1] * numb[1][2] - cl[1] * numb[2][2]
    ans[2] = lib.check_number(cl[3]) .. " x = " .. lib.check_number(cr[3])		
end
aa = lib.math.round(cl[3])
bb = lib.math.round(cr[3])
if (aa * bb ~= 0) then
	q = lib.math.gcd(aa,bb)
	aa = aa/q
	bb = bb/q
end	

if (aa < 0) then
	aa = - aa
	bb = - bb
else
    if (aa == 0) then
	    bb = 1
	end
end
	
equ = lib.check_number(aa) .. " x = " .. lib.check_number(bb)      
           
           