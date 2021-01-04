
denom = {10, 100, 1000}
index = math.random(3)
imenilac = denom[index]

ind = math.random(2)
if (ind == 1) then 
    min = 0
	max = denom[index] - 1
else
    min = denom[index]
	max = 3 * denom[index] - 1
end
	
brojilac = min + math.random(max-min)
rezult = brojilac/imenilac         
                      
sign = math.random(2)
for i = 1,2 do
	rest = brojilac - (10^i) * math.floor(brojilac/(10^i))
	if (rest == 0) then
	   sign = 1
	end
end	

answ = ""

if (sign == 1) then 
    answ =  "\(\frac{" .. tostring(brojilac) .. "}{" .. tostring(imenilac) .. "}\)  = " .. lib.check_number(rezult,50) 		
else
    answ =  lib.check_fraction_simple(brojilac, imenilac) .. " = " .. tostring(rezult) 	
end	
            