
letter = {"a", "b", "n", "x", "y"}
oper = {"+", "-"}

numb = {}
term = {""}
value = {}
arg = {}
sign = {""}
ch = {}
valabs = {}


dim = 3
choice = letter[math.random(5)]
degr = 2

max_range = 6
for j = 1,2 do
    numb[j] = {}
	ch[j] = 0	
    for i = 1,3 do	
		numb[j][i] = math.random(max_range) - 1
        if (numb[j][i] ~= 0 and ch[j] == 0) then 
            ch[j] =  i
        end	
	end
	if (ch[j] == 0) then
	    tmp = math.random(2)
		numb[j][tmp] = math.random(max_range)
		ch[j] = tmp
	end
end	
for j = 1,2 do
	term[j] = ""
    for i = 1,3 do	
	    sg = math.random(2)		
	    st = degr + 1 - i	
		if (numb[j][i] ~= 0) then
			if (i == ch[j]) then	
				if (sg == 2) then
					term[j] = term[j] .. "-"
				end	
			else	
				term[j] = term[j] .. " " .. oper[sg]	
			end
			term[j] = term[j] .. " "	            			
			if (numb[j][i] ~= 1 or i == 3) then		        
				term[j] = term[j] .. tostring(numb[j][i])                     	
			end	
			if (i < 3) then		
				term[j] = term[j] .. choice 
				if (i < 2) then
				    term[j] = term[j] .. "\(^{\small" .. st .. "}\)"
                end					
			end
			if (sg == 2) then
				numb[j][i] = - numb[j][i]
			end	
        end			
	end
end
quest = "(" .. term[1] .. ") * (" .. term[2] .. ")"

value[1] = numb[1][1] * numb[2][1] 
value[2] = numb[1][2] * numb[2][1] + numb[1][1] * numb[2][2] 
value[3] = numb[1][1] * numb[2][3] + numb[1][2] * numb[2][2] + numb[1][3] * numb[2][1]	
value[4] = numb[1][2] * numb[2][3] + numb[1][3] * numb[2][2]
value[5] = numb[1][3] * numb[2][3] 
check = 0
for i = 1,5 do 
    value[i] = math.floor(value[i])
    if (value[i] ~= 0 and check == 0) then 
		check =  i
	end		
end

result = ""
for i = 1,5 do
	arg[i] = 2 * degr + 1 - i
	valabs[i] = math.abs(value[i])
	if (value[i] < 0) then 
		sg = 2
	else
		sg = 1
	end	
	sign[i] = oper[sg]	
	if (valabs[i] ~= 0) then 			
		if (i == check) then
			if (sg == 2) then
				result = result .. lib.check_string(sign[i],10)
			end 
		else 		
			result = result .. " " .. lib.check_string(sign[i],10)    
		end
		result = result .. " " .. lib.check_number(valabs[i],15)		
		if (i < 5) then		
			result = result .. lib.check_string(choice,10) 
			if (i < 4) then
				result = result .. lib.sup_start() .. lib.check_number(arg[i],10) .. lib.sup_end()
			end		
		end
	end
end
