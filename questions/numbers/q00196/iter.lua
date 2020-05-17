
sign = {"+", "-"}

number1 = 5111 + math.random(5888)
temp = math.floor(number1/100)
 
fact1 = 20 + math.random(temp - 30)
fact2 = 15 - math.random(30)
if (fact2 == 0) then  
    fact2 = fact2 - 1
end	
term1 = fact1 * 100
number2 = term1 + fact2

result = number1 - number2

if (fact2 < 0) then
    term2 = - fact2
	ind = 1
	value1 = number1 + term2
	value2 = number2 + term2
else
    term2 = fact2
    ind = 2
	value1 = number1 - term2
	value2 = number2 - term2	
end	
        


          
         
                     