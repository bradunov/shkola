
numb = {}
reply = {}
out = {}
value = {}
index = {}                                                                    
fact = 3 + math.random(6)

numb[1] = 5 + math.random(15)
numb[3] = 2 + math.random(numb[1]-4)
q = lib.math.gcd(numb[1], numb[3])
numb[1] = lib.math.round(numb[1]/q)
numb[3] = lib.math.round(numb[3]/q)
numb[2] = numb[1] * fact
numb[4] = numb[3] * fact   

reply[1] = "a " .. " : " .. numb[2] .. " = " .. numb[3] .. " : " .. numb[1] 
value[1] = numb[4]

reply[2] = numb[4] .. " : " .. " a " .. " = " .. numb[3] .. " : " .. numb[1] 
value[2] = numb[2]

reply[3] = numb[4] .. " : " .. numb[2] .. " = " .. " a " .. " : " .. numb[1] 
value[3] = numb[3]

reply[4] = numb[4] .. " : " .. numb[2] .. " = " .. numb[3] .. " : " .. " a" 
value[4] = numb[1]

reply[5] = numb[4] .. " : " .. numb[3] .. " = " .. " a " .. " : " .. numb[1] 
value[5] = numb[2]

reply[6] = "a " .. " : " .. numb[4] .. " = " .. numb[1] .. " : " .. numb[3] 
value[6] = numb[2]

index = {1, 2, 3, 4, 5, 6}
out = lib.math.random_shuffle(index)
for i = 1,6 do
    if (i == ITEM) then
        answ = reply[out[i]]
        result = value[out[i]]
	end	
end	 