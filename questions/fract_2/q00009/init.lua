
include("names")

index_ime = math.random(#musko_ime_nom);    
ime = musko_ime_nom[index_ime];                   
padez = musko_pridev[index_ime];

deo = math.random(7) + 2;
put1 = (math.random(10)) * 35;
put = put1 * deo;
put2 = put - put1


imenilac = 1000
brojilac = put
putkm = put/imenilac

condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(putkm)..");"       

swhole = math.floor(putkm)
snum = lib.math.round((putkm - swhole) * imenilac)
g = lib.math.gcd(snum, imenilac)

sln = "numerator="..tostring(snum/g)..";denominator="..tostring(imenilac/g)..";whole="..tostring(swhole)..";"
                       
       
              

                  
                     