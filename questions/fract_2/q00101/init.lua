
include("terms")

food = {}
numb = {}

food[1] = 4.5 + 0.1 * math.random(20)
food[1] = lib.math.round_dec(food[1], 2)   
food[2] = 4.9 + 0.1 * math.random(15)
food[2] = lib.math.round_dec(food[2], 2)  	   
food[3] = 1.6 + 0.05 * math.random(20)
food[3] = lib.math.round_dec(food[3], 2)	   
food[4] = 2 *food[3] - 0.05 * math.random(15)
food[4] = lib.math.round_dec(food[4], 2)	  

numb[1] = math.random(5) - 1
numb[2] = 4 - numb[1]
quest1 = ""
quest2 = ""
if (numb[1] > 0) then
	quest1 = numb[1]
    if (numb[1] == 1) then	
		quest1 = quest1 .. " " .. msg[3]
	else
		quest1 = quest1 .. " " .. msg[5]
	end
end	

if (numb[2] > 0) then
    if (numb[1] ~= 0) then
		quest2 = msg[7] 
    end		
	quest2 = quest2 .. " " .. numb[2]
    if (numb[2] == 1) then	
		quest2 = quest2 .. " " .. msg[4]
	else
		quest2 = quest2 .. " " .. msg[6]
	end
end

numb[3] = math.random(5) - 1
numb[4] = math.floor((2 - numb[3])/2)
if (numb[4] <= 0) then
	numb[4] = 0
end

total = 0
for i = 1,4 do
	total = total + numb[i] * food[i]
end	
total = math.ceil(total)

ind = math.random(2)
if (ind == 1 and numb[3] == 0) then	
	ind = 2
end
if (ind == 2 and numb[4] == 0) then	
	ind = 1
end
result = numb[ind+2]
             