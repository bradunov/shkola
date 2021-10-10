
proc = "%"

ind = math.random(2)
denom = 10^ind 
enum = 2 + math.random(2*denom - 5);	
value = enum / denom
result = math.floor(value * 100)

q = lib.math.gcd(enum, denom)
enum = enum / q
denom = denom / q

quest = ""
stampa = math.random(2)

if (stampa == 1) then
    quest = "\(\frac{" .. math.floor(enum) .. "}{" .. math.floor(denom) .. "}\)"
else
    quest = lib.dec_to_str(value)
end	



