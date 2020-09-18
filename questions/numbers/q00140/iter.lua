
numb1 = math.random(9);
numb2 = math.random(10);

if (numb2 == 10) then
   value = numb1*10   
   reply = "answer == '" .. tens[numb1] .. "' ";  
   ans = "answer = '" .. tens[numb1] .. "' ";  
else
   value = numb1*10 + numb2;
   reply = "answer == '" .. tens[numb1] .. ones[numb2] .. "' ";
   ans = "answer = '" .. tens[numb1] .. ones[numb2] .. "' ";    
end
    
               
     