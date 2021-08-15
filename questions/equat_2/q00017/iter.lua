
factor = {}
min_range = 15
max_range = 39

test = 0 
for i = 1,2 do
    factor[i] = min_range - math.random(max_range);
	if (factor[i] == 0) then 
	    factor[i] = - math.random(min_range)
	else	
	    if (factor[i] < 0) then
	        test = test + 1
		end	
	end	
end

if (test == 0) then
    ch = math.random(2)
	factor[ch] = -factor[ch]
end

summ = factor[1] + factor[2];
                  

if (ITEM == 1) then  
	sign = "+"	
	result = factor[2]
	answ = "x " .. sign .. " ( " .. tostring(factor[1]) .. " ) = " .. tostring(summ)
end

if (ITEM == 2) then  
	sign = "-"	
	result = summ
	answ = "x " .. sign .. " ( " .. tostring(factor[1]) .. " ) = " .. tostring(factor[2])
end

if (ITEM == 3) then  
	sign = "+"	
	result = factor[2]
	answ = "( " .. tostring(factor[1]) .. " ) " .. sign .. " x " .. " = " .. tostring(summ)
end

if (ITEM == 4) then  
	sign = "-"	
	result = factor[2]
	answ = "( " .. tostring(summ) .. " ) " .. sign .. " x " .. " = " .. tostring(factor[1])
end

            