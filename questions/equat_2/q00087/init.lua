
include("terms")
include("names")

dimnames = 6
index = {}
for i=1,dimnames do
    index[i] = i
end
	
r = lib.math.random_shuffle(index)

ime1 = musko_ime_nom[r[1]]
ime2 = musko_ime_nom[r[2]] 
padezd1 = musko_ime_dativ[r[1]]
padezg2 = musko_ime_gen[r[2]]   

numb = {}
ad = {}
arg = {"x", "y"}
equ = {""}


max_range = 5
fct = 1 + math.random(max_range)
ad[2] = 2 + math.random(max_range)
tmp = math.ceil((fct + 1) * ad[2] / fct)
numb[2] = tmp + 2 + math.random(max_range)
numb[1] = fct * numb[2] - (fct + 1) * ad[2]
ad[1] = numb[1] - numb[2]
if (ad[1] == 0) then
	numb[2] = numb[2] + math.random(2)
	numb[1] = fct * numb[2] - (fct + 1) * ad[2]
	ad[1] = numb[1] - numb[2]  
end

if (ad[1] > 0) then
    ind = 1
	sg = "+"
else
    ind = 2
	ad[1] = - ad[1]
	sg = "-"
end	

if (ad[1] == 1) then
    obj = msg[1]
else
    obj = msg[2]
end	

for i = 1,2 do
	equ[i] = lib.check_string(arg[1], 15) 
	if (i == 1) then
		equ[i] = equ[i] .. " = " .. lib.check_string(arg[2],15) .. " " .. lib.check_string(sg,10) .. " " .. lib.check_number(ad[1], 20) 
    else		
	    equ[i] = equ[i] .. " " .. lib.check_string("+",10) .. " " .. lib.check_number(ad[2], 20) .. " = " .. lib.check_number(fct,20) .. " (" .. lib.check_string(arg[2],15) .. lib.check_string("-",15) .. lib.check_number(ad[2], 20) .. " )" 
	end	
end