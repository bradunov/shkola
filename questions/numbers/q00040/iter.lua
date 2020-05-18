include("terms")

index = math.random(2);
name = array_operation[index]

term1 = math.random(54) + 10;
term2 = math.random(65 - term1) + 10;


if (index == 1) then 
    if (term1 < term2) then
        temp = term1
        term1 = term2
        term2 = temp
    end		
    result = term1 - term2;  
else
    result = term1 + term2 
end
   
term3 = math.random(90 - result) + 10;
result = result + term3;
   
               
                     