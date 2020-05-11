
sign = {"+", "-"}

ind = math.random(2)

imenilac = math.random(9) + 1;

broj1 = math.random(imenilac -1);
broj2 = math.random(imenilac -1);

if (ind == 1) then
    value = broj1 + broj2
else	
    if (broj1 < broj2) then
	    temp = broj2
		broj2 = broj1
		broj1 = temp
	end	
        value = broj1 - broj2
end 



