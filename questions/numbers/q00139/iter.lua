numb1 = math.random(10);
numb2 = math.random(10);
numb3 = math.random(10);

if (numb1 * numb2 * numb3 == 10^3) then
    numb3 = math.random(9) 
end	

array_name[1] = hundreds[numb1];
array_name[2] = tens[numb2];
array_name[3] = ones[numb3];

if (numb1 == 10) then   
    term1 = 0
else
    term1 = numb1*100
end

if (numb2 == 10) then   
    term2 = 0
else
    term2 = numb2*10
end	

if (numb3 == 10) then   
    term3 = 0
else
    term3 = numb3
end

value = term1 + term2 + term3;

                  
