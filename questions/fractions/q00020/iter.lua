include("imena")

index_ime = math.random(#musko_ime_nom);    
ime = musko_ime_nom[index_ime];                   
padez = niz_padez[index_ime]; 

deo = math.random(8) + 1;
put1 = (math.random(10)) * 25;
put = put1 * deo;
put2 = put - put1


imenilac = 1000
brojilac = put
putkm = put/imenilac

condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(putkm)..");"       
