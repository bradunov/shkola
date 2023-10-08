
include("terms")

meas = {"cm", "cm²"} 

ind = math.random(3)

numb = 2 + math.random(6)
fct = 1 + math.random(4)
	
if (ind == 1) then
	coef_b = 0.25 * math.sqrt(3)
end	
if (ind == 2) then
	coef_b = 1 
end	
if (ind == 3) then
	coef_b = 1.5 * math.sqrt(3)
end	

if (ind < 3) then
    coef_o = ind + 2
else
    coef_o = ind + 3
end	
coef_o = 0.5 * coef_o

coef = fct * coef_b/coef_o
edge = numb /math.sqrt(coef^2+0.25)
area_b = coef_b * edge^2
area = area_b
area = (1 + fct) * area_b	
area = lib.math.round_dec(area, 2)         
            