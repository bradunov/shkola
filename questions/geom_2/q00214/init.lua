
include("terms")

meas = {"cm", "dm²", "dm³"} 
symb = "π"
pi = 22/7

ind = math.random(2)

numb1 = 15 + math.random(8)
numb2 = numb1 + 5 + math.random(8)

if (ind == 1) then
	r = numb2 / (2*pi)
    h = numb1	
else	
 	r = numb1 / (2*pi)
    h = numb2	
end 

area_b = r * r * pi 
area = 2*area_b + 2*r*h*pi
vol = area_b * h

area = lib.math.round_dec(area/100,1)
vol = lib.math.round_dec(vol/1000,1)
                     
      