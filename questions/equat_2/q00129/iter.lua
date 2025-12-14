
numb = {}
sg = {}
sum = {}
term = {""}
quest = ""

numb[1] = 10 + math.random(80)
numb[2] = 20 + math.random(70)
numb[3] = 100 + math.random(800)
numb[4] = 200 + math.random(700)
numb[5] = 5 + math.random(90)

for i = 1,2 do
	sg[i] = math.random(2)
end	

for i = 1,2 do
    if (sg[i] == 1) then 
		sum[i] =  numb[2*i-1] + numb[2*i]
		term[i] =  "|" .. numb[2*i-1] .. " + " .. numb[2*i] .. "|"
	else
		sum[i] =  numb[2*i-1] - numb[2*i]	
		term[i] =  "|" .. numb[2*i-1] .. " - " .. numb[2*i] .. "|"		
	end
	if (sum[i] < 0) then
	    sum[i] = - sum[i]
	end
end

ind = math.random(4)

if (ind < 3) then 
	res =  sum[1] + sum[2] 
	quest = term[1] .. " + " .. term[2]
    if (ind == 1) then
        res = numb[5]	- res
	    quest = "x + " .. quest .. " = " .. numb[5]
    else
        res = res - numb[5]	
	    quest = quest .. " - x = " .. numb[5]	
	end
else
	res =  sum[1] - sum[2]  
	quest = term[1] .. " - " .. term[2]	
	if (ind == 3) then
		res = numb[5] - res
		quest = "x + " .. quest .. " = " .. numb[5]
	else
		res = res - numb[5]	
		quest = quest .. " - x = " .. numb[5]	
	end	
end
