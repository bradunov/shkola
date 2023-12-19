
edge = {"R", "r", "H"} 
meas = {"cm", "cm²", "°"} 
angle = {"30", "45", "60"}

numb = {}  

pi = 22/7
r2 = math.sqrt(2)
r3 = math.sqrt(3)
min_range = 2
max_range = 8

numb[1] = min_range + math.random(max_range)
diam = 2 * numb[1]

ch = math.random(3)
if (ch == 2) then
	numb[2] = numb[1] / r2
	numb[3] = numb[2]	
else	
	numb[2] = 0.5 * numb[1]
	numb[3] = numb[2]	
	if (ch == 1) then
		numb[2] = r3 * numb[2]
    else
		numb[3] = r3 * numb[3]	
	end
end	

circ = 2 * numb[2] * pi
area = numb[2]^2 * pi

circ = lib.math.round_dec(circ,1)
area = lib.math.round_dec(area,1)
numb[3] = lib.math.round_dec(numb[3],1)
         