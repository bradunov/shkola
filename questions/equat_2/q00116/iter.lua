
letter = {"a", "b", "m", "n", "x", "y"}
oper = {"+", "-"}

degr = {}
enum = {}
denom = {}
broj = {}
imen = {}
value = {}
ch = {}

term = {""}

arg = {""}
argchk = {""}

sum = {}
index = {}
idx = {}

dim = 2
choice = letter[math.random(6)]
	
degr[dim+1] = math.random(5)
arg[dim+1] = choice
if (degr[dim+1] > 1) then
	arg[dim+1] = arg[dim+1] .. "\(^{" .. degr[dim+1] .. "}\)" 
end	 

for i = 1,6 do
    index[i] = i
end
idx = lib.math.random_shuffle(index)

for i = 1,dim   do
	degr[i] = math.floor(idx[i] - 1)
	if (degr[i] == 0) then
		arg[i] = ""
    else	
		arg[i] = choice	
	    if (degr[i] > 1) then
			arg[i] = arg[i] .. "\(^{" .. degr[i] .. "}\)" 
		end	
	end	
    sum[i] = degr[dim+1] + degr[i]
	argchk[i] = lib.check_string(choice,15) .. lib.sup_start() .. lib.check_number(sum[i],15) .. lib.sup_end()	
end	
		
ind = math.random(2)
op = math.random(2)
max_range = 5

for i = 1,dim+1 do	
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
	sg = math.random(2)
	if (sg == 2) then
	    if (i == 2) then
		    op = 3 - op
		else	
			enum[i] = - enum[i]
		end	
	end	
    val = enum[i]/denom[i]
    if (val ~= 1) then
		if (ch[i] < 3) then
			term[i] = lib.dec_to_str(lib.math.round_dec(enum[i]/denom[i],1)) 
			if (i == 2) then
				trm = 	lib.dec_to_str(lib.math.round_dec(-enum[i]/denom[i],1))	
            end				
		else		
			term[i] = "\(\frac{" .. tostring(enum[i]) .."}{" .. tostring(denom[i]) .. "}\)"
		end	
    else
        term[i] = ""	
	end
	term[i] = term[i] .. arg[i]	
end

quest = ""
if (ind == 1) then
	quest = "(" .. term[3] .. ") * (" .. term[1] .. " " .. oper[op] .. " " .. term[2] ..")"
else
	quest = "(" .. term[1] .. " " .. oper[op] .. " " .. term[2] ..") * (" .. term[3] .. ")"
end	

result = ""
for i = 1,dim do
	broj[i] = enum[i] * enum[dim+1] 
	imen[i] = denom[i] * denom[dim+1]
	qq = lib.math.gcd(broj[i], imen[i])
	broj[i] = math.floor(broj[i]/qq)
	imen[i] = math.floor(imen[i]/qq)	
	value[i] = broj[i]/imen[i]
	valabs = math.abs (value[i])	
	rest = 10*valabs - math.floor(10*valabs)
	if (i == 2) then
	    sign = oper[op]
		if (broj[2] < 0) then
		    broj[2] = - broj[2]
		    value[2] = - value[2]			
			sign = oper[3-op]		   
		end
		result = result .. lib.check_string(sign,10)
	end	
	if (rest == 0) then
		result = result .. " " .. lib.check_number(lib.math.round_dec(value[i],1),30) .. argchk[i] 
	else	
		result = result .. " " .. lib.frac_start() .. lib.check_number(broj[i], 20) .. lib.frac_mid() .. lib.check_number(imen[i],20) .. lib.frac_end() .. argchk[i]
	end	

end	
          