answ = ""

imenilac = math.random(7) + 2;

broj1 = math.random(imenilac -1);
broj2 = math.random(imenilac -1);

summ = broj1 + broj2
value = summ/imenilac

condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(value)..");"

if (summ >= imenilac) then   
    answ = " = " .. lib.check_fraction_condition(condition, true)
end	


