
proc = "%"

ind = math.random(2)
denom = 10^ind 
enum = 2 + math.random(2*denom - 5);
if (enum == denom) then
    enum = enum - math.random(5)
end	
value = enum / denom
per = math.floor(value * 100)

number = 2 + math.random(27)
result = lib.dec_to_str(lib.math.round_dec(value * number, ind))
            
   

            


