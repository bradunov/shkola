include("names")

include("set_names")

imenilac1 = math.random(4) + 1;
imenilac2 = math.random(2) + 1;
factor = (math.random(5));
rezultat =  factor*imenilac1*imenilac2
broj1 = factor*imenilac2
broj2 = factor*imenilac1
brojp= broj1 + broj2;
brojo = rezultat-brojp

vrednost = brojo / rezultat
g = lib.math.gcd(brojo, rezultat)

is_ok = "is_ok = math.eq(numerator/denominator, "..tostring(vrednost)..");"
sln = "numerator="..tostring(brojo/g)..";denominator="..tostring(rezultat/g)..";"



