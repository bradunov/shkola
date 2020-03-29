factor1 = math.random(2) + 1
factor3 = math.random(2) + 1

imenilac2 = math.random(3) + 2;
imenilac1 = imenilac2 * factor1
imenilac3 = imenilac2 * factor3
imenilac = imenilac2 * factor1 * factor3

broj2 = math.random(imenilac2 -2);
broj1 = 1
broj3 = math.random(imenilac3 -4);

brojilac1 = broj1 * factor3
brojilac2 = broj2 * factor1 * factor3
brojilac3 = broj3 * factor1

summ = brojilac1 + brojilac2 + brojilac3 

if (summ >= imenilac) then
    broj3 = 1
    brojilac3 = factor3	
	summ = brojilac1 + brojilac2 + brojilac3
end

temp = lib.math.gcd(imenilac, summ)

broj = summ / temp
imen = imenilac / temp
	           
                   
                                  
                                  
                  

