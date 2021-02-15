
include("names")
include("terms")

index_ime = math.random(#musko_ime_nom);    
name = musko_ime_nom[index_ime];   

numb1 = 1 + math.random(3)
numb2 = numb1 + 1

aver = 75 + math.random(15)
value = aver - 1 - math.random(8)
result = numb2 * aver - numb1 * value

if (result > 100) then
    temp = result - 100
	cor = math.ceil(temp/numb1)
	value = value + cor + 1
	result = numb2 * aver - numb1 * value
end	

if (numb2 == 3) then
    pad = msg[1]
else 
    if (numb2 == 4) then 
        pad = msg[2]	
	else
	    pad = msg[3]
	end
end