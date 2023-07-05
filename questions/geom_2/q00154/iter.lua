
numb = {}
edge = {}

fct = 1 + math.random(4)
area = 0 
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
	area = area + edge[i]
end	                     
            
   