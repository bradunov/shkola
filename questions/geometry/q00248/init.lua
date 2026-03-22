
pi = 22/7
meas = {"dm", "m"}

rot = 400 + 5 * math.random(100)

numb = 5 + math.random(6)

ind = math.random(2)
if (ind == 2) then
    numb = lib.math.round_dec(0.1 * numb, 1)
end	

circ = numb * pi * rot * 60

value = circ / 1000
if (ind == 1) then
    value = value/ 10
end	

value = lib.math.round_dec(value,1)
    
            