
numb = {}
index = {}
value = {}
term = {""}
answ = ""
answ2 = ""

numb[1] = {}
for i = 1,2 do
	index[i] = math.random(4) - 1
	if (index[i] > 0) then
		index[i] = 1
	end	
end	
if (index[1] + index[2] == 0) then
    max_range = 70
else
    max_range = 69
end
numb[1][1] = 20 + math.random(max_range)
value[1] = numb[1][1]
term[1] = tostring(numb[1][1]) .. meas[1]
for i = 2,3 do
	numb[1][i] = index[i-1] * math.random(59)  
	value[1] = value[1] * 60 + numb[1][i]	
	if (numb[1][i] ~= 0) then
        term[1] = term[1] .. " " .. tostring(numb[1][i]) .. meas[i]
    end 
end

value[2] = value[1] * 2
value[3] = value[1] * 3

for i = 2,3 do
    numb[i] = {}
    numb[i][1] = math.floor(value[i]/3600)
	if (numb[i][1] ~= 0) then
        term[i] = tostring(numb[i][1]) .. meas[1]
    else 
        term[i] = ""
    end	
    rest = value[i] - numb[i][1] * 3600
    numb[i][2] = math.floor(rest/60)
    numb[i][3] = math.floor(rest - numb[i][2] * 60)
	for j = 2,3 do
	    if (numb[i][j] ~= 0) then
            term[i] = term[i] .. " " .. tostring(numb[i][j]) .. meas[j]
		end	
    end
end	

ind = math.random(3)
if (ind == 1) then
    quest = alpha .. " = " .. term[1] 
	answ = phi .. " = " .. lib.check_number(numb[2][1],30) .. meas[1]
	for j = 2,3 do
		answ = answ .. spc .. lib.check_number(numb[2][j],20) .. meas[j]
    end		
end
if (ind == 2) then
    quest = phi .. " = " .. term[2] 
	answ = alpha .. " = " .. lib.check_number(numb[1][1],20) .. meas[1]
	for j = 2,3 do
		answ = answ .. spc .. lib.check_number(numb[1][j],20) .. meas[j]
    end		
end
if (ind == 3) then
    quest = alpha .. " + " .. phi .. " = " .. term[3] 
	answ = alpha .. " = " .. lib.check_number(numb[1][1],20) .. meas[1]
	answ2 = phi .. " = " .. lib.check_number(numb[2][1],30) .. meas[1]	
	for j = 2,3 do
		answ = answ .. spc .. lib.check_number(numb[1][j],20) .. meas[j]
		answ2 = answ2 .. spc .. lib.check_number(numb[2][j],20) .. meas[j]		
    end		
end
        
        
            