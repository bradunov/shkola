
meas = {"cm", "m", "g", "kg", "cm³"} 
 
numb = {}
symb = "π"
pi = 22/7

numb[1] = 15 + math.random(15)
numb[2] = 0.5 * (2 + math.random(8))
dens = 0.01 * (60 + math.random(30))

vol = 0.25 * pi * numb[1]^2 * numb[2] * 100
weight = dens * vol

weight = lib.math.round_dec(weight/1000, 1)    
       
        