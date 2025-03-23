
include("terms")

meas = {"cm", "cm²"} 
ans = ""

ind = math.random(3)
numb = 2 + math.random(10)

if (ind < 3) then
	area = numb * numb	
	if (ind == 1) then
		area= area * math.sqrt(3)
	else
		area= area * (1 + math.sqrt(3))
	end	
	area = lib.math.round_dec(area, 2)    
	ans = text[1]	
	measure = meas[2]
else
    area = 0
	ans = text[2] 
	measure = meas[1]	
end    