
proc = "%"

ind = math.random(3)
denom = 10^ind 
enum = 2 + math.random(2*denom - 5);	
value = enum / denom

result = value * 100
round = 0
if (ind > 2) then
    round = ind - 2
end	
resround = lib.math.round_dec(result, round)


q = lib.math.gcd(enum, denom)
enum = enum / q
denom = denom / q


quest = ""
stampa = math.random(2)

if (stampa == 1) then
    quest = "\(\frac{" .. math.floor(enum) .. "}{" .. math.floor(denom) .. "}\)"
else
    quest = value
end	


