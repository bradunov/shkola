
include("terms")

numb = {}
quest = {""}
meas = {"cm", "m³"} 
space = "\( \ \ \ \ \) " 


numb[1] = 20 + math.random(10)
numb[2] = numb[1]/2 + 4 - math.random(5)
numb[3] = math.floor(numb[1]/3)

numb[2] = lib.math.round_dec(numb[2],1)
vol = 1
for i = 1,3 do
	vol = vol * numb[i] 
    quest[i] = elem[i] .. space .. numb[i] .. meas[1]   		
end

total = math.random(10)
proc = 0.5*(1 + math.random(6))
mas = total * (1-proc/100) * 1000000
result = math.floor(mas / vol)


            