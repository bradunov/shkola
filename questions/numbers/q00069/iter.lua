
include("terms")                                                                                 

array_cifre = {};
array_value = {};

array_cifre[1] = math.random(2) + 7;
array_cifre[2] = math.random(8) + 1;
array_cifre[3] = math.random(4) - 1;

number = (array_cifre[2] * 10 + array_cifre[1]) * 10 + array_cifre[3];
interv = 3; 
leftb = number - interv;
rightb = number + interv;

ch = math.random(2)
if (ch == 1) then
    first = comp[1]
	last = comp[2]
else
    first = comp[2]
	last = comp[1]
end	
	
for i = 1,2*interv-1 do
    if (ch == 1) then
		array_value[i] = rightb-i;	
	else
		array_value[i] = leftb+i;	
	end
end
 