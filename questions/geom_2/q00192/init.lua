
numb = {}
quest = {""}
meas = {"mm", "cm", "cm³", "g", "kg" } 

numb[1] = 5*(3 + math.random(7))
numb[2] = 0.5*(39 + math.random(61))
numb[2] = lib.math.round_dec(numb[2],1)

vol =  numb[1] * numb[1] * numb[2]  / 200
dens = 7.3 + 0.1*math.random(6)
density = lib.dec_to_str(lib.math.round_dec(dens,1))
numb[3] = vol * dens/1000
numb[3] = lib.math.round_dec(numb[3],1)       
  
       