        
vol = {}

fact1 = 15 + math.random(15)
fact2 = fact1 + 10 + math.random(20)

vol[1] = 5 * fact1
vol[2] = 5 * fact2

price = 3 *(3 + math.random(5))
numb1 = price * fact1
comp = price * fact2

ind = math.random(2)

if (ind == 1) then
    numb2 = comp + price * math.random(4)
	res = numb2/vol[2] - numb1/vol[1]
else
    numb2 = comp - price * math.random(4)	
    res = numb1/vol[1] - numb2/vol[2]
end	
        
result = lib.math.round_dec(res,2)     

    


