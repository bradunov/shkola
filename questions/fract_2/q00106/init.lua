
numb = {7, 11, 13, 21, 27, 37, 39, 41, 73, 77, 81, 91}
period = {6, 2, 6, 6,  3, 3, 6, 5, 8, 6, 9, 6}

cifra = {}

dim = 12
order = 300 + math.random(200)
ind = math.random(dim)
denom = numb[ind]
val = 1/denom
dec = order - period[ind] * math.floor(order / period[ind])
if (dec == 0) then
	dec = period[ind]
end	
integ = math.floor(val*(10^period[ind]))

chk = math.floor(val * 10)
if (chk == 0) then
	minb = 2
    cifra[1] = 0
else
	minb = 1
end

tmp = integ
for i = minb,dec do
    st = 10^(period[ind]-i)
    cifra[i] = math.floor(tmp /st)
	rest = tmp - st * cifra[i]
	tmp = rest
end
if (chk == 0 and dec == 1) then
	result 	= 0
else
	result 	= cifra[dec]
end    