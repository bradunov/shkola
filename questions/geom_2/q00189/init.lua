
numb = {}
meas = {"cm", "m", "dm³"} 

numb[1] = 1 + math.random(4)
numb[2] = 10 *(5 + math.random(4))
numb[4] = 0.5*math.random(5)
numb[4] = lib.math.round_dec(numb[4],1)

vol = numb[1] * numb[2] * numb[4] * 10
numb[3] = numb[4] + 0.2 * math.random(4)
numb[3] = lib.math.round_dec(numb[3],1)
proc = lib.math.round_dec(numb[4]/numb[3]*100,1)
   
