
answ = {"=", "<", ">"}
sign = {}

min_range = 1
max_range = 8

dim = 1 + math.random(2)
numb = min_range + math.random(max_range)
numb2 = min_range + math.sqrt(numb - min_range)
val = numb2

for i = 1,dim do
    sg = math.random(2)
	if (val < 0) then
		sg = 2
	end	
	if (sg == 1) then
	    val = numb - math.sqrt(val)
		sign[dim+1-i] = " - "
	else 
	    val = numb + math.sqrt(val)	
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

choice = "="   
if (val > number) then choice = ">"	
end
if (val < number) then choice = "<"
end

quest = " √(" .. numb 
for i = 2,dim do
    quest = quest .. sign[i] .. " √(" .. numb   
end	
for i = 1,dim do
    quest = quest .. ")"   
end	
            