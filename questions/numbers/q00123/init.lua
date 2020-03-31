array_cifre = {};
temp = {};
array_value = {};
array_out = {};
order = {};

stampa = 8;
index = stampa * 5

array_cifre[1] = math.random(2) + 7;
array_cifre[2] = math.random(array_cifre[1] - 6) + 4;
array_cifre[3] = math.random(array_cifre[2] - 4) + 2;
array_cifre[4] = math.random(array_cifre[3] -1);

for i = 1,index do
    temp = lib.math.random_shuffle(array_cifre)
    array_value[i] = ((temp[1] * 10 + temp[2]) * 10 + temp[3]) * 10 + temp[4]
end	

order = lib.math.argsort(array_value);

int = 1;
array_out[1] = array_value[order[1]]; 
for i = 2,index do
    if (int < stampa) then
        if (array_value[order[i]] ~= array_out[int] ) then
           int = int + 1;
           array_out[int] = array_value[order[i]];
        end
    end
end

array_value = lib.math.random_shuffle(array_out);
