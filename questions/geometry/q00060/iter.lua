include("terms")

number = math.random(11); 
if (number == 6) then 
    number = 9
end	

if (number == 1) then
    name = hour_arr[1]
end
if (number > 1 and number < 5) then
    name = hour_arr[2]
end
if (number > 4) then
    name = hour_arr[3]
end	

ans = {""}
if (number < 3  or number > 9) then
    reply = "answer == '" .. angle_arr[1] .. "' "  ..
        "|| answer == '" .. angle_arr[2] .. "'" ;
    ans = "answer = '" .. angle_arr[3] .. "' "		
else
    reply = angle_arr[4]
end  

if (number == 3 or number == 9) then
    reply = angle_arr[5]
end	
                                                      
