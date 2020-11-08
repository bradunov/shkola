
prime = {11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97} 

number1 = 11 + math.random(48)
number2 = number1 + 5 + math.random(93 - number1)

for  i = 1,21 do
     if (number1 == prime[i]) then 
         number1 = number1 + 1
     end
     if (number2 == prime[i]) then 
         number2 = number2 + 1
     end
end	 

max = math.floor(number1/2)
answ = lib.check_number(1,20)

for i = 2,max do  
    j = max + 2 - i  
    factor = math.floor(number1/j) 
	rest1 = number1 - factor*j
	if (rest1 == 0) then
        rest2 = number2 - math.floor(number2/factor) * factor
        if (rest2 == 0) then
        answ = answ .. ", " .. lib.check_number(factor,20)
		end	
	end		   
end

if (number2 >= number1) then
    rest1 = number2 - number1 * math.floor(number2/number1)
	if (rest1 == 0) then
        answ = answ .. ", " .. lib.check_number(number1,20)
	end
end	
 

    

