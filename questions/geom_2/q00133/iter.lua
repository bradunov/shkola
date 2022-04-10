
numb = {} 
value = {}

ind = math.random(dim)
basic = lib.math.round_dec(180 / total[ind], 2)

mid = math.floor(total[ind]/3)
numb[1] = math.random(mid)
numb[2] = math.random(mid)
numb[3] = total[ind] - numb[1] - numb[2]

for i = 1,3 do
    value[i] = numb[i] * basic
end                 
            

