
answ = {"=", "<", ">"}

number1 = 3 + math.random(7);
number2 = 3 + math.random(17 - number1);

znak = math.random(2)
if (znak == 1) then
    result = number2 + number1
    operation = "+"
else
    if (number2 < number1) then
        temp = number2
	    number2 = number1
	    number1 = temp
    end	
    result = number2 - number1
    operation = "-"		  
end
                  
value = math.random(17) + 2;   

sign = "="   

if (result > value) then sign = ">"	
end

if (result < value) then sign = "<"
end
     