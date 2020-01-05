include("names")

r = math.random(#musko_ime_nom)

ime = musko_ime_nom[r] 
imed = musko_ime_dativ[r]

mama = math.random(35) + 20;
tata = math.random(25) + 20;
ukupno = mama + tata

blok = math.random(ukupno - 30) + 10

test = ukupno - blok - 10
if (test < 2) then
   tata = tata + 10
   ukupno = ukupno + 10
   test = test + 10
end
gumica = math.random(ukupno - blok - 10) + 5

ostalo = mama + tata - blok - gumica 
                  