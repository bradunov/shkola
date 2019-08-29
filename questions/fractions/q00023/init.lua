include("names")
r1 = math.random(#musko_ime_nom)
r2 = math.random(#musko_ime_nom-1)
if (r2 >= r1) then r2 = r2 + 1 end
ime1 = musko_ime_nom[r1]
ime2 = musko_ime_nom[r2] 
padezg1 = musko_ime_gen[r1]
padezg2 = musko_ime_gen[r2]                 
padezd1 = musko_ime_dativ[r1]; 
padezd2 = musko_ime_dativ[r2];

