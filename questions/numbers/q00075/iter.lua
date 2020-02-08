temp = math.random(777)+ 222;
number2 = math.random(temp - 200) + 101;

znak1 = math.random(2)
number1 = temp + number2
sign1 = "-"


if (znak1 == 2 or number1 > 1000) then
   number1 = temp - number2
   sign1 = "+"		  
end
                  
number3 = 100 + math.random(temp - 200);                     

znak2 = math.random(2);                
            
value = temp - number3
sign2 = "-"

if (znak2 == 1 or value < 100) then
   value = temp + number3
   sign2 = "+"	
   if (value > 1000) then
      value = temp - number3	
      sign2 = "-" 
   end 
end               

                   
                
            
                

