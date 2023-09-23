
include("terms")

meas = {"cm", "cm²"} 

ind = math.random(3)
ch = math.random(2)
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

edge = numb * coef_o/coef_b
if (ch == 1) then
    edge = edge/fct
else
    edge = edge*fct	
end	
edge = lib.math.round_dec(edge, 2)
area = (2*coef_b*edge + coef_o*numb) * edge
area = lib.math.round_dec(area, 2)         
                          