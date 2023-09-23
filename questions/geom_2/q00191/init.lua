
numb = {}
quest = {""}
meas = {"cm", "m", "cm³", "g", "t" } 

numb[1] = 5*(8 + math.random(10))
tmp = math.floor(numb[1]/5)
numb[2] = 0.2*(10 + math.random(tmp))
numb[2] = lib.math.round_dec(numb[2],2)

vol =  numb[1] * numb[1] * numb[2] * math.sqrt(3) * 150
dens = 2.4 + 0.1*math.random(8)
numb[3] = vol * dens/1000000
numb[3] = lib.math.round_dec(numb[3],1)
result = 1000000 * numb[3]/vol
result = lib.math.round_dec(result,1)           
            
         
