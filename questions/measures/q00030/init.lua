
measure = {"m", "dm", "cm","mm"}

grad2 ="²"

dim = {""}
number = {};
value = {};
out = {};

stampa = 6

for i = 1, stampa do
    ind = math.random(4)
    temp = 10^(ind-1)
    value[i] = temp + math.random(50*temp)
    if (ind > 2) then
        value[i] = value[i] * 10^(ind - 2)	   
    end   
    number[i] = value[i] * 100^(4-ind)
    dim[i] = measure[ind]
end		
 
out = lib.math.argsort(number);
