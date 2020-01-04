result = math.random(9) + 5;
number1 = math.random(result - 4);

znak = math.random(2)
if (znak == 1) then
    number2 = result + number1
    operation = "-"
else
    number2 = result - number1
    operation = "+"		  
end
                  
value = math.random(17) + 2;                

sign = "="   

if (result > value) then sign = ">"	
end

if (result < value) then sign = "<"
end
           
                                   
