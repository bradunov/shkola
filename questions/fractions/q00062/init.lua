
denom = 2 + math.random(7)
enum = 1 + math.random(denom-2)
qq = lib.math.gcd(enum, denom)
enum = lib.math.round(enum/qq)
denom = lib.math.round(denom/qq)
fct = denom - enum
temp = fct * 10 + math.random(10)
vanila = fct * temp
total = temp * denom               
  