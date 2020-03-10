side = {}
result = {}
temp = {}

min = 4;
max = 20;

side[1] = min + math.random(max - min);
side[2] = side[1] + math.random(max - min);
side[3] = side[1] + math.random(side[2] - side[1]); 
side[4] = side[1]
side[5] = side[2]

for i=1,3 do
    if(side[i] > side[i+1] + side[i+2]) then
       side[i] = side[i+1]        
    end
end

circ = side[1] + side[2] + side[3]


result[1] = side[1] + math.random(side[2] - min);
result[2] = side[2] + math.random(side[1] - min);
result[3] = side[3] - math.random(side[3] - min);
result[4] = side[2] - math.random(side[2] - min);
result[5] = side[3]

temp = lib.math.argsort(result)

for i = 1,4 do
	if result[temp[i]] == result[temp[i+1]] then
		   result[temp[i+1]] = result[temp[i+1]] + 1
	end
end	

answ = lib.math.random_shuffle(result)

for i = 1,5 do
    if (answ[i] == side[3]) then
	    ind = i - 1
	end	
end
     
  	
    
