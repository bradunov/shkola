
letter = {"a", "b", "n", "x", "y"}
oper = {"+", "-"}

numb = {}
value = {}

choice = {""}
term = {""}
ans = {""}

index = {}
ch = {}
arg = {""}
argchk = {""}

for i = 1,5 do
    index[i] = i
end
ch = lib.math.random_shuffle(index)

ind = math.random(3)
ind = 1
indvar = math.random(2)

--[[argumenti]]--
dim = math.random(2)
choice[1] = letter[ch[1]]
arg[1] = choice[1] .. "\(^{\small" .. 2 .. "}\)"	
if (dim == 1) then
    choice[2] = ""
	arg[2] = choice[1] 
	arg[3] = ""	
else	
    choice[2] = letter[ch[2]]	
	arg[2] = choice[1] .. choice[2]	
	arg[3] = choice[2] .. "\(^{\small" .. 2 .. "}\)"	
end

--[[koeficijenti]]--			
max_range = 5
for i = 1,2 do	
	value[i] = 1 + math.random(max_range)		 
	sg = 1
	if (i == 2) then			
		sg = math.random(2)
	end	
	if (value[i] ~= 1) then
		term[i] = tostring(value[i]) 		
	else
		term[i] = ""	
		if (i == 2 and dim == 1) then      		
			term[i] = "1"		
		end			
	end
	term[i] = term[i] .. choice[i]
end	

numb[1] = value[1] * value[1] 
numb[2] = 2 * value[1] * value[2] 
numb[3] = value[2] * value[2] 

for i = 1,3 do
	if (i == 1) then
	    if (value[1] < 0) then
	        sign = oper[3-sg]
			numb[2] = - numb[2]		
		else
	        sign = oper[sg]	
        end			
	end
	val = math.abs(numb[i])
	if (val ~= 1) then
			ans[i] = tostring(numb[i]) 		
	else
		if (i == 1) then
			if (val == 1) then           		
				ans[i] = ""
			else
				ans[i] = "-"	
			end	
		else			
			if (dim == 1) then
				ans[i] = "1"
			else				
				ans[i] = ""	
			end				
		end			
	end	
	ans[i] = ans[i] .. arg[i]	
end	

if (dim == 1 and indvar == 2) then
    term[indvar] = lib.check_number(value[indvar],15)
else	
    term[indvar] = lib.check_number(value[indvar],15) .. lib.check_string(choice[indvar],15)
end
if (ind == 3) then
	term[1] = lib.check_number(value[1],15)  .. lib.check_string(choice[1],15)
	if (dim == 1) then
		term[2] = lib.check_number(value[2],15)
	else	
		term[2] = lib.check_number(value[2],15) .. lib.check_string(choice[2],15)
	end
end	
quest = "(" .. term[1] .. " " .. oper[sg] .. " " .. term[2] .. ")\(^{\small" .. 2 .. "}\)"

if (ind == 1) then  
    ans[2] = lib.check_number(numb[2],20) .. arg[2]
	if (indvar == 1) then
		ans[3] = lib.check_number(numb[3],20) .. arg[3]
	else		
		ans[1] = lib.check_number(numb[1],20) .. arg[1]    
    end		
end
if (ind == 2) then
	ans[1] = lib.check_number(numb[1],20) .. arg[1]	
	ans[3] = lib.check_number(numb[3],20) .. arg[3]    		
end
if (ind == 3) then
	if (indvar == 1) then
		ans[1] = lib.check_number(numb[1],20) .. arg[1]
	else		
		ans[2] = lib.check_number(numb[2],20) .. arg[2]    
    end		
end
result = ans[1] .. " " .. sign .. " " .. ans[2] .. " " .. oper[1] .. " " .. ans[3]
