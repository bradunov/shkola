
proc = "%"

ind = math.random(2)
denom = 10^ind 
enum = 2 + math.random(2*denom - 5);	
value = enum / denom

result = math.floor(value * 100)

q = lib.math.gcd(enum, denom)
enum = enum / q
denom = denom / q
     


