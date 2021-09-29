
answ1 = ""
answ2 = ""

brac = {"\(\big ( \)", "\(\big ) \)"}

max = 7
imenilac1 = 2 + math.random(max);
brojilac1 =  math.random(2*max);
imenilac2 = 1 + math.random(max + 1);
brojilac2 = 1 + math.random(2*max);
if (brojilac1 == imenilac1) then
    brojilac1 = brojilac1 - 1
end
fact = math.random(2)
if (fact == 1) then
    brojilac1 = -brojilac1
end	
if (brojilac2 == imenilac2) then
    brojilac2 = brojilac2 + 1
end	
fact = math.random(2)
if (fact == 2) then
    brojilac2 = -brojilac2
end	

ind = math.random(2)

denom = imenilac1 * imenilac2
if (ind == 1) then 
    sign = "+"
    enum = brojilac1*imenilac2 + brojilac2*imenilac1
else
    sign = "-"
    enum = brojilac1*imenilac2 - brojilac2*imenilac1	
end	
	
q = lib.math.gcd(enum, denom)
denom = denom / q
enum = enum / q
value = enum/denom

condition1 = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"
sln1 = "numerator="..tostring(enum)..";denominator="..tostring(denom)..";"
answ1 = lib.check_fraction_condition(condition1, nil, nil, sln1)

if (value == 0) then	
    answ2 = " = " .. lib.check_number(value,20)	
else 
    if (value > 0) then
        swhole = math.floor(value)
    else 
        swhole = math.ceil(value)
    end	
    rest = enum - swhole * denom
    if (swhole ~= 0) then   	
        answ2 = " = " .. lib.check_number(swhole,20)
        rest = math.abs (rest)			
        if (rest ~= 0) then	
	        tmp = rest/denom
	        condition2 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"
            sln2 = "numerator="..tostring(rest)..";denominator="..tostring(denom)..";"
            answ2 = answ2 .. lib.check_fraction_condition(condition2, nil, nil, sln2)
		end	
    end
end
 	




