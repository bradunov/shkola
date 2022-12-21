
include("names")
include("terms")

rz = math.random(#zensko_ime_nom);
rm = math.random(#musko_ime_nom)

imez = zensko_ime_nom[rz];
imem = musko_ime_nom[rm] 
imeg = musko_ime_gen[rm]

godm = math.random(7) + 4;
factor = 1 + math.random(godm - 2);
godz = godm - factor;
ukupno = godm + godz

if (factor < 5) then
    razlika = array_padez[1]
else	
    razlika = array_padez[2]
end
       