
oper = {"+", "-", "*", "/"}
op = {}
numb = {}
space = "\( \ \) "
arrow = " - > "
quest = ""

minb = 15
maxb = 30
for i = 1,4 do
    if (i < 3) then
		numb[i] = i + math.random(minb - i)
	else
		numb[i] = minb + i + math.random(maxb - minb - i)	
	end		
end	
numb[4] = numb[4]/10
numb[4] = lib.math.round_dec(numb[4], 1)
if (numb[4] == lib.math.round(numb[4])) then
	numb[4] = lib.math.round(numb[4])
end

ind = math.random(2)
if (ind == 1) then
    temp = numb[4]/ numb[2]
	op[3] = oper[3]
    if (temp < numb[3]) then
		numb[5] = temp + numb[3]
		op[2] = oper[2]
	else
		numb[5] = temp - numb[3]
		op[2] = oper[1]	
	end
	numb[5] = numb[5] * numb[1]
	op[1] = oper[4]		
else	
    temp = numb[4] * numb[2]
	op[3] = oper[4]
    if (temp < numb[3]) then
		numb[5] = temp + numb[3]
		op[2] = oper[2]
	else
		numb[5] = temp - numb[3]
		op[2] = oper[1]	
	end
	numb[5] = numb[5] / numb[1]
	op[1] = oper[3]	
end	
numb[5] = lib.math.round_dec(numb[5], 2)
quest = "X" .. space .. arrow .. space .. op[1] .. " " .. numb[1] .. space .. arrow .. space .. op[2] .. " " .. numb[3] .. space .. arrow .. space .. op[3] .. " " .. numb[2] .. space .. arrow .. space .. " = " .. numb[4]
      