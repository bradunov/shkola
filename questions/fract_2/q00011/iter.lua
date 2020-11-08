
answ = ""

imenilac = math.random(9) + 1;

broj1 = math.random(imenilac -1);
broj2 = math.random(imenilac -1);

summ = broj1 + broj2
value = summ/imenilac
swhole = math.floor(value)

if (summ >= imenilac) then   
    rest = summ - swhole * imenilac
    if (rest == 0) then
        answ = " = " .. lib.check_number(swhole)
    else
        condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(value)..");"
        snum = lib.math.round((value - swhole) * imenilac)
        g = lib.math.gcd(snum, imenilac)
        sln = "numerator="..tostring(snum/g)..";denominator="..tostring(imenilac/g)..";whole="..tostring(swhole)..";"
        answ = " = " .. lib.check_fraction_condition(condition, true, nil, sln)
    end
end	




