
factor = {}
ind = {}

brac = {"\(\big | \)", "\(\big | \)"}
x1 = "x\(\small_1\)"
x2 = "x\(\small_2\)"
sign = {"-", "+"} 

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
term = math.random(max_range)

if (test == 0) then
    ch = math.random(2)
	factor[ch] = -factor[ch]
end

for  i = 1,2 do
     ind[i] = math.random(2)
end	 
 
if (ind[1] == 1) then
    factor[3] =  factor[1] - term
else
    factor[3] =  factor[1] + term	
end	

if (ind[2] == 1) then
    val1 = factor[2] - term 
    val2 = factor[2] + term 
else
    val1 = term - factor[2] 
    val2 = -factor[2] - term 	
end	

quest = "( " .. tostring(factor[1]) .. " ) " .. sign[ind[1]] .. " " .. brac[1] .. "( " .. tostring(factor[2]) .. " ) " .. sign[ind[2]] .. " x " .. brac[2] .. " = " .. tostring(factor[3])

answ1 = ""
answ2 = ""
if (val1 == val2) then
    answ1 = x .. " = " .. lib.check_number(val1)	
else	
    answ1 = x1 .. " = " .. lib.check_number(val1)
    answ2 = x2 .. " = " .. lib.check_number(val2)	
end
            