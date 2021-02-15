
include("names")
include("terms")

index_ime = math.random(#zensko_ime_nom);    
ime = zensko_ime_nom[index_ime];
padez = zensko_ime_dativ[index_ime];                   

proc = "%"

qq = {}

sign = math.random(4)
if (sign == 1) then                
    part = {6, 5, 3, 2}  
end	
if (sign == 2) then
	part = {8, 6, 4, 2}
end
if (sign == 3) then
	part = {9, 6, 3, 2}
end
if (sign == 4) then
	part = {7, 5, 3, 1}
end
	
sum = 0
for i = 1,4 do
    sum = sum + part[i]
end

ind = math.random(4)
value = lib.math.round_dec(100 * part[ind]/sum, 2)	

index = math.random(4)
numb1 = 2 + math.random(5)
quant = part[index] * numb1 * 25 

if (numb1 < 5) then
    pers1 =  msg[2]
else
    pers1 = msg[1]
end	


numb2 = 1 + math.random(11)
if (numb2 == numb1) then
    numb2 = numb2 + 2
end 

for i = 1,4 do
    qq[i] = part[i] * numb2 * 25 
end  

if (numb2 < 5) then
    pers2 =  msg[2]
else
    pers2 = msg[1]
end	
      