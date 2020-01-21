array_number = {}
min = 20
max = 80

array_number[1] = (min + math.random(max - min)) * 10

factor = math.random(10) * 5;

sign = math.random(2);
testplus = array_number[1] + 5 * factor 
testminus = array_number[1] - 5 * factor 

if (testplus > 1000) then
   sign = 2;
end

if (testminus < 100) then
   sign = 1;
end

for i = 2,6 do 
    if (sign == 1) then   
        array_number[i] = array_number[i-1] + factor;
    else
        array_number[i] = array_number[i-1] - factor;
    end
end



