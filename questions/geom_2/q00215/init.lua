
include("terms")

meas = {"cm", "cm²", "cm³"} 
 
symb = "π"
pi = 22/7

ind = math.random(3)

edge = 4 + math.random(8)

tmp = 1
if (ind == 1) then
	tmp = 0.25* math.sqrt(3)
end	
if (ind == 3) then
	tmp = 1.5 * math.sqrt(3)
end	
area_o = edge * edge
if (ind < 3) then
    coef = ind + 2
else
    coef = ind + 3
end	
area_p = (2*tmp + coef) * edge^2
vol_p = tmp * edge^3

numb = edge
if (ind == 2) then
   numb = edge/ math.sqrt(2)
end  
if (ind == 1) then
	numb = edge/ math.sqrt(3)
end	 
area_v = 2*pi* numb *(numb + edge)
vol_v = pi * numb^2 * edge

prop_p = area_p / area_v 
prop_v = vol_p / vol_v

area_v = lib.math.round_dec(area_v, 1)
vol_v = lib.math.round_dec(vol_v, 1)
area_p = lib.math.round_dec(area_p, 1)
vol_p = lib.math.round_dec(vol_p, 1)
prop_p = lib.math.round_dec(prop_p*100, 1)
prop_v = lib.math.round_dec(prop_v*100, 1)
