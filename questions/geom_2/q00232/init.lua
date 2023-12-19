
meas = {"dm", "dm²", "dm³"}
pi = 22/7

numb = 2 + math.random(8)
area = 4 * numb^2 * pi
vol = area * numb / 3

area = lib.math.round_dec(area,2)
vol = lib.math.round_dec(vol,2)
 