
letter = {"a", "b", "m", "n", "x", "y"}
oper = {"+", "-"}

degr = {}
arg = {""}
argchk = {""}
sum = {}
index = {}
idx1 = {}
idx2 = {}

enum = {}
denom = {}
broj = {}
imen = {}
value = {}
ch = {}

term = {""}
op = {}
sign = {""}

dim = 4
choice = letter[math.random(6)]

--[[stepeni]]--	
for i = 1,6 do
    index[i] = i
end
idx1 = lib.math.random_shuffle(index)
idx2 = lib.math.random_shuffle(index)
cor = math.random(2)
for i = 1,dim   do
    if (i > 2) then
		degr[i] = math.floor(idx2[i] - 2 + cor)
	else
		degr[i] = math.floor(idx1[i] + 1 - cor)	
	end	
	if (degr[i] == 0) then
		arg[i] = ""
    else	
		arg[i] = choice	
	    if (degr[i] > 1) then
			arg[i] = arg[i] .. "\(^{" .. degr[i] .. "}\)" 
		end	
	end	
end	
for i = 1,2 do
	sum[i] = degr[i] + degr[3] 
	sum[i+2] = degr[i] + degr[4] 
end  
for i = 1,dim do
	argchk[i] = lib.check_string(choice,15) .. lib.sup_start() .. lib.check_number(sum[i],15) .. lib.sup_end()	
end	

--[[koeficijenti]]--	
for i = 1,2 do		
	op[i] = math.random(2)
end	
max_range = 5
for i = 1,dim do	
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
	ind = 1
	if (i > 2) then
	    ind = 2
	end	
	sg = math.random(2)
	if (sg == 2) then
	    if (i == 2 or i == 4) then
		    op[ind] = 3 - op[ind]
		else	
			enum[i] = - enum[i]
		end	
	end	
    val = enum[i]/denom[i]
    if (math.abs(val) ~= 1) then
		if (ch[i] < 3) then
			term[i] = lib.dec_to_str(lib.math.round_dec(enum[i]/denom[i],1)) 		
		else		
			term[i] = "\(\frac{" .. tostring(enum[i]) .."}{" .. tostring(denom[i]) .. "}\)"
		end	
    else
		if (degr[i] == 0) then
			if (val == 1) then           		
				term[i] = "1"
			else
				term[i] = "-1"	
			end				
		else
			if (val == 1) then           		
				term[i] = ""
			else
				term[i] = "-"	
			end		
        end			
	end
	term[i] = term[i] .. arg[i]	
end
quest = "(" .. term[1] .. " " .. oper[op[1]] .. " " .. term[2] .. ") * (" .. term[3] .. " " .. oper[op[2]] .. " " .. term[4] ..")"

for i = 1,2 do
	broj[i] = enum[i] * enum[3] 
	imen[i] = denom[i] * denom[3]
	broj[i+2] = enum[i] * enum[4] 
	imen[i+2] = denom[i] * denom[4]
end
for i = 1,dim do
	qq = lib.math.gcd(broj[i], imen[i])
	broj[i] = math.floor(broj[i]/qq)
	imen[i] = math.floor(imen[i]/qq)	
	value[i] = broj[i]/imen[i]
end

result = ""
for i = 1,dim do
	if (i > 2) then
	    ind = 2
	else
		ind = 1	
	end	
    sign[ind] = oper[op[ind]] 
	if (i > 1) then	
		if (i < dim) then	
			if (broj[i] < 0) then	
				broj[i] = - broj[i]
				value[i] = - value[i]			
				sign[ind] = oper[3-op[ind]]	
			end
		else
			if (op[1] == 2) then			
				sign[ind] = oper[3-op[ind]]	
			end		
		end		
		result = result .. lib.check_string(sign[ind],10)
    end	
	valabs = math.abs (value[i])	
	rest = 10*valabs - math.floor(10*valabs)	
	if (rest == 0) then
		result = result .. " " .. lib.check_number(lib.math.round_dec(value[i],1),30) .. argchk[i] 
	else	
		result = result .. " " .. lib.frac_start() .. lib.check_number(broj[i], 20) .. lib.frac_mid() .. lib.check_number(imen[i],20) .. lib.frac_end() .. argchk[i]
	end	
end	
          