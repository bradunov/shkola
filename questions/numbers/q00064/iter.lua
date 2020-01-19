numb1 = math.random(9);
numb2 = math.random(9);
numb3 = math.random(10);

array_name[1] = hundreds[numb1];
array_name[2] = tens[numb2];
array_name[3] = ones[numb3];

value = numb1*100 + numb2*10 + numb3 - 1;

if (numb2 == 1) then
   array_name[2] = " ";
   value = numb1*100 + numb3 - 1;   
end


if (numb3 == 1) then
   array_name[3] = " ";
end   

       

                  
                 




