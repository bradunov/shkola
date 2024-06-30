
quest = ""

numb2 = math.random(10);
numb3 = math.random(10);

value = (numb2-1)*10 + numb3 - 1;

array_name[1] = mid[numb3];
array_name[2] = tens[numb2];
array_name[3] = ones[numb3];

msg = " "
if (numb2 == 1) then
	quest = array_name[3]	
else	
	if (numb2 == 2) then
		quest = array_name[1]
		value = 10 + numb3 - 1;				
	else
		array_name[2] = tens[numb2-1];			
		if (numb3 == 1) then
		    array_name[3] = "";	
        else
		    array_name[3] = ones[numb3];			
		end 
		if (numb2 ~= 1 and numb3 ~= 1) then
			if (lang == 2)  then
				msg = "in"
			else
				msg = " "
			end
		end
		quest = array_name[1+lang] .. msg .. array_name[4-lang]			
    end
end
