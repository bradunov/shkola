
include("names")

index_ime = math.random(#zensko_ime_nom);    
ime = zensko_ime_nom[index_ime];
padez = zensko_ime_dativ[index_ime];       

perc = {}
perc[2] = math.random(3)
perc[1] = perc[2] + math.random(4)
for i = 1,2 do
	perc[i] = 5 * perc[i]
end
value = 1
for i = 1,2 do
    value = value * (100 - perc[i])
end
total = value / 100
       