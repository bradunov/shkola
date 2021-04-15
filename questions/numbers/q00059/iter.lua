
answ = {"=", "<", ">"}

result = math.random(799) + 100;
number1 = math.random(900 - result) + 100;
number2 = result + number1;

znak = math.random(2)
if (znak == 1) then
    operation = "-"
else
    temp = number2
    number2 = result
    result = temp
    operation = "+"		  
end
                  
value = math.random(900) + 100;                

sign = "="   

if (result > value) then sign = ">"	
end

if (result < value) then sign = "<"
end
                   
                                   

           
                                   
