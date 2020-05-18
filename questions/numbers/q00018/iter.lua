include("terms")

index = math.random(2);
name = array_operation[index]

term1 = 5 + math.random(7)
term2 = math.random(term1 - 5) 

temp = term1 + term2
if (temp > 17) then
    term1 = term1 - 2
	temp = temp - 2
end	

term3 = math.random(18 - temp) + 2

if (index == 1) then   
    rezultat = term1 - term2 + term3  
else
    rezultat = term1 + term2 + term3
end