
include("terms")

proc = "%"

ind = math.random(2)
denom = 10^ind 
max = math.floor(denom/4)
enum =  math.random(max);
if (enum == denom) then
    enum = enum - math.random(5)
end	
value = enum / denom
per = lib.math.round(value * 100)

number = 2000 + math.random(2999)

tax = enum * number / denom
if (tax - 10*math.floor(tax/10) == 1) then
    val = msg[1]
else
    val = msg[2]
end	

price = number + tax 
price = lib.math.round_dec(price, ind)
    
if (ind == 0 and price - 100*math.floor(price/100) == 1) then
    valnew = msg[1]
else
    valnew = msg[2]
end	