
quest = ""

numb1 = math.random(9);
numb2 = math.random(10);
numb3 = math.random(10);

value = numb1*100 + (numb2-1)*10 + numb3 - 1;

array_name[1] = hundreds[numb1];
array_name[2] = tens[numb2];
array_name[3] = ones[numb3];
array_name[4] = mid[numb3];

msg = ""

if (numb2 == 2) then
	quest = array_name[1] .. " " .. array_name[4]
else
	if (numb2 == 1) then
		array_name[2] = "";		
	else
		array_name[2] = tens[numb2-1];	
    end	
	if (numb3 == 1) then
	   array_name[3] = "";		   
	end 
	if (numb2 ~= 1 and numb3 ~= 1) then
		if (lang == 2)  then
			msg = "in"
		else
			msg = " "
		end
	end
	quest = array_name[1] .. " " .. array_name[1+lang] .. msg .. array_name[4-lang]			
end
