
include("terms")

factor = {}
quest = {""}
answ = {""}
qq = {}
out = {}
reply = {""}

ind = math.random(4)

min_range = 15
max_range = 29

test = 0 
for i = 1,2 do
    factor[i] = min_range - math.random(max_range);
	if (factor[i] == 0) then 
	    factor[i] = - math.random(min_range)
	end	
	if (factor[i] < 0) then
	    test = test + 1
	end	
end

if (test == 0) then
    ch = math.random(2)
	factor[ch] = -factor[ch]
end

quest[ind] = operation[ind]                

if (ind == 1) then	
    value = factor[2] + factor[1]
end	
                  
if (ind == 2) then	
    value = factor[2] - factor[1]
end	                  

if (ind == 3) then
    value = factor[1] + factor[2]
end	                

if (ind == 4) then	
    value = factor[1] - factor[2]
end	
            
answ[1] =  "(" .. tostring(math.floor(factor[2])) .. ") + x = " .. tostring(math.floor(value))           
answ[2] = "(" .. tostring(math.floor(factor[2])) .. ") - x = " .. tostring(math.floor(value)) 
answ[3] = "x + (" .. tostring(math.floor(factor[2])) .. ") = " .. tostring(math.floor(value)) 
answ[4] = "x - (" .. tostring(math.floor(factor[2])) .. ") = " .. tostring(math.floor(value))             

for i = 1,4 do
    qq[i] = i
end

out = lib.math.random_shuffle(qq)
for i = 1,4 do
    reply[i] = answ[out[i]]
	if (ind == out[i]) then
	    index = i
	end	
end	
    

      
         