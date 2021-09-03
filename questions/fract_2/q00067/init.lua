                                                                                                             
numb = {}
quest = {}

first = -4 - math.random(3)
last =  -2 +  math.random(6) 
int = last - first + 1

nrf = 2 + math.random(8)
stf = math.random(nrf - 1)
numb[1] = first - stf/nrf
nrl = 2 + math.random(8)
stl = math.random(nrl - 2)
numb[2] = last + stl/nrl

tmp = math.floor(numb[1]*10)
rest = numb[1]*10 - tmp 
if (rest == 0) then
    quest[1] = lib.dec_to_str(lib.math.round_dec(numb[1], 1))
else
    numb[1] = first*nrf - stf 
    qq = lib.math.gcd(numb[1], nrf) 
    numb[1] = numb[1] / qq
	nrf = nrf / qq
    quest[1] = "\(\frac{" .. math.floor(numb[1]) .. "}{" .. math.floor(nrf) .. "}\)"
end

tmp = math.floor(numb[2]*10)
rest = numb[2]*10 - tmp 
if (rest == 0) then
    quest[2] = lib.dec_to_str(lib.math.round_dec(numb[2], 1))
else
    numb[2] = last*nrl + stl  
    qq = lib.math.gcd(numb[2], nrl) 
    numb[2] = numb[2] / qq
	nrl = nrl / qq	
    quest[2] = "\(\frac{" .. math.floor(numb[2]) .. "}{" .. math.floor(nrl) .. "}\)"
end

reply = "" 
for i = first,last do
    if (i < last) then
	    reply = reply .. lib.check_number(i,15) .. ", " .. "\(   \) " .. "\(   \) " 
    else
	    reply = reply .. lib.check_number(i,15)
    end		
end                       
           