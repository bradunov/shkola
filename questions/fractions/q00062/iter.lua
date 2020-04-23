answ = ""

imenilac = math.random(7) + 2;

broj1 = math.random(imenilac -1);
broj2 = math.random(imenilac -1);

summ = broj1 + broj2
value = summ/imenilac

condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(value)..");"

swhole = math.floor(value)
snum = lib.math.round((value - swhole) * imenilac)
g = lib.math.gcd(snum, imenilac)

sln = "numerator="..tostring(snum/g)..";denominator="..tostring(imenilac/g)..";whole="..tostring(swhole)..";"

if (summ >= imenilac) then   
    answ = " = " .. lib.check_fraction_condition(condition, true, nil, sln)
end	


