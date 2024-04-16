
cifre = {}
out= {}
           
cifre[1] = math.random(4);
cifre[2] = cifre[1] + math.random(5 - cifre[1]);

out = lib.math.random_shuffle(cifre)
       
value_min = cifre[1]*10 + cifre[2] 
value_max = cifre[2]*10 + cifre[1]

summ = value_max + value_min;       
diff = value_max - value_min;       
 