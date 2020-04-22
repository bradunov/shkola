imenilac = (math.random(4)) + 1;
brojilac = (math.random(imenilac-1)) ;

deo = 60 * brojilac / imenilac;

fact = (math.random(9))+1;
put = deo * fact;

brojp = brojilac * fact;   

vrednost = put / 60               

condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(vrednost)..");"

swhole = math.floor(vrednost)
snum = lib.math.round((vrednost - swhole) * 60)
gcd = lib.math.gcd(snum, 60)
solution = "numerator="..tostring(snum/gcd)..";denominator="..tostring(60/gcd)..";whole="..tostring(swhole)..";"
