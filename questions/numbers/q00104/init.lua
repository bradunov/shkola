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

value = {}
add = {}
 
sign = {"više", "manje"}            
ind = math.random(2);

number = math.random(34) + 21;
factor = 2+ math.random(6);

if (ind == 1) then
   value[1] = number;
   value[2] = number * factor
   oper1 = sign[1]
else
   value[1] = number * factor;
   value[2] = number 
   oper1 = sign[2]
end

value[3] = value[1] + value[2] 
result = value[3] * 2



