
imenilac2 = math.random(3) + 2;
imenilac1 = imenilac2 + math.random(5);

broj1 = 2 + math.random(imenilac1 - 3);
broj2 = 1 + math.random(imenilac2 - 2);

ind = math.random(2)

    q1 = broj1/imenilac1
	q2 = broj2/imenilac2
if (ind == 2) then	
	if ( q2 > q1) then
	    qq = broj2
	    broj2 = broj1
	    broj1 = qq
	    qq = imenilac2
	    imenilac2 = imenilac1
	    imenilac1 = qq	
	 end  
end	

imenilac2 = math.random(3) + 2;
imenilac1 = imenilac2 + math.random(5);

broj1 = 2 + math.random(imenilac1 - 3);
broj2 = 1 + math.random(imenilac2 - 2);

ind = math.random(2)

q1 = broj1/imenilac1
q2 = broj2/imenilac2
if (ind == 2) then	
	if ( q2 > q1) then
	    qq = broj2
	    broj2 = broj1
	    broj1 = qq
	    qq = imenilac2
	    imenilac2 = imenilac1
	    imenilac1 = qq	
	 end  
end	

brojilac1 = broj1 * imenilac2
brojilac2 = broj2 * imenilac1
imenilac = imenilac1 * imenilac2

if (ind == 1) then
    sign = "+"	
    summ = brojilac1 + brojilac2
else
    sign = "-"	
    summ = brojilac1 - brojilac2
end	

temp = lib.math.gcd(imenilac, summ)

broj = summ / temp
imen = imenilac / temp         