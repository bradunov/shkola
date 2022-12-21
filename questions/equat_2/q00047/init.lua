
include("names")
include("terms")

rz = math.random(#zensko_ime_nom);
rm = math.random(#musko_ime_nom)

imez = zensko_ime_nom[rz];
imem = musko_ime_nom[rm] 
imein = musko_ime_instrum[rm]
imeat = atrib[rm]

meas = {"km", "m"}
equ = ""

dist = 500 + 10 * math.random(200)
distkm = lib.math.round_dec(0.001 * dist,2)
v1 = 20 + math.random(40)
v2 = 80 + math.random(60)
v1km = lib.dec_to_str(lib.math.round_dec(0.1 * v1, 1))
v2km = lib.dec_to_str(lib.math.round_dec(0.1 * v2, 1))
v1 = 100 * v1
v2 = 100 * v2
path = lib.math.round_dec((v1 * dist)/(v1 + v2), 1)

equ =  lib.frac_start() .. lib.check_string("p", 20) .. lib.frac_mid() .. lib.check_number(v1,50) .. lib.frac_end() .. " = " ..  lib.frac_start() .. lib.check_number(dist) .. lib.check_string("-", 15) .. lib.check_string("p", 20) .. lib.frac_mid() .. lib.check_number(v2,50) .. lib.frac_end()    
         