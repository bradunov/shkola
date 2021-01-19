
ind = math.random(2)

number1 = 101 + math.random(9999)
number2 = math.random(99) * 100

temp = number1 % 10
if (temp == 0) then
    number1 = number1 + math.random(9)
end	

dc = 1
if (ind == 2) then
    if (number1 < number2) then
        temp = number2  
		number2 = number1
		number1 = temp	
        dc = 2		
    end
	value = number1 - number2
    sign = "-"	
else
    value = number1 + number2
    sign = "+"	
end	

deg = math.random(2)  

number1 = number1/10^deg    
number2 = number2/10^deg 
value = value/10^deg          

if (dc == 1) then
   number1 = lib.dec_to_str(number1)
else
   number2 = lib.dec_to_str(number2)  
end   