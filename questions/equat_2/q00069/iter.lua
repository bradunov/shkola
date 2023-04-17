
fun = ""
if (enum[perm[ITEM]][1] < 0 and enum[perm[ITEM]][2] > 0) then
	op = 2
else
	op = 1
end		
termx = "x"
sgx = ""				
if (enum[perm[ITEM]][1] < 0) then
	sgx = " - "	
end
if (math.abs(enum[perm[ITEM]][1]/denom[perm[ITEM]][1]) ~= 1) then
	tmp = math.abs(enum[perm[ITEM]][1])	
	if (ch[perm[ITEM]][1] < 2) then
		termx = lib.dec_to_str(lib.math.round_dec(tmp/denom[perm[ITEM]][1],1)) .. termx 
	else
		if (tmp == 1) then
			termx = "\(\frac{" .. termx .. "}{" .. tostring(denom[perm[ITEM]][1]) .. "}\)"  		
		else		
			termx = "\(\frac{" .. tostring(tmp) .. "}{" .. tostring(denom[perm[ITEM]][1]) .. "}\)" .. termx 	
		end			
	end
end
termf = ""
sgf = ""
if (enum[perm[ITEM]][2] ~= 0) then	
	if (enum[perm[ITEM]][2] < 0) then
		sgf = " - "	
	else
		if (op == 1) then
			sgf = " + "
		end
	end
	tmp = math.abs(enum[perm[ITEM]][2])	
	if (ch[perm[ITEM]][2] < 2) then
		termf = lib.dec_to_str(lib.math.round_dec(tmp/denom[perm[ITEM]][2],1)) .. termf 
	else
		termf = "\(\frac{" .. tostring(tmp) .. "}{" .. tostring(denom[perm[ITEM]][2]) .. "}\)" .. termf 					
	end
end	
if (op == 2) then
	fun = sgf .. termf .. sgx .. termx
else
	fun = sgx .. termx .. sgf .. termf	
end	
	
imp = ""
coef ={}	
coef[1] = enum[perm[ITEM]][1] * denom[perm[ITEM]][2]
coef[2] = -denom[perm[ITEM]][1] * denom[perm[ITEM]][2]	
coef[3] = enum[perm[ITEM]][2] * denom[perm[ITEM]][1]	
if (coef[1] < 0) then
	for j = 1,3 do
		coef[j] = -coef[j]
	end	
end	
q1 = lib.math.gcd(coef[1], coef[2])
q2 = lib.math.gcd(coef[2], coef[3])
qq = lib.math.gcd(q1, q2)
for j = 1,3 do
	coef[j] = math.floor(coef[j]/qq)
end	
imp = lib.check_number(coef[1],20) .. lib.check_string("x",15)	
if (coef[2] < 0) then
	imp = imp .. lib.check_string("-",10)
else	
	imp = imp .. lib.check_string("+",10)	
end
imp = imp .. lib.check_number(math.abs(coef[2]),20) .. lib.check_string("y",15)	
if (coef[3] ~= 0) then	
	if (coef[3] < 0) then
		imp = imp .. lib.check_string("-",10)
	else
		imp = imp .. lib.check_string("+",10)			
	end
	imp = imp .. lib.check_number(math.abs(coef[3]),20)
end
