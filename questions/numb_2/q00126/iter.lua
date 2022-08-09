
letter = {"a", "b", "n", "x", "y",  ""} 
oper = {"+", "-"}

numb = {}
value = {}

term = {""}
quest = {""}

index = {}
idx = {}
choice = {}

--[[argumenti]]--	
for i = 1,6 do
    index[i] = i
end
idx = lib.math.random_shuffle(index)
choice[1] = letter[idx[1]]
choice[2] = letter[idx[2]]

max_range = 6
quest = ""

for j = 1,2 do
	numb[j] = {}
	term[j] = ""
	for i = 1,2 do	
		numb[j][i] = math.random(max_range) 
		sg = math.random(2)	
		if (sg == 2) then
			term[j] = term[j] .. oper[sg]
		else
			if (i == 2) then
				term[j] = term[j] .. oper[sg]	
            end				
		end				
		if (numb[j][i] ~= 1 or idx[i] == 6 ) then		        
			term[j] = term[j] .. tostring(numb[j][i])                     	
		end	
		term[j] = term[j] .. choice[i]
		if (sg == 2) then
			numb[j][i] = - numb[j][i]	
		end						
	end			
end
quest = quest .. "(" .. term[1] .. ")\(^{\small" .. 2 .. "}\) - (" .. term[2] .. ")\(^{\small" .. 2 .. "}\)"

value[1] = numb[1][1] * numb[1][1] - numb[2][1] * numb[2][1]
value[2] = 2 * (numb[1][1] * numb[1][2] - numb[2][1] * numb[2][2]) 
value[3] = numb[1][2] * numb[1][2] - numb[2][2] * numb[2][2]

result = ""
ch = 0

for i = 1,3 do
    if (value[i] == 0) then
	    ch = ch + 1
    end
end
if (ch == 3) then
    result = result .. lib.check_number(0,15)
else		
	for i = 1,3 do
		valabs = math.abs(value[i])	
		if (value[i] ~= 0) then 
			ch = 1		
			if (value[i] < 0) then
				result = result .. lib.check_string("-",10)
			else
				if (i > 1 and ch ~=0) then		
					result = result .. lib.check_string("+",10)	
				end				
			end 
			result = result .. lib.check_number(valabs,15)	
			if (idx[1] ~= 6) then		
				if (i == 1) then
					result = result .. lib.check_string(choice[1],10) .. lib.sup_start() .. lib.check_number(2,10) .. lib.sup_end()	
				end 
				if (i == 2) then
					result = result .. lib.check_string(choice[1],10) 	
				end
			end	
			if (idx[2] ~= 6) then
				if (i == 2) then
					result = result .. lib.check_string(choice[2],10) 	
				end
				if (i == 3) then 		
					result = result .. lib.check_string(choice[2],10) .. lib.sup_start() .. lib.check_number(2,10) .. lib.sup_end() 			
				end	
			end	
		end
	end
end

            