
answ = {"=", "<", ">"}

result = math.random(79) + 10;
number1 = math.random(90 - result) + 10;
number2 = result + number1

znak = math.random(2)
if (znak == 1) then
    operation = "-"
else
    temp = number2
    number2 = result
    result = temp
    operation = "+"		  
end
                  
value = math.random(90) + 10;                

sign = "="   

if (result > value) then sign = ">"	
end

if (result < value) then sign = "<"
end
           
                                   

           
                                   
