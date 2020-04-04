temp = {}
cifre = {};
out = {};
order = {}

max = 8

for i = 1,10 do
   temp[i] = i - 1
end

out = lib.math.random_shuffle(temp)
                 
for i = 1,max do
    cifre[i] = out[i]
end                  
                  
order = lib.math.argsort(cifre)                   
                  
numb = cifre[order[max]]

for i = 1,2 do
    numb = numb * 10 + cifre[order[max-i]]
end	
value_max = numb * 10 + cifre[order[max - 3]] 
value_max1 = numb * 10 + cifre[order[max - 4]] 


if (cifre[order[1]] == 0) then    
    numb = (cifre[order[2]] * 10 + cifre[order[1]]) * 10 + cifre[order[3]]  
else
    numb = (cifre[order[1]] * 10 + cifre[order[2]]) * 10 + cifre[order[3]]       
end

value_min = numb * 10 + cifre[order[4]]
value_min1 = numb * 10 + cifre[order[5]]

summ_max = value_max + value_max1
summ_min = value_min  + value_min1
diff_max = value_max  - value_min 
   