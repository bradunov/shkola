
answ = {""}
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

out = lib.math.argsort(numb)

reply[1] = numb[4] .. " : " .. numb[2] .. " = " .. numb[3] .. " : " .. numb[1] 
reply[2] = numb[3] .. " : " .. numb[4] .. " = " .. numb[2] .. " : " .. numb[1] 
reply[3] = numb[2] .. " : " .. numb[1] .. " = " .. numb[3] .. " : " .. numb[4] 
reply[4] = numb[1] .. " : " .. numb[2] .. " = " .. numb[4] .. " : " .. numb[3] 

index = {1, 2, 3, 4}
value = lib.math.random_shuffle(index)
for i = 1,4 do
    answ[i] = reply[value[i]]
    if (value[i] == 1) then
	    ind = i - 1
	end	
end	
	