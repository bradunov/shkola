
letter = {"a", "b", "m", "n", "x", "y"}

choice = {""}
degr = {}
enum = {}
denom = {}
ch = {}

term = {""}
result = ""
quest = ""
sum = {}

choice = lib.math.random_shuffle(letter)
arg = {""}
argchk = ""
for i = 1,2 do
    degr[i] = {}
	arg[i] = ""	
    for j = 1,2 do
	    if (i == 1) then
		    degr[i][j] = 3 + math.random(6)
        else
		    degr[i][j] = math.random(degr[1][j]-3)	
        end			
		arg[i] = arg[i] .. choice[j]		
		if (degr[i][j] ~= 1) then
			arg[i] = arg[i] .. "\(^{" .. degr[i][j] .. "}\)"
		end	
	end	
end	
argchk = ""
for j = 1,2 do
	sum[j] = degr[1][j] - degr[2][j]	
    argchk = argchk .. lib.check_string(choice[j],15) .. lib.sup_start() .. lib.check_number(sum[j],15) .. lib.sup_end()
end

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
	sg = math.random(2)
	if (sg == 2) then
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
	    if (val == 1) then
            term[i] = ""	
		else
            term[i] = "-"	
        end			
	end
	term[i] = term[i] .. arg[i]	
end

broj = enum[1] * denom[2] 
imen = denom[1] * enum[2]
if (imen < 0) then
    imen = -imen
	broj = - broj
end	
qq = lib.math.gcd(broj, imen)
broj = math.floor(broj/qq)
imen = math.floor(imen/qq)	
value = broj/imen
valabs = math.abs (value)	
rest = 10*valabs - math.floor(10*valabs)  
if (rest == 0) then
	result = lib.check_number(lib.math.round_dec(value,1),30) .. argchk 
else	
	result = lib.frac_start() .. lib.check_number(broj, 20) .. lib.frac_mid() .. lib.check_number(imen,20) .. lib.frac_end() .. argchk
end	
quest = "(" .. term[1] .. ") : (" .. term[2] .. ") = " .. result		
     