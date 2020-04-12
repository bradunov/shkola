operation = {"dodaš", "oduzmeš"}

number1 = 111 + math.random(3889)
number2 = 111 + math.random(3889)

if (number1 < number2) then
    max = number2
else
    max = number1	
end
	
value = max + 100 + math.random(4999 - max)

ind = math.random(2)

if (ind == 1) then
    sign1 = operation[1]
	sign2 = operation[2]
	result = value + number2 - number1
else
    sign1 = operation[2]
	sign2 = operation[1]
	result = value - number2 + number1
end   	
	

