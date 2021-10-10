
include("terms")

proc = "%"

ind = math.random(2)
denom = 10^ind 
max = math.floor(denom/3)
enum =  math.random(max);
if (enum == denom) then
    enum = enum - math.random(5)
end	
value = enum / denom
per = lib.math.round(value * 100)

number = 2000 + math.random(2999)
if (number - 10*math.floor(number/10) == 1) then
    val = msg[1]
else
    val = msg[2]
end	

numb1 = number * (1 + enum/denom) 
price1 = numb1 * (1 - enum/denom)
price1 = lib.math.round_dec(price1, 2)
    
if (ind == 0 and price1 - 100*math.floor(price1/100) == 1) then
    valnew1 = msg[1]
else
    valnew1 = msg[2]
end	
      
numb2 = number * (1 - enum/denom) 
price2 = numb2 * (1 + enum/denom)
price2 = lib.math.round_dec(price2, 2)
    
if (ind == 0 and price2 - 100*math.floor(price2/100) == 1) then
    valnew2 = msg[1]
else
    valnew2 = msg[2]
end	
 