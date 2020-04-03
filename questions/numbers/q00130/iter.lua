cifre = {}
dig = 2 + math.random(5)

cifre[1] = math.random(9)
number1 = cifre[1]
for i = 2,dig do
    cifre[i] = math.random(10) - 1
	number1 = number1  * 10 + cifre[i]
end            
                
degree = 2 + math.random(4)
number2 = (2 + math.random(13)) * 10^degree

if (number1 > number2) then
    value = number1 - number2
    sign = "-"
else
    value = number1 + number2
    sign = "+"	
end	
                