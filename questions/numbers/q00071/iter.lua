array_number = {}
min = 20
max = 70

array_number[1] = (min + math.random(max - min)) * 10
factor = math.random(10) * 5;

for i = 2,6 do    
    array_number[i] = array_number[i-1]+factor;
end


