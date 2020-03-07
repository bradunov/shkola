include("names")

r = math.random(#musko_ime_nom)
ime = musko_ime_nom[r] 

box = math.random(8) + 3;
factor = math.random(7) + 2;
kliker = box * factor;

part = math.random(box - 3) + 2;
value = factor * part;

name = "kutije"
if (part > 4) then
   name = "kutija"
end                 

  

     