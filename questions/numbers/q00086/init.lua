
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
ime3 = musko_ime_nom[r[3]]
if (lang == 1) then
	padezg1 = musko_ime_gen[r[1]]
	padezg2 = musko_ime_gen[r[2]]   
else
	padezg1 = ime1
	padezg2 = ime2  
end	

value = {}
add = {}
 
ind = math.random(2);

value[1] = math.random(150) + 150;
add[1] = math.random(value[1] - 150) + 50;

if (ind == 1) then
   value[2] = value[1] + add[1];
   oper1 = sign[1]
else
   value[2] = value[1] - add[1];
   oper1 = sign[2]
end

result = value[1] + value[2]

value[3] = math.random(949 - result) + 50;

if (value[3] > value[2]) then
    add[2] = value[3] - value[2]
    oper2 = sign[1]
else
    add[2] = value[2] - value[3]
    oper2 = sign[2]
end

result = result + value[3]

