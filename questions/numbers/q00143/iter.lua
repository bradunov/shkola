cifre = {}
dig = 3 + math.random(4)

cifre[1] = math.random(9)
number1 = cifre[1]
for i = 2,dig do
    cifre[i] = math.random(10) - 1
	number1 = number1  * 10 + cifre[i]
end            
 
term1 = math.random(13) - 1
term2 = math.random(23) - 1 

if (term1 * term2 == 0) then 
    term1 = 5
end	

degree1 = 2 + math.random(dig - 3)
degree2 = math.random(degree1 - 2) - 1
number2 = term1 * 10^degree1 + term2  * 10^degree2

if (number1 < number2) then
    temp = number1
	number1 = number2
	number2 = temp
end	

ind = math.random(2)
if (ind == 2) then
    value = number1 - number2
    sign = "-"
else
    value = number1 + number2
    sign = "+"	
end	

if (ITEM ==1 or ITEM == 3 or ITEM == 5) then
   answ = tostring(math.floor(number1)) .. " " .. sign .. " " .. tostring(lib.check_number(number2,60)) .. " = " .. tostring(math.floor(value))
else
   answ = tostring(lib.check_number(number1,60)) .. " " .. sign .. " " .. tostring(math.floor(number2)) .. " = " .. tostring(math.floor(value))
end   
                     