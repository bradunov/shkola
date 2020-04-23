include("names")

index_ime = math.random(#zensko_ime_nom);    
ime = zensko_ime_nom[index_ime];                   
padez = zensko_ime_dativ[index_ime];  

imenilac1 = math.random(3)+1
imenilac2 = math.random(4)+3
strane = 420

dan1 = strane/imenilac1
dan2 = strane/imenilac2
ostalo = strane - dan1 - dan2
provera =  ostalo/strane 

                    
is_ok = "is_ok = math.eq(numerator/denominator, "..tostring(provera)..");"
            

g = lib.math.gcd(ostalo, strane)
sln = "numerator="..tostring(ostalo/g)..";denominator="..tostring(strane/g)..";"

