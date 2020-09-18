
numb1 = math.random(9);
numb2 = math.random(10);
numb3 = math.random(10);


value = numb1*100 + numb2*10 + numb3; 
reply = "answer == '" .. hundreds[numb1] .. tens[numb2] .. ones[numb3] .. "' ";  
ans = "answer = '" .. hundreds[numb1] .. tens[numb2] .. ones[numb3] .. "' ";  

if (numb2 == 10 and numb3 ~= 10) then
   value = numb1*100 + numb3;    
   reply = "answer == '" .. hundreds[numb1] .. ones[numb3] .. "' ";  
   ans = "answer = '" .. hundreds[numb1] .. ones[numb3] .. "' ";  
end

if (numb2 ~= 10 and numb3 == 10) then
   value = numb1*100 + numb2*10;   
   reply = "answer == '" .. hundreds[numb1] .. tens[numb2] .. "' ";  
   ans = "answer = '" .. hundreds[numb1] .. tens[numb2] .. "' ";  
end

if (numb2 == 10 and numb3 == 10) then
   value = numb1*100   
   reply = "answer == '" .. hundreds[numb1] .. "' ";  
   ans = "answer = '" .. hundreds[numb1] .. "' ";   
end            
               
     
     