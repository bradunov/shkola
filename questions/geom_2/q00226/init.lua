
meas = {"cm", "cm²", "cm³"}  
numb = {}
 
symb = "π"
pi = 22/7

fct = 1 + math.random(5)

numb[1] = 4 + math.random(8)
numb[2] = 4 + math.random(8)
numb[3] = math.sqrt(numb[1]^2 + numb[2]^2)	
numb[4] = math.ceil(pi *numb[3]^2)                     --[[ P kruga ]]--
numb[3] = math.sqrt(numb[4]/pi)
numb[1] = numb[3] / fct 
numb[2] = math.sqrt(numb[3]^2 - numb[1]^2)

area_b = pi * numb[1]^2
area = area_b + numb[4] / fct
vol = area_b * numb[2] /3

area = lib.math.round_dec(area, 1)
vol = lib.math.round_dec(vol, 1)    
     