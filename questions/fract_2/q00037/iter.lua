
set = {1, 1, 2, 2, 2, 2, 5, 5, 5, 5}
fact = lib.math.random_shuffle(set)

jimenilac = 1
for i = 1,4 do
    jimenilac = jimenilac * fact[i]
end
	
if (jimenilac == 10 or jimenilac == 100) then
    jimenilac = jimenilac * 2
end	

if (jimenilac < 50) then 
    jbrojilac = jimenilac + math.random(50 - jimenilac)
else
    jbrojilac = 2 + math.random(jimenilac - 2)
end	

if (jbrojilac == jimenilac * math.floor(jbrojilac/jimenilac)) then
    jbrojilac = jbrojilac + 1
end	
     
gcd2 = lib.math.gcd(jimenilac, jbrojilac)
imenilac = jimenilac / gcd2
brojilac = jbrojilac / gcd2

value = brojilac/imenilac 
 
                      