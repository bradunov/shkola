
temp = {}
cifre = {};
out = {};
order = {}
numb = {}

max = 8

for i = 1,10 do
   temp[i] = i - 1
end

out = lib.math.random_shuffle(temp)
                 
for i = 1,max do
    cifre[i] = out[i]
end                  
                  
order = lib.math.argsort(cifre)                   
                  
for i = 1,2 do
	numb[i] = cifre[order[i]]
	for j = 1,3 do
		numb[i] = numb[i]  + cifre[order[i+2*j]] * 10^j
	end	
end	
value_max1 = numb[1] 
value_max = numb[2] 
summ_max = value_max + value_max1

for i = 1,2 do
	if (cifre[order[i]] == 0) then    
		numb[i] = cifre[order[i+2]] * 10
		for j = 2,3 do
			numb[i] = numb[i] * 10 + cifre[order[i+2*j]]
		end			
	else
		numb[i] = cifre[order[i]]
		for j = 1,3 do
			numb[i] = numb[i] * 10 + cifre[order[i+2*j]]
		end	
	end		
end
value_min1 = numb[1]
value_min = numb[2]
summ_min = value_min  + value_min1

if (cifre[order[1]] == 0) then    
	numb[2] = cifre[order[2]]
else
	numb[2] = cifre[order[1]]
end
numb[1] = cifre[order[max]]
for j = 1,3 do
	numb[1] = numb[1] * 10 + cifre[order[max-j]]
	if (cifre[order[1]] == 0 and j == 1) then
		numb[2] = numb[2] * 10
	else
		numb[2] = numb[2] * 10 + cifre[order[1+j]]
	end
end			
diff_max = numb[1]  - numb[2] 

