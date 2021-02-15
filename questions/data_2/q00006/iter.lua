
proc = "%"

ind = math.random(3)
denom = 10^ind 
enum = 2 + math.random(2*denom - 5);	
value = enum / denom

per = value * 100
round = 0
if (ind > 2) then
    round = ind - 2
end	
peround = lib.math.round_dec(per, round)

number = 3 + math.random(96)
round = round + 2
result = lib.math.round_dec(value * number, round)
        
            


