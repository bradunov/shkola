array_cifre = {};
array_value = {};
out = {};

array_cifre[1] = 2*math.random(2) + 4;
array_cifre[2] = 2*math.random(3) - 2;
array_cifre[3] = math.random(9);

if (array_cifre[3] == array_cifre[1]) then
    array_cifre[3] = array_cifre[1] - 1;
end

if (array_cifre[3] == array_cifre[2]) then
    array_cifre[3] = array_cifre[2] + 1;
end

index = 0

try = 1
for i = 1,3 do
    if (array_cifre[i] ~= 0) then
        first = array_cifre[i] * 10;
        for j = 1,3 do
            if (j ~= i) then
	        second = (first + array_cifre[j]) * 10;
	        for k = 1,3 do
                    if (k~=i) and (k~=j) then
	  	        index = index + 1
	                array_value[index] = second + array_cifre[k];
                    end
	        end	
            end
        end
    end	
end

order = lib.math.argsort(array_value)  
            
out = lib.math.random_shuffle(array_cifre);     
                                
  
               
                 
          