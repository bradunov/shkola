
include("names")
include("terms")

rz = math.random(#zensko_ime_nom);
rm = math.random(#musko_ime_nom)

imez = zensko_ime_nom[rz];
imem = musko_ime_nom[rm] 
imeg = musko_ime_gen[rm]

test = 6
godz = 0
godm = 80
nr = 0
for i = 1,test do
	if ( godm > 70 or godz < 1) then
		nr = nr + 1
		factor = 1 + math.random(4);
		enum = 1 + math.random(2);
		tmp =  math.random(3)
		denom = factor * enum - tmp		
		dif = (1 + math.random(3));
		godz = (denom - enum) * dif;
		dif = dif * tmp;		
		godm = factor * godz;
		qq = lib.math.gcd(enum, denom)
		enum = enum/qq
		denom = denom/qq
	end
end
if (dif < 5) then
    period = array_padez[1]
else	
    period = array_padez[2]
end          
     