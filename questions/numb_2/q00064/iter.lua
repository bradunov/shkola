
number = {}
sign = {}
oper = {}
sp = "\(   \) "

min_range = 39
max_range = 60

test = 0 
for i = 1,3 do
    number[i] = min_range - math.random(max_range);
	if (i > 1 and number[i] < 0) then
	    test = 1
	end	
end
if (test == 0) then
    ch = 1 + math.random(2)
	number[ch] = -number[ch]
end

result = number[1]
for i = 1,2 do
    sign[i] = math.random(2)
	if (sign[i] == 1) then
        result = result + number[i+1]
        oper[i] = "+"
    else 
        result = result - number[i+1]
        oper[i] = "-"
    end 			
end

ind = math.random(3)
if (ind == 1) then
    answ = lib.check_number(number[1],30) .. " " .. oper[1] .. " ( " .. number[2] .. " ) " .. oper[2] .. " ( " .. number[3] .. " ) " .. sp .. " = " ..  sp .. result
end
if (ind == 2) then
    answ = number[1] .. " " .. oper[1] .. " ( " .. lib.check_number(number[2],30) .. " ) " .. oper[2] .. " ( " .. number[3] .. " ) " .. sp .. " = " ..  sp .. result
end
if (ind == 3) then
    answ = number[1] .. " " .. oper[1] .. " ( " .. number[2] .. " ) " .. oper[2] .. " ( " .. lib.check_number(number[3],30) .. " ) " .. sp .. " = " ..  sp .. result
end

