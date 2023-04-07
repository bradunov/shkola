
fun = ""
if (math.abs(enum[perm[ITEM]][1]/denom[perm[ITEM]][1]) ~= 1) then	
	if (ch[perm[ITEM]][1] < 2) then
		fun = fun .. lib.check_number(lib.math.round_dec(enum[perm[ITEM]][1]/denom[perm[ITEM]][1],1))   
	else	
		fun = fun .. lib.check_fraction_simple(enum[perm[ITEM]][1],denom[perm[ITEM]][1]) 		
	end 
else
	if (enum[perm[ITEM]][1] < 0) then
		fun = lib.check_string("-", 15)		
	end	
end
fun = fun .. lib.check_string("x", 20)
if (enum[perm[ITEM]][2] ~= 0) then	
	if (enum[perm[ITEM]][2] < 0) then
		fun = fun .. lib.check_string("-", 15)	
	else
		fun = fun .. lib.check_string("+", 15)	
	end			
	if (ch[perm[ITEM]][2] < 2) then
		fun = fun .. lib.check_number(lib.math.round_dec(math.abs(enum[perm[ITEM]][2])/denom[perm[ITEM]][2],1)) 
	else
		fun = fun ..  lib.check_fraction_simple(math.abs(enum[perm[ITEM]][2]),denom[perm[ITEM]][2]) 					
	end
end	
	
imp = ""
coef = {}
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
termx = "x"				
if (coef[1] ~= 1) then
	termx = tostring(coef[1]).. termx	
end
termy = "y"
sgy = "+"
if (coef[2] < 0) then
	sgy = "-"
end
tmpy = math.abs(coef[2])
if(tmpy ~= 1) then
	termy = tostring(tmpy).. termy	
end	
termf = ""
sgf = ""
if (coef[3] ~= 0) then	
	sgf = "+"
	if (coef[3] < 0) then
		sgf = "-"
	end
	tmpf = math.abs(coef[3])
	termf = tostring(tmpf).. termf	
end
imp = termx .. sgy .. termy .. sgf .. termf	
       