
quest = ""

numb1 = math.random(9);
numb2 = math.random(10);
numb3 = math.random(10);

value = numb1*100 + (numb2-1)*10 + numb3 - 1;

array_name[1] = hundreds[numb1];
array_name[2] = tens[numb2];
array_name[3] = ones[numb3];
array_name[4] = mid[numb3];
array_name2[1] = hundreds2[numb1];
array_name2[2] = tens2[numb2];
array_name2[3] = ones2[numb3];
array_name2[4] = mid2[numb3];

msg = ""

if (numb2 == 2) then
	reply = "answer == '" .. array_name[1] .. " " .. array_name[4] .. "' " ..
			"|| answer == '" .. array_name2[1] .. " " .. array_name2[4].. "'" ;
	answer = "answer = '" .. array_name[1] .. " " .. array_name[4] .. "'";
else
	if (numb2 == 1) then
		array_name[2] = "";
		array_name2[2] = "";		
	else
		array_name[2] = tens[numb2-1];
		array_name2[2] = tens2[numb2-1];	
    end	
	if (numb3 == 1) then
	   array_name[3] = "";
	   array_name2[3] = "";		   
	end 
	if (numb2 ~= 1 and numb3 ~= 1) then
		if (lang == 2)  then
			msg = "in"
		else
			msg = " "
		end
	end
	reply = "answer == '" .. array_name[1] .. " " .. array_name[1+lang] .. msg .. array_name[4-lang] .. "' "  ..
			"|| answer == '" .. array_name2[1] .. " " .. array_name2[1+lang] .. msg .. array_name2[4-lang] .. "'" ;
	answer = "answer = '" .. array_name[1] .. " " .. array_name[1+lang] .. msg .. array_name[4-lang] .. "'";			
end
quest = lib.check_string(reply,200,answer)
                 