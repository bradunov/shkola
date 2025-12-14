               
qq = { }
dim = 11
for i = 1,dim do
    qq[i] = 1 + i
end	

indj = math.random(dim - 4)
rj = qq[indj]
indw = indj + math.random(dim - indj)
rw = qq[indw]
rat = rj + rw

minb = math.ceil(50/rat)  
maxb = math.floor(100/rat) 
numb = 10 * (minb + math.random(maxb - minb))
water = numb * rw
juice = numb * rj
total = water + juice
res = (rw - rj) * numb
  