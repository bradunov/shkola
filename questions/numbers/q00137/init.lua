include("terms")

number = {};
value = {};
out = {};
result = {}
order = {};

stampa = 6;
max = stampa * 2

for i = 1,max do
    number[i] = 10 - math.random(19);
end

order = lib.math.argsort(number);

dim = 1;
out[1] = number[order[1]]; 
for i = 2,max do
    if (number[order[i]] ~= out[dim] ) then
        dim = dim + 1;
        out[dim] = number[order[i]];
    end
end

if (dim < stampa) then
    for i = dim+1,stampa do
	    out[i] = number[max-order[i]]
    end
end

order = lib.math.argsort(out);

form = math.random(2)
request = format[form]

if (form == 1) then
   for i=1,stampa do
	   result[i] = out[order[i]]
   end
else  
   for i=1,stampa do
	   result[stampa+1-i] = out[order[i]]
   end 
end

value = lib.math.random_shuffle(result);
              