include("names")

r = math.random(#musko_ime_nom)

ime = musko_ime_nom[r] 
imed = musko_ime_dativ[r]

pre = math.random(77) + 5;
dobio = math.random(9) + 1;
ostalo = pre + dobio

dao = math.random(ostalo - 1);
ostalo = pre + dobio - dao

