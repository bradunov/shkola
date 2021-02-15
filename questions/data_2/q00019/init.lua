
numb = {}
price = {}

ind = {1, 2, 3, 4}
qq = {2, 4, 5, 8}
out = lib.math.random_shuffle(ind)
numb[1] = qq[out[1]]
price[1] = out[1] * 20 * (30 + math.random(39))
q = lib.math.gcd(numb[1], price[1])
quant = lib.math.round(numb[1]/q)
value = lib.math.round(price[1]/q)

numb[2] = numb[1] + 1 + math.random(15 - numb[1])
price[2] = numb[2] * value / quant   

numb[3] = numb[1] + 2 + math.random(15 - numb[1])
if (numb[3] == numb[2]) then
    numb[3] = numb[3] - 2
end	
price[3] = numb[3] * value / quant   
   