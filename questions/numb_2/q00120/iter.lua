
letter = {"a", "b", "n", "x", "y"}
oper = {"+", "-"}

enum = {}
denom = {}
broj = {}
imen = {}
value = {}
ch = {}
choice = {""}
term = {""}
index = {}
ind = {}
argchk = {""}

for i = 1,5 do
    index[i] = i
end
ind = lib.math.random_shuffle(index)

--[[argumenti]]--

dim = math.random(2)
choice[1] = letter[ind[1]]
argchk[1] = lib.check_string(choice[1],10) .. lib.sup_start() .. lib.check_number(2,10) .. lib.sup_end()	
if (dim == 1) then
    choice[2] = ""
	argchk[2] = lib.check_string(choice[1],10) 
	argchk[3] = ""	
else	
    choice[2] = letter[ind[2]]	
	argchk[2] = lib.check_string(choice[1],10) .. lib.check_string(choice[2],10)	
	argchk[3] = lib.check_string(choice[2],10) .. lib.sup_start() .. lib.check_number(2,10) .. lib.sup_end()	
end

--[[koeficijenti]]--	
		
max_range = 5
for i = 1,2 do	
	ch[i] = 1 + math.random(2)
	enum[i] = math.random(2*max_range-1)		 
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
	sg = math.random(2)
	if (i == 1 and sg == 2) then			
		enum[i] = - enum[i]
	end	
    val = enum[i]/denom[i]
    if (math.abs(val) ~= 1) then
		if (ch[i] < 3) then
			term[i] = lib.dec_to_str(lib.math.round_dec(enum[i]/denom[i],1)) 		
		else		
			term[i] = "\(\frac{" .. tostring(enum[i]) .."}{" .. tostring(denom[i]) .. "}\)"
		end	
    else
	    if (i == 1) then
			if (val == 1) then           		
				term[i] = ""
			else
				term[i] = "-"	
			end	
        else			
		    if (dim == 1) then
				term[i] = "1"
			else				
				term[i] = ""	
			end				
        end			
	end
	term[i] = term[i] .. choice[i]	
end
quest = "(" .. term[1] .. " " .. oper[sg] .. " " .. term[2] .. ")\(^{\small" .. 2 .. "}\)"

broj[1] = enum[1] * enum[1] 
imen[1] = denom[1] * denom[1]
broj[2] = 2 * enum[1] * enum[2] 
imen[2] = denom[1] * denom[2]
broj[3] = enum[2] * enum[2] 
imen[3] = denom[2] * denom[2]	

for i = 1,3 do
	qq = lib.math.gcd(broj[i], imen[i])
	broj[i] = math.floor(broj[i]/qq)
	imen[i] = math.floor(imen[i]/qq)	
	value[i] = broj[i]/imen[i]
end

result = ""
for i = 1,3 do
	if (i == 1) then
	    if (enum[1] < 0) then
	        sign = oper[3-sg]
			broj[2] = - broj[2]
			value[2] = - value[2]			
		else
	        sign = oper[sg]	
        end			
	else
	    sign = oper[1]	
    end		
	valabs = math.abs (value[i])	
	rest = 10*valabs - math.floor(10*valabs)	
	if (rest == 0) then
		result = result .. " " .. lib.check_number(lib.math.round_dec(value[i],1),20)   
	else	
		result = result .. " " .. lib.frac_start() .. lib.check_number(broj[i], 20) .. lib.frac_mid() .. lib.check_number(imen[i],20) .. lib.frac_end()
	end	
	result = result .. argchk[i]	

	if (i < 3) then
		result = result .. " " .. sign .. " "
	end
end	
               