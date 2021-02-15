
include("names")

qq = {}
ime = {}
numb = {}
part = {}
sum = {}
index = {}
value = {}

dimnames = 6
for i=1,dimnames do
    index[i] = i
end	
r = lib.math.random_shuffle(index)
for i = 1,3 do
    ime[i] = musko_ime_nom[r[i]]
end
            
sum = {10, 16, 20, 25, 40, 50}
sign = math.random(6)
max = math.floor(sum[sign]*0.3) 
for i = 1,2 do          
    part[i] = 1 + math.random(max)
end 
part[3] = sum[sign] - part[1] - part[2]

qq = lib.math.argsort(part)
if (part[qq[1]] == part[qq[2]]) then
    part[qq[1]] = part[qq[1]] - 1
    part[qq[2]] = part[qq[2]] + 1
end	
if (part[qq[2]] == part[qq[3]]) then
    part[qq[2]] = part[qq[2]] - 1
    part[qq[3]] = part[qq[3]] + 1
end

fact = 5 + math.random(5)
for i = 1,3 do	
    numb[i] = part[i] * 5 * fact
end

total = 1000*(4 + math.random(45))

for i = 1,3 do
    value[i] = total * part[i] / sum[sign]
end	   
             
            
                     
          



