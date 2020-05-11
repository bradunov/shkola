
number = {}
reply = ""

max = 10 - ITEM
deg = 10^(ITEM + 1)
term = (11 + math.random(79)) * deg
add = math.floor(max/2) + 1
form = (2 + ITEM) * 10

number[1] = term - math.random(add)
reply = tostring(math.floor(number[1])) .. ", "
for i = 2,max-1 do   
    number[i] = number[i-1] + 1
	reply = reply .. lib.check_number(number[i],form) .. ", "
end
number[max] = number[max-1] + 1

if (ITEM == 4) then
    reply = reply .. tostring(math.floor(number[max])) .. "."
else   
    reply = reply .. tostring(math.floor(number[max])) .. ";"
end	                                                                                                                                                                           
       