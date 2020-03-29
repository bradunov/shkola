answ = ""

imenilac = math.random(7) + 2;

broj2 = math.random(imenilac -1);
diff = math.random(imenilac -1);

broj1 = broj2 + diff

value = diff/imenilac

condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(value)..");"

if (diff >= imenilac) then   
    answ = " = " .. lib.check_fraction_condition(condition, true)
end	



