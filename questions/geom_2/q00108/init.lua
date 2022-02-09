
include("terms")

edge = {}
out = {}

max_range = 4 
numb2 = 2 + math.random(max_range)
numb1 = math.random(numb2 - 1)

edge[1] = numb2^2 - numb1^2
edge[2] = 2 * numb1 * numb2
edge[3] = numb1^2 + numb2^2	

ind = math.random(3)	
if (ind < 3) then
    if (ind == 1) then  
        edge[1] = edge[1]  + math.random(max_range)
    else	
	    tmp = edge[1] + edge[2] - edge[3] - 1
		if (tmp > max_range) then
		    tmp = max_range
		end	
        edge[2] = edge[2] - math.random(tmp) 
    end		
end	
	
check = 0
if (edge[1] <= edge[2] - edge[3] or edge[1] >= edge[2] + edge[3]) then
	check = 1
end	
if (edge[2] <= edge[3] - edge[1] or edge[2] >= edge[3] + edge[1]) then
	check  = 2
end	
if (edge[3] <= edge[1] - edge[2] or edge[3] >= edge[1] + edge[2]) then
	 check = 3
end			

if (check ~= 0) then
   ind = 4
end   
	
out = lib.math.random_shuffle(edge)
            