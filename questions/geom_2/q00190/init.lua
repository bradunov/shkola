
numb = {}
meas = {"cm", "m", "dm³"} 

numb[1] = 0.5*(1 + math.random(4))
numb[2] = 5 *(12 + math.random(10))
numb[4] = 0.5*(1+ math.random(5))

vol = numb[1] * numb[2] * numb[4] * 10
numb[3] = numb[4] + 0.4 * math.random(5)

tmp = math.floor(numb[2]/5)
edge = 5 *(5 + math.random(tmp - 10)) 
cub = edge*edge*edge
dif = cub/(numb[1] * numb[2] * 100)
dif = lib.math.round_dec(dif,1)
if (dif >= (numb[3] - numb[4])*100) then
    numb[3] = numb[4] + math.ceil(dif/100)
end	
result = numb[4]*100 + dif
result = lib.math.round_dec(result,1)

for i = 1,3 do 
	if (i ~= 2) then
		tmp = math.floor(numb[i])
		if (numb[i] ~= tmp) then
			numb[i] = lib.math.round_dec(numb[i],1)
		else
			numb[i] = tmp
		end
	end		
end      
