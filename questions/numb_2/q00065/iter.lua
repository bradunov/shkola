
include("terms")

number = {}
sign = {}

for i = 1,3 do
    sign[i] = math.random(2);
end

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

if (sign[1] == 1) then
    term1 = number[1] + number[2]
else 
    term1 = number[1] - number[2]
end 			
if (sign[2] == 1) then
    term2 = number[3] + number[4]
else 
    term2 = number[3] - number[4]
end 
if (sign[3] == 1) then
    result = term1 + term2
else 
    result = term1 - term2
end 

         