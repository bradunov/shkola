
gcd = math.random(7) + 2
jimenilac = math.random(24) + 5
jbrojilac = math.random(jimenilac - 2) + 1


gcd2 = lib.math.gcd(jimenilac, jbrojilac)

jimen = jimenilac / gcd2
jbroj = jbrojilac / gcd2

if (gcd == gcd2) then
    gcd = gcd - 1
end
imenilac = jimen * gcd 
brojilac = jbroj * gcd 

ind = math.random(2)
answ = ""
if (ind == 1) then 
    answ = lib.check_fraction_numerator(jbrojilac,jimenilac)
else	
    answ = lib.check_fraction_denominator(jbrojilac,jimenilac)
end	
