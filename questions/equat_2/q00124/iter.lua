
letter = {"a", "b", "n", "x", "y", ""}
oper = {"+", "-"}

enum = {}
denom = {}
broj = {}
imen = {}
value = {}
ch = {}
term = {""}

argchk = {""}
index = {}
idx = {}
choice = {}

dim = 2

--[[argumenti]]--	
for i = 1,6 do
    index[i] = i
end
idx = lib.math.random_shuffle(index)
choice[1] = letter[idx[1]]
choice[2] = letter[idx[2]]

for i = 1,dim do
    term[i] = ""
    if (idx[i] == 6) then
		argchk[i] = ""
    else	
		argchk[i] = choice[i] .. "\(^{\small" .. 2 .. "}\)"	
    end
end	

--[[koeficijenti]]--	
max_range = 5
for i = 1,2 do	
	ch[i] = 1 + math.random(2)
	enum[i] = math.random(2*max_range)		 
	if (ch[i] == 2) then
		denom[i] = 1
	else
		denom[i] = 1 + math.random(max_range)
		qq = lib.math.gcd(enum[i], denom[i])
		enum[i] = math.floor(enum[i]/qq)
		denom[i] = math.floor(denom[i]/qq)
		if (denom[i] == 1) then
			ch[i] = 2
		end	
	end	

	if (ch[i] < 3) then
		val = math.floor(enum[i]/denom[i])	
		term[1] = term[1] .. lib.check_number(val,15) 		
		term[2] = term[2] .. lib.check_number(val,15) 		
	else		
		term[1] = term[1] .. lib.frac_start() .. lib.check_number(enum[i], 20) .. lib.frac_mid() .. lib.check_number(denom[i],15) .. lib.frac_end()
		term[2] = term[2] .. lib.frac_start() .. lib.check_number(enum[i], 20) .. lib.frac_mid() .. lib.check_number(denom[i],15) .. lib.frac_end()
	end	
	if (idx[i] ~= 6) then	
		term[1] = term[1] .. lib.check_string(choice[i],10)
		term[2] = term[2] .. lib.check_string(choice[i],10)	
	end	
    if (i == 1) then		
		term[1] = term[1] .. lib.check_string(oper[1],10)
		term[2] = term[2] .. lib.check_string(oper[2],10)	
	end		
end
quest = "(" .. term[1] .. ") * (" .. term[2] .. ")"

for i = 1,2 do
	broj[i] = enum[i] * enum[i] 
	imen[i] = denom[i] * denom[i]
end
for i = 1,2 do
	qq = lib.math.gcd(broj[i], imen[i])
	broj[i] = math.floor(broj[i]/qq)
	imen[i] = math.floor(imen[i]/qq)	
	value[i] = broj[i]/imen[i]
end

result = ""
for i = 1,dim do
	valabs = math.abs (value[i])
    if (valabs ~= 1) then    	
		rest = 10*valabs - math.floor(10*valabs)	
		if (rest == 0) then
			result = result .. " " .. lib.dec_to_str(lib.math.round_dec(value[i],1)) 
		else	
			result = result .. " " .. "\(\frac{" .. tostring(broj[i]) .."}{" .. tostring(imen[i]) .. "}\)" 
		end	
    else
		if (idx[i] == 6) then
			result = result .. " 1"
		end
	end	
	if (idx[i] ~= 6) then	
		result = result .. argchk[i]	
	end		
    if (i == 1) then
		result = result .. oper[2]
    end		
end	
