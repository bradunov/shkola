
include("terms")

enum = 1 + math.random(15);
denom = 1 + math.random(20);

temp1 = math.floor(enum/denom)
rest1 = enum - temp1 * denom 
temp2 = math.floor(denom/enum)
rest2 = denom - temp2 * enum
if (rest1 == 0 or rest2 == 0) then 
    enum = enum + 1
end	

q = lib.math.gcd(enum, denom)
broj = enum/q
imen = denom/q

dif = math.abs(broj - imen)
factor = 1 + math.random(9)
numb = dif * factor
    
ind = math.random(2)
if (ind == 1) then
    if (enum > denom) then
	    sign = 1
	else
	    sign = 2
	end	
	result = factor * imen	
else
    if (enum > denom) then
	    sign = 2
	else
	    sign = 1
	end	
	result = factor * broj	
end	

