
include("names")

r = math.random(#musko_ime_nom)
ime = musko_ime_nom[r]

imenilac1 = math.random(7) + 1;
imenilac2 = math.random(5) + 1;
factor = math.random(10);
cinilac =(imenilac1*imenilac2 - imenilac1 - imenilac2 + 1)
ostalo = cinilac * factor
ukupno =  imenilac1 * imenilac2 * factor
