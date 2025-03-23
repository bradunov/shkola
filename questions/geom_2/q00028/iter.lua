
include("terms")

measure = {"°", "'", "''"}

numb = {}
index = {}
value = {}


numb[1] = {}
for i = 1,3 do
    index[i] = math.random(4) - 1
	if (index[i] > 0) then
	    index[i] = 1
	end	
end	
numb[1][1] = math.random(80)
value[1] = numb[1][1]
for i = 2,3 do
    numb[1][i] = index[i] * math.random(59)  
    value[1] = value[1] * 60 + numb[1][i]	
end

quest = ""
for i = 1,3 do 
    if (numb[1][i] ~= 0) then 
        quest = quest .. " " .. tostring(numb[1][i]) .. measure[i]	
    end	
end	

ind = math.random(5)
name = msg[ind]

if (ind > 2) then
    if (ind < 5) then
		value[2] = 648000 - value[1]	
	else
		value[2] = 1296000 - value[1]
	end	
else
    if (ind == 1) then
        value[2] = 324000  - value[1]
	else
        value[2] =	value[1]
	end
end		

numb[2] = {}
numb[2][1] = math.floor(value[2]/3600)
rest = value[2] - numb[2][1] * 3600
numb[2][2] = math.floor(rest/60)
numb[2][3] = math.floor(rest - numb[2][2] * 60)

answ = ""
for i = 1,3 do 
    if (numb[2][i] ~= 0) then 
	    if (i == 1) then 
            answ = answ .. " " .. lib.check_number(numb[2][i], 25) .. measure[i]	
		else
            answ = answ .. " " .. lib.check_number(numb[2][i], 20) .. measure[i]
        end		
    end
end	
 