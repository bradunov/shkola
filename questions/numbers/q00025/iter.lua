value = math.random(9) + 5;
number1 = math.random(value - 4);

znak = math.random(2)

if (value + number1 > 20) then
    znak = 2
end	

if (znak == 1) then
	number2 = value + number1
	sign = "-"
else
	number2 = value - number1
    sign = "+"		  
end
        

