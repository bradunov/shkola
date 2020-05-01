                           
cifre = {}
array_print = {}
            
cifre[1] = 5 + math.random(2);
cifre[2] = 2 + math.random(3);
cifre[3] = math.random(3) - 1;      
  
value_max = cifre[1]*100 + cifre[2]*10 + cifre[3];

if (cifre[3] == 0) then
    value_min = cifre[2]*100 + cifre[1];
else	
    value_min = cifre[3]*100 + cifre[2]*10 + cifre[1];
end	

if(value_min + value_max > 1000) then
   cifre[3] = 1
   value_max = cifre[1]*100 + cifre[2]*10 + cifre[3];
   value_min = cifre[3]*100 + cifre[2]*10 + cifre[1];
end	

summ = value_max + value_min;       
diff = value_max - value_min;       
      
array_print = lib.math.random_shuffle(cifre)                           
     