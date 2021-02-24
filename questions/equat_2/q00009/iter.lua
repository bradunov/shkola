
term = (111 + math.random(888))
numb[2] = (50 + math.random(term - 100))/10
numb[3] = (11 + math.random(1111))/10
term = term/10

ind = math.random(2)
sign = math.random(2)

if (ind == 1) then
    numb[4] = term  
    if (sign == 1) then
        numb[1] = numb[3] * numb[4] - numb[2]
    else
        numb[1] = numb[3] * numb[4] + numb[2]
    end		
else
    numb[1] = term
    if (sign == 1) then
        sum = numb[1] + numb[2]
    else
        sum = numb[1] - numb[2]	
    end		
	numb[4] = numb[3] * sum
end	

for i = 1,4 do
    value[i] = lib.dec_to_str(lib.math.round_dec(numb[i], 2))
end	
       