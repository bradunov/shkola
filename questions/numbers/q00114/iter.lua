
if (ITEM == 1) then
    reply = "answer == '" .. digit10 .. " hiljada " .. digit2 .. "' " ..
            "|| answer == '" .. digit10_L .. " hiljada " .. digit2_L .. "'" ;
    solution = "answer = '" .. digit10 .. " hiljada " .. digit2 .. "'; "
end
    

if (ITEM == 2) then	
    reply = "answer == '" .. digit10 .. " hiljada " .. digit10 .. "' " .. 
            "|| answer == '" .. digit10_L .. " hiljada " .. digit10_L .. "'";
    solution = "answer = '" .. digit10 .. " hiljada " .. digit10 .. "'; "
end 

if (ITEM == 3) then		
    reply = "answer == '" .. digit10 .. " hiljada " .. digit10 .. " " .. digit2 .."'" ..
            "|| answer == '" .. digit10_L .. " hiljada " .. digit10_L .. " " .. digit2_L .."'";
    solution = "answer = '" .. digit10 .. " hiljada " .. digit10 .. " " .. digit2 .."';"
end

if (ITEM == 4) then	
    value[4] = numb*10000 + numb*100;
    reply = "answer == '" .. digit10 .. " hiljada " .. digit .. " " .. name_2 .."'" ..
            "|| answer == '" .. digit10_L .. " hiljada " .. digit_L .. " " .. name_2 .."'";	
    solution = "answer = '" .. digit10 .. " hiljada " .. digit .. " " .. name_2 .."';"
end

if (ITEM == 5) then
    reply = "answer == '" .. digit10 .. " " .. digit .. " " .. name_3 .. " " .. digit .. " " .. name_2 .. " " .. digit2 .."'" ..
	        "|| answer == '" .. digit10_L .. " " .. digit_L .. " " .. name_3 .. " " .. digit_L .. " " .. name_2 .. " " .. digit2_L .."'";
    solution = "answer = '" .. digit10 .. " " .. digit .. " " .. name_3 .. " " .. digit .. " " .. name_2 .. " " .. digit2 .."';"
end	

if (ITEM == 6) then
    reply = "answer == '" .. digit10 .. " hiljada " .. digit .. " " .. name_2 .. " " .. digit10 .."'" ..	         		                     
            "|| answer == '" .. digit10_L .. " hiljada " .. digit_L .. " " .. name_2 .. " " .. digit10_L .."'";
    solution = "answer = '" .. digit10 .. " hiljada " .. digit .. " " .. name_2 .. " " .. digit10 .."';"
end
                


