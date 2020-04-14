numb1 = math.random(10);
numb2 = math.random(10);


if (numb1 * numb2 == 10^2) then
    value = 100
    array_name[1] = "C";
    array_name[2] = "";	
	
else	

    array_name[1] = tens[numb1];
    array_name[2] = ones[numb2];

    if (numb1 == 10) then   
       term1 = 0
    else
       term1 = numb1*10
    end

    if (numb2 == 10) then   
       term2 = 0
    else
       term2 = numb2
    end	
  
    value = term1 + term2
end	   
