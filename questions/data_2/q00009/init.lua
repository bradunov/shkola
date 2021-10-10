
include("terms")

proc = "%"

ch = math.random(2)

ind = math.random(2)
denom = 10^ind
max_range = denom - 5 * 10^(ind - 1)
enum =  math.random(max_range);
value = enum / denom
per = math.floor(value * 100)

number = (20 + math.random(99)) * 10
if (number - 10*math.floor(number/10) == 1) then
    val = msg[1]
else
    val = msg[2]
end	

result = value * number 
if (ch == 1) then
    price = number - result 
else
    price = number + result
end	
price = lib.math.round_dec(price, 2)
    
if (ind == 0 and price - 100*math.floor(price/100) == 1) then
    valnew = msg[1]
else
    valnew = msg[2]
end	
