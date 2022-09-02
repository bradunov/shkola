
include("names")
include("terms")

r = math.random(#musko_ime_nom);
ime = musko_ime_nom[r];

den = 3 + math.random(7) 
denom = 2 * den
number = math.random(den - 2);
if (number > 4) then
    pc = 3
else
    if (number == 1) then
        pc = 1
    else
        pc = 2
	end	
end		
tmp = denom - number - 3
enum = math.random(tmp);
res =  number + enum
if (res < den) then
    ind = 1
else
	if (res > den) then
	    ind = 3
	else
	    ind = 2
	end
end

	
	