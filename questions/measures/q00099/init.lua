include("terms")

measure = {"kg", "t"}
ord = {1,2,3,4}

ind = math.random(4)

out = lib.math.random_shuffle(ord)

for i = 1,4 do
    if (out[i] == ind) then
	    index = i-1
	end
end	


weight = {}
mes = {}

number = 6 + math.random(4)

for i = 1,2 do
    weight[i] = number * 10^(i-1)
	mes[i] = measure[1]
	weight[i+2] = number * 10^(i-1)
	mes[i+2] = measure[2]
end                                            

answ = {""}
for i = 1,4 do
    answ[i] = tostring(math.floor(weight[out[i]])) .. " " .. mes[out[i]]
end
              
       
