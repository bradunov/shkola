
include("names")

r = math.random(#zensko_ime_nom);
ime = zensko_ime_nom[r];

imenilac1 = math.random(8) + 2;
imenilac2 = math.random(imenilac1 - 2) + 1;
factor = (math.random(10));
rezultat =  factor*imenilac1*imenilac2
broj1 = factor*imenilac2
broj2 = factor*imenilac1
brojp= broj1 + broj2;
brojo = rezultat-brojp

vrednost = brojo / rezultat
simp_brojo = brojo / lib.math.gcd(brojo, rezultat)
simp_rezultat = rezultat / lib.math.gcd(brojo, rezultat)
solution = "numerator="..tostring(simp_brojo)..";denominator="..tostring(simp_rezultat)..";"
