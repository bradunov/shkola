
answ1 = ""
answ2 = ""

imenilac = 2 + math.random(19);

broj1 = 1 + math.random(imenilac -2);
broj2 = math.random(broj1 -1);

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
swhole = math.floor(value)

condition1 = "is_ok = math.eq(numerator/denominator, "..tostring(value)..");"
sln1 = "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"
answ1 = lib.check_fraction_condition(condition1, nil, nil, sln1)

if (swhole > 0) then   
    rest = broj - swhole * imen
    if (rest == 0) then
        answ2 = " = " .. lib.check_number(swhole)
    else
        condition2 = "is_ok = math.eq(whole + numerator/denominator, "..tostring(value)..");"
        sln2 = "numerator="..tostring(rest)..";denominator="..tostring(imen)..";whole="..tostring(swhole)..";"
        answ2 = " = " .. lib.check_fraction_condition(condition2, true, nil, sln2)
    end
end 	



