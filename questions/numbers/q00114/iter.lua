
if (lang == 0) then
    msg = " "
else
    msg = ""
end	

if (ITEM == 1) then
    reply = "answer == '" .. digit10 .. " " .. msg_thousand[2] .. " " .. digit2 .. "' " ..
            "|| answer == '" .. digit10_L .. " " .. msg_thousand[2] .. " " .. digit2_L .. "'" ;
    answer = "answer = '" .. digit10 .. " " .. msg_thousand[2] .. " " .. digit2 .. "' ";
end
    

if (ITEM == 2) then	
    reply = "answer == '" .. digit10 .. " " .. msg_thousand[2] .. " " .. digit10 .. "' " .. 
            "|| answer == '" .. digit10_L .. " " .. msg_thousand[2] .. " " .. digit10_L .. "'";
    answer = "answer = '" .. digit10 .. " " .. msg_thousand[2] .. " " .. digit10 .. "' ";
end 

if (ITEM == 3) then		
	if (lang == 2)  then
		reply = "answer == '" .. digit10 .. " " .. msg_thousand[2] .. " " .. digit2 .. "in" .. digit10 .."'" ..
				"|| answer == '" .. digit10_L .. " " .. msg_thousand[2] .. " " .. digit2_L .. "in" .. digit10_L .."'";
		answer = "answer = '" .. digit10 .. " " .. msg_thousand[2] .. " " .. digit2 .. "in" .. digit10 .."'";	
	else
		reply = "answer == '" .. digit10 .. " " .. msg_thousand[2] .. " " .. digit10 .. " " .. digit2 .."'" ..
				"|| answer == '" .. digit10_L .. " " .. msg_thousand[2] .. " " .. digit10_L .. " " .. digit2_L .."'";
		answer = "answer = '" .. digit10 .. " " .. msg_thousand[2] .. " " .. digit10 .. " " .. digit2 .."'";	
	end
end

if (ITEM == 4) then	
    value[4] = numb*10000 + numb*100;
    reply = "answer == '" .. digit10 .. " " .. msg_thousand[2] .. " " .. digit .. msg .. name_2 .."'" ..
            "|| answer == '" .. digit10_L .. " " .. msg_thousand[2] .. " " .. digit_L .. msg .. name_2 .."'";	
    answer = "answer = '" .. digit10 .. " " .. msg_thousand[2] .. " " .. digit .. msg .. name_2 .."'";
end

if (ITEM == 5) then
	if (lang == 2)  then
		reply = "answer == '" .. digit2 .. "in" .. digit10 .. " " .. name_3 .. " " .. digit .. msg .. name_2 .. " " .. digit2 .."'" ..
				"|| answer == '" .. digit2_L .. "in" .. digit10_L .. " " .. name_3 .. " " .. digit_L .. msg .. name_2 .. " " .. digit2_L .."'";
		answer = "answer = '" .. digit2 .. "in" .. digit10 .. " " .. name_3 .. " " .. digit .. msg .. name_2 .. " " .. digit2 .."'";
	else
		reply = "answer == '" .. digit10 .. " " .. digit .. " " .. name_3 .. " " .. digit .. msg .. name_2 .. " " .. digit2 .."'" ..
				"|| answer == '" .. digit10_L .. " " .. digit_L .. " " .. name_3 .. " " .. digit_L .. msg .. name_2 .. " " .. digit2_L .."'";
		answer = "answer = '" .. digit10 .. " " .. digit .. " " .. name_3 .. " " .. digit .. msg .. name_2 .. " " .. digit2 .."'";
	end
end	

if (ITEM == 6) then
    reply = "answer == '" .. digit10 .. " " .. msg_thousand[2] .. " " .. digit .. msg .. name_2 .. " " .. digit10 .."'" ..	         		                     
            "|| answer == '" .. digit10_L .. " " .. msg_thousand[2] .. " " .. digit_L .. msg .. name_2 .. " " .. digit10_L .."'";
    answer = "answer = '" .. digit10 .. " " .. msg_thousand[2] .. " " .. digit .. msg .. name_2 .. " " .. digit10 .."'"; 
end
                


