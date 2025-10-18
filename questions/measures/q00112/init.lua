
include("names")

rz = math.random(#zensko_ime_nom); 
ime = zensko_ime_nom[rz];

meas = {"kg", "g"}

temp = 3 + math.random(7)
result = 5 * temp;
numb = 1 + math.random(12 - temp);
period = 5 * math.random(20) 

quant = period * numb * result
quant = quant/1000
quant = lib.math.round_dec(quant, 3)
