include("names")

index_ime = math.random(#musko_ime_nom);    
ime = musko_ime_nom[index_ime];                   
padez = musko_ime_gen[index_ime]; 

deo = math.random(7) + 1;
put1 = math.random(deo - 1);
put2 = put1 * (deo - 1);
put = put1 + put2

vreme = put2 * 6; 

imenilac = 60
brojilac = vreme
vremeh = brojilac/imenilac

condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(vremeh)..");"                     

        