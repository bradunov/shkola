
slash = {"\", "/"}

imenilac2 = math.random(3) + 2;
imenilac1 = imenilac2 + math.random(5);

broj1 = 2 + math.random(imenilac1 - 3);
broj2 = 1 + math.random(imenilac2 - 2);

brojilac1 = broj1 * imenilac2
brojilac2 = broj2 * imenilac1
imenilac = imenilac1 * imenilac2

summ = brojilac1 + brojilac2

if (summ < imenilac) then
    broj1 = imenilac1 - 1
	broj2 = imenilac2 - 1
    brojilac1 = broj1 * imenilac2
    brojilac2 = broj2 * imenilac1
    imenilac = imenilac1 * imenilac2
	summ = brojilac1 + brojilac2
end	

part1 = imenilac - brojilac1
part2 = brojilac2 - part1


temp = lib.math.gcd(imenilac, summ)

broj = summ / temp
imen = imenilac / temp

value = broj/imen

condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(value)..");"


swhole = math.floor(value)
snum = lib.math.round((value - swhole) * imen)
g = lib.math.gcd(snum, imen)

sln = "numerator="..tostring(snum/g)..";denominator="..tostring(imen/g)..";whole="..tostring(swhole)..";"
                     