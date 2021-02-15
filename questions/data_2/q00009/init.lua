
include("terms")

proc = "%"

ind = math.random(2)
denom = 10^ind 
enum =  math.random(denom - 5);
if (enum == denom) then
    enum = enum - math.random(5)
end	
value = enum / denom
per = lib.math.round(value * 100)

number = 200 + math.random(999)
if (number - 10*math.floor(number/10) == 1) then
    val = msg[1]
else
    val = msg[2]
end	

result = enum * number / denom

price = number - result 
price = lib.math.round_dec(price, ind)
    
if (ind == 0 and price - 100*math.floor(price/100) == 1) then
    valnew = msg[1]
else
    valnew = msg[2]
end	
