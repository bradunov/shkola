
dig1 = 2 + math.random(3)
dig2 = 2 + math.random(3)
if (dig1 < dig2) then
    dig = dig1
else
    dig = dig2
end

index = dig - 2	
decade = 10^index


cifre[dig1] = math.random(9)
numb1[1] = cifre[dig1]
for i = 1, dig1-1 do
    cifre[dig1-i] = math.random(10) - 1
    numb1[1] = numb1[1]  * 10 + cifre[dig1 - i]
end	
	
if (cifre[index] >= 5) then
    cifre[index+1] = cifre[index+1] + 1
end	

for i = 1, index do 
    cifre[i] = 0
end	

numb1[2] = cifre[dig1]
for i = 1, dig1-1 do    
    numb1[2] = numb1[2]  * 10 + cifre[dig1 - i]
end
		
	
cifre[dig2] = math.random(9)
numb2[1] = cifre[dig2]
for i = 1, dig2-1 do
    cifre[dig2-i] = math.random(10) - 1
    numb2[1] = numb2[1]  * 10 + cifre[dig2 - i]
end		
       
if (cifre[index] >= 5) then
    cifre[index+1] = cifre[index+1] + 1
end	

for i = 1, index do 
    cifre[i] = 0
end	

numb2[2] = cifre[dig2]
for i = 1, dig2-1 do    
    numb2[2] = numb2[2]  * 10 + cifre[dig2 - i]
end   

if (numb1[2] > numb2[2]) then
    summ = numb1[2] - numb2[2]
    sign = "-"
else
    summ = numb1[2] + numb2[2]
    sign = "+"	
end
	