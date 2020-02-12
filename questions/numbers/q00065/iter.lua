numb1 = math.random(9);
numb2 = math.random(9);
numb3 = math.random(10);

array_name[1] = hundreds[numb1];
array_name[2] = tens[numb2];
array_name[3] = ones[numb3];
array_name2[1] = hundreds2[numb1];
array_name2[2] = tens2[numb2];
array_name2[3] = ones2[numb3];

value = numb1*100 + numb2*10 + numb3 - 1;
reply = "answer == '" .. array_name[1] .. " " .. array_name[2] .. " " .. array_name[3] .. "' "  ..
        "|| answer == '" .. array_name2[1] .. " " .. array_name2[2] .. " " .. array_name2[3] .. "'" ;

if (numb2 == 1) then
   reply = "answer == '" .. array_name[1] .. " " .. array_name[3] .. "' " ..
           "|| answer == '" .. array_name2[1] .. " " .. array_name2[3] .. "'";
   value = numb1*100 + numb3 - 1;   
end

if (numb3 == 1) then
   reply = "answer == '" .. array_name[1] .. " " .. array_name[2] .. "' " ..
           "|| answer == '" .. array_name2[1] .. " " .. array_name2[2] .. "'";
end   

if (numb2*numb3 == 1) then
   reply = "answer == '" .. array_name[1] .. "' || answer == '" .. array_name2[1] .. "'";
end   



                  
                 




