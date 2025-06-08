
letter = {"a", "b", "n", "x", "y", ""}
bracl = "\(\bigl(\)"
bracr = "\(\bigl)\)"

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
    if (i == 1) then	
		term[1] = ""
		term[2] = ""				
    else
		term[1] = term[1] .. lib.check_string("-", 10)		
		term[2] = term[2] .. lib.check_string("+", 10)	
	end			
	if (ch[i] < 3) then
		term[1] = term[1] .. lib.check_number(val,20) 		
		term[2] = term[2] .. lib.check_number(val,20)		
	else		
		term[1] = term[1] .. lib.frac_start() .. lib.check_number(enum[i], 20) .. lib.frac_mid() .. lib.check_number(denom[i],20) .. lib.frac_end()				
		term[2] = term[2] .. lib.frac_start() .. lib.check_number(enum[i], 20) .. lib.frac_mid() .. lib.check_number(denom[i],20) .. lib.frac_end()				
	end	
	if (idx[i] ~= 6) then	
		term[1] = term[1] .. lib.check_string(choice[i], 15)
		term[2] = term[2] .. lib.check_string(choice[i], 15)	
	end			
end
quest = bracl .. term[1] .. bracr .. " * " .. bracl .. term[2] .. bracr

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
		result = result .. " - "
    end	
	rest = 10*value[i] - math.floor(10*value[i])	
	if (rest == 0) then
        if (value[i] ~= 1) then		
		    result = result .. " " .. lib.dec_to_str(lib.math.round_dec(value[i],1)) 
		else
			if (argchk[i] == "") then	
				result = result .. " " .. "1"
            end				
		end	
	else	
		result = result .. " \(\frac{" .. tostring(broj[i]) .."}{" .. tostring(imen[i]) .. "}\)"  
	end	
	result = result .. argchk[i] 	
end	
            