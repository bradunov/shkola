
dig = 2 + math.random(5)

cifre[dig] = math.random(9)
number1 = cifre[dig]
for i = 1, dig-1 do
    cifre[dig-i] = math.random(10) - 1
    number1 = number1  * 10 + cifre[dig - i]
end	
	
index = math.random(dig-1)

decade = 10^index	

if (cifre[index] >= 5) then
    cifre[index+1] = cifre[index+1] + 1
end	

for i = 1, index do 
    cifre[i] = 0
end	

number2 = cifre[dig]
for i = 1, dig-1 do    
    number2 = number2  * 10 + cifre[dig - i]
end
		
	
	
       
   
