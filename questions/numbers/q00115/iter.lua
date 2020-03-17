cifre = {}
array_print = {}
            
number1 = 4 + math.random(5);
number2 = math.random(5) - 1;

ind = 0
for i = 1,8 do
    if (ind ==  number1 or ind ==  number2) then 
        ind = ind + 1
    end		
    cifre[i] = ind
	ind = ind + 1
end	           
 
value_min = cifre[1]
value_max = cifre[8]  

for i = 2,8 do
   value_min = value_min *10 + cifre[i];
   value_max = value_max *10 + cifre[9-i];
end

if (cifre[1] == 0) then
    value_min = cifre[2] * 10 
    for i =3,8 do
       value_min = value_min *10 + cifre[i];
	end   
end 
             
array_print = lib.math.random_shuffle(cifre)                   
                    
   