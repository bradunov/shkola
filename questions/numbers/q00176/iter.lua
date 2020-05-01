
index = math.random(2) 	
decade = 10^index

cifre[3] = math.random(7)
numb1[1] = cifre[3]
for i = 1, 2 do
    cifre[3-i] = math.random(10) - 1
    numb1[1] = numb1[1]  * 10 + cifre[3 - i]
end	
	
if (cifre[index] >= 5) then
    cifre[index+1] = cifre[index+1] + 1
end	

for i = 1, index do 
    cifre[i] = 0
end	

numb1[2] = cifre[3]
for i = 1, 2 do    
    numb1[2] = numb1[2]  * 10 + cifre[3 - i]
end
		
temp = cifre[3]	
cifre[3] = math.random(9 - temp)
numb2[1] = cifre[3]
for i = 1, 2 do
    cifre[3-i] = math.random(10) - 1
    numb2[1] = numb2[1]  * 10 + cifre[3 - i]
end		
       
if (cifre[index] >= 5) then
    cifre[index+1] = cifre[index+1] + 1
end	

for i = 1, index do 
    cifre[i] = 0
end	

numb2[2] = cifre[3]
for i = 1, 2 do    
    numb2[2] = numb2[2]  * 10 + cifre[3 - i]
end   

if (numb1[2] > numb2[2]) then
    summ = numb1[2] - numb2[2]
    sign = "-"
else
    summ = numb1[2] + numb2[2]
    sign = "+"	
end
	