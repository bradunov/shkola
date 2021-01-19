
ind = math.random(2)

number1 = 101 + math.random(9999)
number2 = 101 + math.random(number1 - 99)  

deg1 = math.random(2)  
deg2 = math.random(2)

if (deg1 ~= deg2) then
    deg = 2
    if(deg1 < deg2) then
	   number1 = number1 * 10
	else
       number2 = number2 * 10
    end
else
    deg = deg1
end	

if (ind == 2) then
    if (number1 < number2) then 
	    temp = number1
		number1 = number2
		number2 = temp
	end	
	value = number1 - number2
    sign = "-"	
else
    value = number1 + number2
    sign = "+"	
end	

number1 = lib.dec_to_str(number1/10^deg)    
number2 = lib.dec_to_str(number2/10^deg)
value = value/10^deg    
          
         
   