
letter = {"a", "b", "n", "x", "y"}
oper = {"+", "-"}

numb = {}
term = {""}
value = {}
arg = {}
sign = {""}
ch = {}
valabs = {}
quest = {""}
coef = {}
op = {}

dim = 3
choice = letter[math.random(5)]
degr = 2
sum = 1 + math.random(2)

max_range = 7

for k = 1,3 do
	quest[4-k] = ""
	if (k <= sum) then
		value[k] = {}
		for j = 1,2 do
			numb[j] = {}
			ch[j] = 0
			term[j] = ""			
		end	
		square = math.random(2)
		if (square == 1) then	
			for j = 1,2 do
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
			value[k][1] = numb[1][1] * numb[2][1] 
			value[k][2] = numb[1][2] * numb[2][1] + numb[1][1] * numb[2][2] 
			value[k][3] = numb[1][1] * numb[2][3] + numb[1][2] * numb[2][2] + numb[1][3] * numb[2][1]	
			value[k][4] = numb[1][2] * numb[2][3] + numb[1][3] * numb[2][2]
			value[k][5] = numb[1][3] * numb[2][3] 
			quest[4-k] = quest[4-k] .. "(" .. term[1] .. ") * (" .. term[2] .. ")"	
		else		
			for i = 1,3 do
				numb[1][i] = math.random(max_range)							
			end
			ch[1] = math.random(2)	
			numb[1][3-ch[1]] = 0
			sg = math.random(2)
			for i = 1,3 do				
				if (numb[1][i] ~= 0) then
					if (numb[1][i] ~= 1 or i == 3) then		        
						term[1] = term[1] .. tostring(numb[1][i]) 	
					end	
					if (i < 3) then		
						term[1] = term[1] .. choice 
						if (i == 1) then
							term[1] = term[1] .. "\(^{\small" .. 2 .. "}\)"
						end					
					end					
				end	
				if (i == 2) then	
					term[1] = term[1] .. " " .. oper[sg]	
				end	
			end			
			if (sg == 2) then
				numb[1][3] = - numb[1][3]
			end					
			value[k][1] = numb[1][1] * numb[1][1] 
			value[k][2] = 2 * numb[1][1] * numb[1][2] 
			value[k][3] = 2 * numb[1][1] * numb[1][3] + numb[1][2] * numb[1][2] 	
			value[k][4] = 2 * numb[1][2] * numb[1][3] 
			value[k][5] = numb[1][3] * numb[1][3] 	
			quest[4-k] = quest[4-k] .. "(" .. term[1] .. ")\(^{\small" .. 2 .. "}\)"
		end
		op[k] = math.random(2)	
		if (k < sum) then
			quest[4-k] = quest[4-k] .. " " .. oper[op[k]] .. " "
		else
			quest[4-k] = quest[4-k] .. " = "	
		end	
    end	
end

check = 0
for i = 1,5 do 
    coef[i] = value[1][i]
    if (sum ~= 1) then
		for k = 2,sum do
			if (op[k-1] == 1) then	
				coef[i] = coef[i] + value[k][i] 
			else
				coef[i] = coef[i] - value[k][i] 
			end
		end	
	end	
    coef[i] = math.floor(coef[i])
    if (coef[i] ~= 0 and check == 0) then 
		check =  i
	end		
end

result = ""
for i = 1,5 do
	arg[i] = 2 * degr + 1 - i
	valabs[i] = math.abs(coef[i])
	if (coef[i] < 0) then 
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
		result = result .. lib.check_number(valabs[i],20)		
		if (i < 5) then		
			result = result .. lib.check_string(choice,10) 
			if (i < 4) then
				result = result .. lib.sup_start() .. lib.check_number(arg[i],10) .. lib.sup_end()
			end		
		end
	end
end