
answ = {"=", "<", ">"}
sign = {}

min_range = 1
max_range = 8

dim = math.random(3)
numb = min_range + math.random(max_range)
numb2 = min_range + math.random(max_range - 3)
val = numb2

for i = 1,dim do
    sg = math.random(2)
	tmp = math.sqrt(val)
	if (numb < tmp) then
		sg = 2
	end	
	if (sg == 1) then
	    val = numb - tmp
		sign[dim+1-i] = " - "
	else 
	    val = numb + tmp	
		sign[dim+1-i] = " + "		
    end
end	
val = math.sqrt(val)

ch = math.random(2)
if (ch == 1) then
    number = math.ceil(val) 
else
	number = math.floor(val)
end
if (number == 0) then 
    number = 1
end	

choice = "="   
if (val > number) then choice = ">"	
end
if (val < number) then choice = "<"
end

quest = " √(" .. numb 
if (dim > 1) then
    for i = 1,dim - 1 do
        quest = quest .. sign[i] .. " √(" .. numb   
    end	
end
quest = quest .. sign[dim] .. " √(" .. numb2
for i = 1,dim+1 do
    quest = quest .. ")"   
end	