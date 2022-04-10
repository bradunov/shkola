
meas = {"cm", "cm\(\small ^2\)"} 
dif = {}
r2 = lib.math.round_dec(math.sqrt (2),3)

--[[ a ]]-- 
dif[1] = 1 + math.random(8)
edge = dif[1] / (r2 - 1)
edge = lib.math.round_dec(edge, 3) 
circ = 4 * edge
area = edge * edge
edge = lib.math.round_dec(edge, 1) 
circ = lib.math.round_dec(circ, 1)
area = lib.math.round_dec(area, 1)

--[[ b]]--
fct = 1 + math.random(8)
dif[2] = 4 * fct * (r2 - 1)
dif[2] = lib.math.round_dec(dif[2], 1) 
      