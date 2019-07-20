imenilac = (math.random(4)) + 1;
brojilac = (math.random(imenilac-1)) ;

deo = 60 * brojilac / imenilac;

fact = (math.random(9));
put = deo * fact;

brojp = brojilac * fact;   

vrednost = put / 60               

condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(vrednost)..");"                  
