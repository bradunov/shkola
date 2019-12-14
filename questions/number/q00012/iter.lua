array_number = {}

array_number[1] = math.random(5)
factor = math.random(6) + 1;


for i = 2,7 do    
    array_number[i] = array_number[i-1]+factor;
end


