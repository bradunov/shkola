
proc = "%"

enum = {}
denom = {}
per = {}
ind = {}

for i = 1,2 do
    ind[i] = math.random(2)
    denom[i] = 10^ind[i] 
    enum[i] =  math.random(denom[i] - 2);	
    per[i] = lib.math.round(enum[i] / denom[i] * 100)
end

if (per[1] < per[2]) then
    temp = per[1]
	per[1] = per[2]
	per[2] = temp
end	

result = enum[1]*enum[2] * 100 / (denom[1]* denom[2])
round = ind[1] + ind[2] - 2
result = lib.math.round_dec(result, round)
               