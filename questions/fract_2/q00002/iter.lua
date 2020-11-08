gcd = math.random(3) + 2
jimenilac = math.random(9) + 1
jbrojilac = math.random(jimenilac - 1)

--[[ Here jimenilac and jbrojilac could have a common denominator,
     so make sure this is also removed.
     TBD: math.gcd should be visible from Lua. Check why is it not the case. 
  ]]--
     
gcd2 = lib.math.gcd(jimenilac, jbrojilac)

jimenilac = jimenilac / gcd2
jbrojilac = jbrojilac / gcd2
imenilac = jimenilac * gcd * gcd2
brojilac = jbrojilac * gcd * gcd2

       
