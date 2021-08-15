
number = {}
sign = {}
oper = {}

min_range = 39
max_range = 60

test = 0 
for i = 1,4 do
    number[i] = min_range - math.random(max_range);
	if (i > 1 and number[i] < 0) then
	    test = 1
	end	
end
if (test == 0) then
    ch = 1 + math.random(3)
	number[ch] = -number[ch]
end

result = number[1]
for i = 1,3 do
    sign[i] = math.random(2)
	if (sign[i] == 1) then
        result = result + number[i+1]
        oper[i] = "+"
    else 
        result = result - number[i+1]
        oper[i] = "-"
    end 			
end
