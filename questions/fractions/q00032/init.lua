
include("names")

r = math.random(#musko_ime_nom)
name = musko_ime_nom[r] 

meas = "g"
box = 200 + math.random(100);
numb = 2 * (10 + math.random(10));
marb = 0.5 * (40 + math.random(39));
total = box + numb * marb
if (total ~= lib.math.round(total)) then
	total = lib.math.round_dec(total, 1)
end
