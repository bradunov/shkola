array_value = {}

number = math.random(9);

index = 0

for i = 1,10 do
    im1 = i - 1
    if (im1 ~= number) then
	   index = index + 1
	   array_value[index] = number * 10 + im1
    end	
end
           
for i = 1,9 do
    if (i ~= number) then
	   index = index + 1
	   array_value[index] = i * 10 + number
    end	
end

indices = lib.math.argsort(array_value);
                  
                  