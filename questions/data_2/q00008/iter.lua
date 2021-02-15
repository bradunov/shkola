
proc = "%"

ind = math.random(3)
denom = 10^ind 
enum = 2 + math.random(2*denom - 5);
if (enum == denom) then
    enum = enum - math.random(5)
end	
value = enum / denom

per = value * 100
if (ind == 3) then
    round = 1
else
    round = 0	
end	
peround = lib.math.round_dec(per, round)

number = 2 + math.random(27)
result = enum * number / denom

result = lib.dec_to_str(lib.math.round_dec(result, ind))
   

            


