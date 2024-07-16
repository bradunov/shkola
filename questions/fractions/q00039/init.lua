
include("names")

r1 = math.random(#musko_ime_nom)
r2 = math.random(#musko_ime_nom-1)
if (r2 >= r1) then r2 = r2 + 1 end
include("names")
r1 = math.random(#musko_ime_nom)
r2 = math.random(#musko_ime_nom-1)
if (r2 >= r1) then r2 = r2 + 1 end
ime1 = musko_ime_nom[r1]
ime2 = musko_ime_nom[r2] 

brojilac1 = math.random(7);
brojilac2 = math.random(5);

if (brojilac1 == brojilac2) then 
   brojilac2 = brojilac2 + 1;
end

imenilac1 = brojilac1 + 1;
imenilac2 = brojilac2 + 1;

factor = (math.random(4) + 2) * 5;

put1 = brojilac1 * factor;
put2 = brojilac2 * factor;

brzina1 = imenilac1 * factor;
brzina2 = imenilac2 * factor;
             
if (brzina1 < brzina2) then 
   brzina = brzina2 - brzina1; 
   ime = ime2;
else
   brzina = brzina1 - brzina2;
   ime = ime1;
end                 
