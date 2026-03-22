
meas = {"dl", "l"}

rat = {}
part = {}
tmp = {}

rat[2] = 1 + math.random(4)
rat[1] = rat[2] + math.random(4)
qq = lib.math.gcd(rat[1], rat[2])
for i = 1,2 do
    rat[i] = rat[i]/qq
end	
sum = rat[1] + rat[2]

fct = 1 + math.random(4)
total = fct * sum
for i = 1,2 do
    part[i] = fct * rat[i]
	tmp[i] = part[i]
end	

if (total > 15) then
    total = lib.math.round_dec(0.1 * total,1)
	for i = 1,2 do
	    part[i] = lib.math.round_dec(0.1 * part[i],1)
	end	
end	
if (total > 3) then
	ind = 2
else
	ind = 1
	for i = 1,2 do
		part[i] = tmp[i]
	end		
end	   