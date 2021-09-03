
answ1 = ""
answ2 = ""

brac = {"\(\big ( \)", "\(\big ) \)"}

max = 17
imenilac = 2 + math.random(max);
broj1 =  math.random(imenilac - 1);
broj2 = 1 + math.random(imenilac - 2);
fact = math.random(2)
if (fact == 1) then
    broj1 = -broj1
end	
fact = math.random(2)
if (fact == 2) then
    broj2 = -broj2
end	

ind = math.random(2)

if (ind == 1) then 
    sign = "+"
    summ = broj1 + broj2
else
    sign = "-"
    summ = broj1 - broj2
end	
	
q = lib.math.gcd(summ, imenilac)
imen = imenilac / q
broj = summ / q
value = broj/imen

condition1 = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"
sln1 = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
answ1 = lib.check_fraction_condition(condition1, nil, nil, sln1)

if (value == 0) then	
    answ2 = " = " .. lib.check_number(value,20)	
else 
    if (value > 0) then
        swhole = math.floor(value)
    else 
        swhole = math.ceil(value)
    end	
    rest = broj - swhole * imen	
    if (swhole ~= 0) then 
        answ2 = " = " .. lib.check_number(swhole,20)	
        rest = math.abs (rest)		
        if (rest ~= 0) then
		    tmp = rest/imen
            condition2 = "is_ok = math.eq(numerator/denominator, "..tostring(tmp)..");"
            sln2 = "numerator="..tostring(rest)..";denominator="..tostring(imen).. ";"
            answ2 = answ2 .. lib.check_fraction_condition(condition2, nil, nil, sln2)
        end
    end
end




