
factor = {}
ind = {}

brac = {"\(\big ( \)", "\(\big ) \)"}
sign = {"-", "+"} 

min_range = 15
max_range = 29

test = 0 
for i = 1,3 do
    factor[i] = min_range - math.random(max_range);
	if (factor[i] == 0) then 
	    factor[i] = - math.random(min_range)
	end	
	if (factor[i] < 0) then
	    test = test + 1
	end	
end

if (test == 0) then
    ch = math.random(3)
	factor[ch] = -factor[ch]
end

for  i = 1,2 do
     ind[i] = math.random(2)
end	 
 
if (ind[2] == 1) then
    term = factor[2] - factor[3]
else
    term = factor[2] + factor[3]	
end	

if (ind[1] == 1) then
    summ = factor[1] - term 
else
    summ = factor[1] + term 	
end	

quest = "( " .. tostring(factor[1]) .. " ) " .. sign[ind[1]] .. " " .. brac[1] .. "( " .. tostring(factor[2]) .. " ) " .. sign[ind[2]] .. " x " .. brac[2] .. " = " .. tostring(summ)



            