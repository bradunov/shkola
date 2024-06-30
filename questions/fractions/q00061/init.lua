
include("names")
include("terms")

r = math.random(#zensko_ime_nom)
ime = zensko_ime_nom[r] 


fract_s = math.random(3) + 2
fract_j = math.random(10 - fract_s ) + 2

sweet = part[fract_s-2]
juice = part[fract_j-2]

fact1 = math.random(2) + 1
day = fract_s * fact1
fact2 = math.random(7) + 2
weight = fract_j * fact2

value = day * weight
value_s = fract_j * fact1 * fact2
value_j = fract_s * fact1 * fact2

result = value - value_s - value_j
 