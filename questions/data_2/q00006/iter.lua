
proc = "%"

ind = math.random(2)
denom = 10^ind 
enum = 2 + math.random(2*denom - 5);

value = enum / denom
per = math.floor(value * 100)

number = 3 + math.random(96)
result = lib.math.round_dec(value * number, 2)
            