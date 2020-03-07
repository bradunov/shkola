array_operation = {"Razlici", "Zbiru"}

index = math.random(2);
name = array_operation[index]

term1 = math.random(9) + 3
term2 = math.random(term1 - 3) 
term3 = math.random(7) + 2

if (index == 1) then   
    rezultat = term1 - term2 + term3  
else
    rezultat = term1 + term2 + term3
end
       