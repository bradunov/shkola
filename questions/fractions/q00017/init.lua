include("imena")

r1 = math.random(#musko_ime_nom);
r2 = math.random(#musko_ime_nom-1);
if (r2 >= r1) then r2 = r2 + 1 end;
ime1 = musko_ime_nom[r1];
padezd1 = musko_ime_dativ[r1];
padezd2 = musko_ime_dativ[r2];

imenilac = math.random(5) + 1;
dao = (math.random(10));
ukupno = dao * imenilac;
ostalo = ukupno - dao;

                                 
