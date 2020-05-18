include("terms")
number = {};
array_value = {};
array_out = {};
result = {}
order = {};

stampa = 6;
max = stampa

for i = 1,max do
    temp = math.random(10)
    ind = 3 + math.random(2) 
	number[i] = temp * 10^ind	
end

order = lib.math.argsort(number);

dim = 1;
array_out[1] = number[order[1]]; 
for i = 2,max do
    if (number[order[i]] ~= array_out[dim] ) then
        dim = dim + 1;
        array_out[dim] = number[order[i]];
    end
end

if (dim < stampa) then
    for i = dim+1,stampa do
	    temp = (i-dim)*10 + math.random(9)
        ind = 2 + math.random(2) 
	    array_out[i] = temp * 10^ind
    end
end

order = lib.math.argsort(array_out);

form = math.random(2)
request = format[form]

if (form == 1) then
   for i=1,stampa do
	   result[i] = array_out[order[i]]
   end
else  
   for i=1,stampa do
	   result[stampa+1-i] = array_out[order[i]]
   end 
end

array_value = lib.math.random_shuffle(result);
   
              