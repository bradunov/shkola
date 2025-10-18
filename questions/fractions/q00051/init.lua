
include("names")

r = math.random(#zensko_ime_nom);
ime = zensko_ime_nom[r];

ukupno = math.random(7) + 3;
majon = math.random(ukupno - 2) +1;
senf = ukupno - majon;

vrednost = senf / ukupno;
g = lib.math.gcd(senf, ukupno)

is_ok = "is_ok = math.eq(numerator/denominator, "..tostring(vrednost)..");"
sln = "numerator="..tostring(senf/g)..";denominator="..tostring(ukupno/g)..";"
