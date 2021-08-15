
answ = {"=", "<", ">"}

min_range = 39
max_range = 60
  
number1 = min_range - math.random(max_range);
number2 = min_range - math.random(max_range);
if (number1 >= 0 and number2 >= 0) then
	number1 = -number1
end

znak = math.random(2)
if (znak == 1) then
    result = number2 + number1
    operation = "+"
else
    result = number2 - number1
    operation = "-"		  
end
                  
value = min_range - math.random(max_range);   

sign = "="   

if (result > value) then sign = ">"	
end

if (result < value) then sign = "<"
end
     