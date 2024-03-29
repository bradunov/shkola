
include("terms")

dg2 = "²"

numb = {}
quest = {""}
value = {}
denom = {}
coef = {}

max_range = 6
ind = math.random(4)

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

for j = 1,2 do
	quest[j] = ""
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
			op = " - "
		else
			op = " + "
        end
     	term = term .. op .. tostring(math.abs(numb[j][3]))	
	end 
    term = "( " .. term .. " )" .. dg2
	if (math.abs(numb[j][1]) ~= 1) then
		term = tostring(numb[j][1]) .. " " .. term
    else
        if (numb[j][1] == -1) then	
		    term = "-" .. term
		end
	end		
	quest[j] = quest[j] .. lib.frac_start() .. term .. lib.frac_mid() .. tostring(numb[j][8]) .. lib.frac_end() 

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
			op = " - "
		else
			if (numb[j][4] ~= 0) then
				op = " + "
			end
		end
		term = term .. op .. tostring(math.abs(numb[j][5]))			
	end	
	if (numb[j][4] ~= 0 or numb[j][5] ~= 0) then	
		quest[j] = quest[j] .. " + " .. lib.frac_start() .. term .. lib.frac_mid() .. tostring(numb[j][9]) .. lib.frac_end() 				
	end
	
	term = ""			
	if (numb[j][6] ~= 0) then	
	    if (numb[j][6] < 0) then
		    op = " - "
		else
		    op = " + "
		end	
		quest[j] = quest[j] .. op  
		if (math.abs(numb[j][6]) ~= 1) then
			term = term .. tostring(math.abs(numb[j][6]))
		end			
		term = term .. " x "		
		quest[j] = quest[j] .. lib.frac_start() .. term .. lib.frac_mid() .. tostring(math.floor(numb[j][10])) .. lib.frac_end() 		
    end		

	if (numb[j][7] ~= 0) then
		if (numb[j][7] < 0) then
			op = " - "
		else
			op = " + "
		end
		tmp = math.abs(numb[j][7]/numb[j][11])
		if (tmp == math.floor(tmp)) then
			quest[j] = quest[j] .. op .. tostring(math.floor(tmp)) 
		else
			quest[j] = quest[j] .. op .. lib.frac_start() .. tostring(math.floor(math.abs(numb[j][7]))) .. lib.frac_mid() .. tostring(math.floor(numb[j][11])) .. lib.frac_end() 
		end
	end	
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

q2 = lib.math.gcd(coef[2],coef[3])
if (ind == 4) then	
	q1 = lib.math.gcd(coef[1],q2)
	coef[1] = coef[1]/q1
	coef[2] = coef[2]/q1
	coef[3] = coef[3]/q1
	if (coef[1] < 0) then
		for i = 1,3 do
			coef[i] = - coef[i]	
		end	
	end		
else	
	coef[2] = coef[2]/q2
	coef[3] = coef[3]/q2
end

equ = lib.check_number(coef[1],40).. "x" .. dg2 
if (coef[2] < 0) then
    equ = equ .. lib.check_string("-", 10) 
else
    equ = equ .. lib.check_string("+", 10) 
end	
equ = equ .. lib.check_number(math.abs(coef[2]),40) .. "x"
if (coef[3] < 0) then
    equ = equ .. lib.check_string("-", 10) 
else
    equ = equ .. lib.check_string("+", 10) 
end	
equ = equ .. lib.check_number(math.abs(coef[3]),40)

if (coef[1] == 0) then
    reply = msg[1]
else
    reply = msg[2]
end
            