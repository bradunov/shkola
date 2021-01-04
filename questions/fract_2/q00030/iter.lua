
imenilac = {}
brojilac = {}
reply = {""}
out = {""}

dim = 3
deg = math.random(dim)
res = 10^deg

number = math.random(998)
for i = 1,3 do
    if(number - 10^i * math.floor(number/10^i) == 0) then
	   number = number + 1
	end   
end	
numb_dec = number/res

fact = 1
for i = 1, 3 do
    imenilac[i] = math.floor(res * fact)
    brojilac[i] = math.floor(number * fact)
	fact = 10 * fact
end	

reply[1] = lib.check_fraction_numerator(brojilac[1],imenilac[1])
reply[2] = lib.check_fraction_denominator(brojilac[2],imenilac[2])
reply[3] = lib.check_fraction_numerator(brojilac[3],imenilac[3])
reply[4] = tostring(numb_dec)

index = {1, 2, 3, 4}	
out = lib.math.random_shuffle(index)
