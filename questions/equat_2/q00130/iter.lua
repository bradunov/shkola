
coef = {}
term1 = ""
term2 = ""
quest = ""
answ = ""

for i = 1,4 do
    if (i == 1 or i == 4) then	
		min_range = 21
		max_range = math.random(41)
	else		
		min_range = 6
		max_range = math.random(11)		
	end
	coef[i] = min_range - math.random(max_range)
	if (coef[i] == 0) then
		coef[i] = math.random(6)
	end
end
coef[5] = 2 + math.random(13)
			
ind = math.random(2)   
if (ind == 1) then
    var1 = "x" 
    var2 = "y"
else
    var1 = "y" 
    var2 = "x"	
end

if (coef[2] < 0) then
	sg1 = " - "
else 
	sg1 = " + "	
end	
temp1 = tostring(math.abs(coef[2]))
if (math.abs(coef[2]) == 1) then
    temp1 = " "
end	
term1 = tostring(coef[1]) .. sg1 .. temp1 .. "x"
if (coef[4] < 0) then
	sg2 = " - "
else 
	sg2 = " + "	
end	
temp2 = tostring(math.abs(coef[4]))	
term2 = "y" .. sg2 .. temp2
if (math.abs(coef[3]) == 1) then
    if (coef[3] == -1) then
		term2 = "-"	.. term2
	end
else
	term2 = tostring(coef[3]) .. term2	
end	
quest = quest .. lib.frac_start() .. term1 .. lib.frac_mid() .. tostring(coef[5]) .. lib.frac_end() .. " = " .. term2

numb = 5 - math.random(8)
if (ind == 1) then
	enum = coef[1] + coef[2]*numb - coef[4]*coef[5]
	denom = coef[3] * coef[5]
else
	enum = (coef[4] + coef[3]*numb)*coef[5] - coef[1]
	denom = coef[2]
end	
if (denom < 0) then
	enum = - enum
	denom = - denom
end
value = enum / denom  
if (value < 0) then
	swhole = math.ceil(value)   
else     
	swhole = math.floor(value)
end
rest = value - swhole 
if (math.abs(lib.math.round_dec(rest, 2) - rest) < 0.00001) then    
	answ = lib.check_number(value,50)
else	
	if (swhole == 0) then
		condition0 = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"                     
		g0 = lib.math.gcd(enum, denom)
		sln0 = "numerator="..tostring(enum/g0)..";denominator="..tostring(denom/g0) .. ";"
		answ = lib.check_fraction_condition(condition0, nil, nil, sln0)
	else
		snum = math.abs((value - swhole) * denom)
		val = snum / denom
		condition = "is_ok = math.eq( numerator/denominator, "..tostring(val)..");"                     
		g = lib.math.gcd(snum, denom)
		sln = "numerator="..tostring(snum/g)..";denominator="..tostring(denom/g).. ";"
		answ = lib.check_number(swhole) .. lib.check_fraction_condition(condition, nil, nil, sln)
	end	
end	