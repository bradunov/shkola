
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
    if (idx[i] == 6) then
		argchk[i] = ""
    else	
		argchk[i] = lib.check_string(choice[i],15) .. lib.sup_start() .. lib.check_number(2,15) .. lib.sup_end()	
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
		else
			tmp = enum[i]/denom[i]
			rest = 10*tmp - math.floor(10*tmp)				
			if (rest == 0) then
				enum[i] = 10 * tmp
				denom[i] = 10
				ch[i] = 1			
			end	
		end	
	end	
	    val = enum[i]/denom[i]
	sg = math.random(2)
    if (i == 1) then	
		if (sg == 2) then
			term[1] = "-"
			term[2] = "-"
        else	
			term[1] = ""
			term[2] = ""		
		end			
    else
		term[1] = term[1] .. oper[sg]
		term[2] = term[2] .. oper[3-sg]	
	end			
    if (val ~= 1) then
		if (ch[i] < 3) then
			term[1] = term[1] .. lib.dec_to_str(lib.math.round_dec(enum[i]/denom[i],1)) 		
			term[2] = term[2] .. lib.dec_to_str(lib.math.round_dec(enum[i]/denom[i],1)) 		
		else		
			term[1] = term[1] .. "\(\frac{" .. tostring(enum[i]) .."}{" .. tostring(denom[i]) .. "}\)"
			term[2] = term[2] .. "\(\frac{" .. tostring(enum[i]) .."}{" .. tostring(denom[i]) .. "}\)"
		end	
    else
		if (idx[i] == 6) then
			term[1] = term[1] .. " 1"
			term[2] = term[2] .. " 1"
		end
	end	
	if (idx[i] ~= 6) then	
		term[1] = term[1] .. choice[i]
		term[2] = term[2] .. choice[i]	
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
    if (i == dim) then
		result = result .. lib.check_string(oper[2],10)
    end	
	valabs = math.abs (value[i])	
	rest = 10*valabs - math.floor(10*valabs)	
	if (rest == 0) then
		result = result .. " " .. lib.check_number(lib.math.round_dec(value[i],1),25) .. argchk[i] 
	else	
		result = result .. " " .. lib.frac_start() .. lib.check_number(broj[i], 20) .. lib.frac_mid() .. lib.check_number(imen[i],20) .. lib.frac_end() .. argchk[i]
	end	
end	
           