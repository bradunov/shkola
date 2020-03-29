
imenilac = math.random(16) + 3;

summ = 2 + math.random(imenilac -3);
broj1 = math.random(summ -1);
broj2 = summ - broj1;

temp = lib.math.gcd(imenilac, summ)

broj = summ / temp
imen = imenilac / temp


answ = ""
if (temp ~=1 ) then
    answ = " = " .. lib.check_fraction_simple(broj,imen)	
end	

