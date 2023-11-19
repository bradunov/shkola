
include("terms")		

numb = {} 
fct = {} 
 
pi = 22/7
r2 = math.sqrt(2)
r3 = math.sqrt(3)

min_range = 2
max_range = 8
numb[1] = min_range + math.random(max_range)

ch = math.random(3)  
if (ch == 1) then
	fct[2] = r3
	fct[3] = 2 	
else	
	if (ch == 3) then
		fct[2] = 1 / r3
		fct[3] = 2 / r3	
	else
		fct[2] = 1 
		fct[3] = r2	
	end
end	
for i = 2,3 do
	numb[i] = fct[i] * numb[1]
end

area_k = pi * numb[1] * (numb[1] + numb[3])
vol_k = pi * numb[1]^2 * numb[2] /3

ind = math.random(3)
if (ind == 2) then
	fct[1] =  r2
	coef = 4
else
	if (ind == 1) then	
		fct[1] =  r3
		coef = 3
    else		
		fct[1] =  1
		coef = 6
	end
end	
edge = fct[1]*numb[1]

base = edge^2
if (ind ~= 2) then
    base = r3 * base
	if (ind == 1) then	
		base = 0.25 * base
	else
		base = 1.5 * base	
	end
end	
tmp = math.sqrt(numb[3]^2 - 0.25*edge^2)
area_p = base + coef * 0.5 * edge * tmp
vol_p = base * numb[2] /3

prop_p = area_p / area_k 
prop_v = (vol_k - vol_p)/ vol_k 
prop_p = lib.math.round_dec(prop_p*100, 1)
prop_v = lib.math.round_dec(prop_v*100, 1)
      