
denom = 1 + math.random(4)
enum = math.random(denom-1)
qq = lib.math.gcd(enum, denom)
enum = lib.math.round(enum/qq)
denom = lib.math.round(denom/qq)
dvol = 30 * (1 + math.random(5))
vol1 = enum * dvol 
vol = denom * dvol
vol2 = vol - vol1
time2 = 1+math.random(5)
time1 = math.ceil(enum/(denom-enum)*time2) + 2+math.random(5)
volex = vol2/time2 * time1

result = volex - vol1
                     