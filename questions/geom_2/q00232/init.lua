
meas = {"dm", "dm²", "dm³"}
pi = 22/7

numb = 2 + math.random(8)
rad = 0.5 * numb
area = 4 * rad^2 * pi
vol = area * rad / 3

area = lib.math.round_dec(area,2)
vol = lib.math.round_dec(vol,2)
 