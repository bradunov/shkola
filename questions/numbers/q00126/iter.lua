value = {}
number1 = {}
number2 = {}

value[1] = math.random(77777)+ 22222;
number1[1] = math.random(value[1] - 20000) + 15111;

value[2] = math.random(777777)+ 222222;
number1[2] = math.random(value[2] - 200000) + 151111;

ind = math.random(2)
bound = 10^(4+ind)

znak = math.random(2)

number2[ind] = value[ind] + number1[ind]
sign = "-"

if (znak == 2 or number2[ind] > bound) then
   number2[ind] = value[ind] - number1[ind]
   sign = "+"		  
end  
                     
                
            
                

