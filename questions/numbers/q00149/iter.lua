
dig = 2 + math.random(3)

index = dig - 2	
decade = 10^index


cifre[dig] = math.random(9)
numb1 = cifre[dig]
for i = 1, dig-1 do
    cifre[dig-i] = math.random(10) - 1
    numb1 = numb1  * 10 + cifre[dig - i]
end	
	
if (cifre[index] >= 5) then
    cifre[index+1] = cifre[index+1] + 1
end	

for i = 1, index do 
    cifre[i] = 0
end	

numb2 = cifre[dig]
for i = 1, dig-1 do    
    numb2 = numb2 * 10 + cifre[dig - i]
end
			
factor = 2 + math.random(7)

prod = numb2 * factor

	