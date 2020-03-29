factor = math.random(2) + 1
imenilac1 = math.random(6) + 3;
imenilac2 = imenilac1 * factor

summ = 3 + math.random(imenilac2 -3);

broj1 = math.random(summ -2);
brojilac1 = broj1 * factor

if (summ <= brojilac1) then
    broj1 = 1
    brojilac1 = factor	
end

broj2 = summ - brojilac1;


temp = lib.math.gcd(imenilac2, summ)

broj = summ / temp
imen = imenilac2 / temp
	                
                                  
                  

