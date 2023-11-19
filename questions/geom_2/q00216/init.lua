
meas = {"cm", "dm²", "dm³"} 
 
symb = "π"
pi = 22/7

numb = 14 + math.random(16)

area = 1.25*pi* numb *numb
vol = 0.25*pi * numb^3

area = lib.math.round_dec(area/100, 1)
vol = lib.math.round_dec(vol/1000, 1)    
   