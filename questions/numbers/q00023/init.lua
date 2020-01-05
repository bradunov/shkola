array_cifre = {}
array_value = {}


array_cifre[1] = math.random(5) + 4;

array_cifre[2] = math.random(array_cifre[1] - 1) + 1;
if (array_cifre[2] == array_cifre[1]) then
    array_cifre[2] = array_cifre[2] - 1
end

array_cifre[3] = math.random(array_cifre[2] - 1);
if (array_cifre[3] == array_cifre[2]) then
    array_cifre[3] = array_cifre[3] - 1
end

index = 0

for i = 1,3 do
    first = array_cifre[i]
    for j = 1,3 do
	  	index = index + 1
	    array_value[index] = first * 10 + array_cifre[j]
    end	
end
           
          