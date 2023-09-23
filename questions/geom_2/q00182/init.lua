
include("terms")

meas = {"cm", "cm²"} 

ind = math.random(3)
numb = 2 + math.random(10)
	
if (ind == 1) then
	coef_b = 0.5 * math.sqrt(3)
end	
if (ind == 2) then
	coef_b = 2 
end	
if (ind == 3) then
	coef_b = 3 * math.sqrt(3)
end	
if (ind < 3) then
    coef_o = ind + 2
else
    coef_o = ind + 3
end	

area = (coef_b + coef_o) * numb * numb
area = lib.math.round_dec(area, 2)         
                          
            