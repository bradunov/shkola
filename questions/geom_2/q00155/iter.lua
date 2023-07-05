
numb = {}
edge = {}
ans = ""

fct = 1 + math.random(4)
for i = 1,3 do
    numb[i] = 2 + math.random(10)
	if (i == 3) then
	    if (numb[3] >= numb[1] + numb[2]) then
		    numb[3] = numb[1] + numb[2] - math.random(3)
		end	
	    if (numb[3] <= math.abs(numb[1] - numb[2])) then
		    numb[3] = math.abs(numb[1] - numb[2]) + math.random(3)
		end	
    end		
	edge[i] = fct * numb[i]
end	  
                   
ind = math.random(3)            
for i = 1,3 do
    if (i == ind) then
		ans = ans .. pt[i] .. " = " .. edge[i] .. "cm"
    else
		ans = ans .. pt[i] .. " = " .. lib.check_number(edge[i],20) .. "cm"
    end
    if (i < 3) then
		ans = ans .. space
    else	
		ans = ans .. "."	
    end  
end	
         