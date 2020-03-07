array_cifre = {}
array_value = {}
array_print = {}
            
array_cifre[1] = math.random(5) + 4;

array_cifre[2] = math.random(array_cifre[1] - 4) + 2;
if (array_cifre[2] == array_cifre[1]) then
    array_cifre[2] = array_cifre[2] - 1;
end

array_cifre[3] = math.random(array_cifre[2] - 1) - 1;
if (array_cifre[3] == array_cifre[2]) then
    array_cifre[3] = array_cifre[3] - 1;
end             
  
indices = lib.math.argsort(array_cifre)
for i =1,3 do
   array_value[i] = array_cifre[indices[i]];
end

value_min = array_value[1]*100 + array_value[2]*10 + array_value[3];
value_max = array_value[3]*100 + array_value[2]*10 + array_value[1];

if (array_value[1] == 0) then
   value_min = array_value[2]*100 + array_value[3];
   value_max = array_value[3]*100 + array_value[2]*10 ;
end

summ = value_max + value_min;       
diff = value_max - value_min;       
      
array_print = lib.math.random_shuffle(array_cifre)                   
     