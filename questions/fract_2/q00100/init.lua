
meas = { "dl", "l"} 

denom = {4, 5, 8, 10} 

broj = {}
imen = {}
val = {}
ans = ""

for i = 1,2 do
	ch = math.random(4)  
	imen[i] = denom[ch]
	broj[i] = math.random(imen[i]-1)
        val[i] = broj[i]/imen[i] 
end
if (val[1] > val[2]) then
    tmp = imen[1]
    imen[1] = imen[2]
    imen[2] = tmp
    tmp = broj[1]
    broj[1] = broj[2]
    broj[2] = tmp
    tmp = val[1]
    val[1] = val[2]
    val[2] = tmp
else
    if (val[1] == val[2]) then 
       if (broj[1] > 1) then
          broj[1] = 1
       else
          broj[2] = broj[2] + 1
       end
    end
end

brojilac = broj[2]*imen[1] -  broj[1]*imen[2] 
imenilac = imen[1]*imen[2] 
add = math.random(9)
total = add * imenilac

value = total/brojilac
if (value == math.floor(value)) then
    value = lib.math.round_dec(value/10, 1)
    ans = lib.check_number(value)
else
    brojilac  = brojilac*10 
	value = total/brojilac
	condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(value)..");"
    swhole = math.floor(value)
    snum = lib.math.round((value - swhole)*brojilac)
    q = lib.math.gcd(snum, brojilac)  
    brojilac = math.floor(brojilac/q) 
    snum = math.floor(snum/q) 
    solution = "numerator="..tostring(snum)..";denominator="..tostring(brojilac)..";whole="..tostring(swhole)..";"	
    ans = lib.check_fraction_condition(condition, true, nil, solution)
end             
            