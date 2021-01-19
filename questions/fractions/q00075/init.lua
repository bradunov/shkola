
array_cifre = {};
array_temp = {};
array_value = {};
array_out = {};
order = {};
value = {}

stampa = 10;

array_cifre[1] = math.random(5) + 4;
array_cifre[2] = math.random(4);
array_cifre[3] = 0;

index = 0;

for i = 1,3 do
    if(array_cifre[i] ~= 0) then
       sub1 = array_cifre[i];
       for j = 1,3 do
          sub2 = sub1 * 10 + array_cifre[j];
          for k = 1,3 do
	          index = index + 1; 
              array_temp[index] = sub2 * 10 + array_cifre[k];         
          end
       end  
    end	
end

order = lib.math.argsort(array_temp);

int = 1;
array_out[1] = array_temp[order[1]]; 
for i = 2,index do
    if (int < stampa) then
        if (array_temp[order[i]] ~= array_out[int] ) then
           int = int + 1;
           array_out[int] = array_temp[order[i]];
        end
    end
end

array_value = lib.math.random_shuffle(array_out);

for i = 1, int do
    array_out[i] = array_out[i] / 100
    array_value[i] = array_value[i] / 100	
end	

for i = 1, int do
    value[i] = lib.dec_to_str(array_value[i])	
end	        
   