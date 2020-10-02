
numb2 = math.random(9);
numb3 = math.random(10);

array_name[2] = tens[numb2];
array_name[3] = ones[numb3];

array_name2[2] = tens2[numb2];
array_name2[3] = ones2[numb3];

value =  numb2*10 + numb3 - 1;
reply = "answer == '" .. array_name[2] .. " " .. array_name[3] .. "' "  ..
        "|| answer == '" .. array_name2[2] .. " " .. array_name2[3] .. "'" ;
answer = "answer = '" .. array_name[2] .. " " .. array_name[3] .. "'";

if (numb2 == 1) then
   reply = "answer == '" .. array_name[3] .. "' " ..
           "|| answer == '" .. array_name2[3] .. "'";
   answer = "answer = '" .. array_name[3] .. "'";
   value =  numb3 - 1;   
end

if (numb3 == 1) then
   reply = "answer == '" .. array_name[2] .. "' " ..
           "|| answer == '" .. array_name2[2] .. "'";
   answer = "answer = '" .. array_name[2] .. "'";
end   

if (numb2 == 1 and numb3 == 1) then
   reply = "answer == '" .. array_name[3] .. "' " ..
           "|| answer == '" .. array_name2[3] .. "'";
   answer = "answer = '" .. array_name[3] .. "'";
end   

            

  



                  
                 




