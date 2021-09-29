
bracketl = "{"
bracketr = "}"
sign = {"<", ">", "≤", "≥"} 


ind1 = math.random(4)

if (ind1 == 1 or ind1 == 3) then
    ind2 = 2*math.random (2) - 1
else
    ind2 = 2*math.random (2)
end	

term1 = math.random(59)  - 1;
term2 = term1 + 2 + math.random(5)
step = 1
if (ind1 == 2 or ind1 == 4) then
     tmp = term1
	 term1 = term2
	 term2 = tmp
	 step = -1
end	 

noneq = tostring(math.floor(term1)) .. " " .. sign[ind1] .. " x " .. sign[ind2] .. " " .. tostring(math.floor(term2))  
answ = "x " .. "\(\small\in\) " .. bracketl

if (ind1 < 3) then
    min_range = 1 
else
    min_range = 0 
end
max_range = math.abs(term2 - term1) - 1
if (ind2 > 2) then
    max_range = max_range + 1
end

for i = min_range, max_range do
    numb = term1 + step * i 
        if (i < max_range) then 
	        answ = answ .. lib.check_number(numb,20) .. ", "
	    else
	        answ = answ .. lib.check_number(numb,20) .. bracketr	
	    end	
end	
