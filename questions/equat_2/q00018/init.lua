
term = {} 
qA = {}
qB = {}
answA = {}
answB = {}

min_range = 25
max_range = 59

testA = 0 
for i = 1,2 do
    term[i] = min_range - math.random(max_range);
	if (term[i] == 0) then 
	    term[i] = - math.random(min_range)
	else	
	    if (term[i] < 0) then
	        testA = testA + 1
		end	
	end	
end
if (testA == 0) then
    ch = math.random(2)
	term[ch] = -term[ch]
end

if (math.abs(term[1]) == math.abs(term[2])) then
    term[2] = term[2] - 1
end	
qA[1] = term[2] + term[1];
qA[2] = term[2] - term[1];
qA[3] = - qA[1]
qA[4] = - qA[2]

answA = lib.math.random_shuffle(qA)
for i = 1,4 do  
    if(answA[i] == qA[1]) then 
       indA = i-1
    end
end	


testB = 0 
for i = 3,4 do
    term[i] = min_range - math.random(max_range);
	if (term[i] == 0) then 
	    term[i] = - math.random(min_range)
	else	
	    if (term[i] < 0) then
	        testB = testB + 1
		end	
	end	
end
if (testB == 0) then
    ch = 2 + math.random(2)
	term[ch] = -term[ch]
end

if (math.abs(term[3]) == math.abs(term[4])) then
    term[4] = term[4] - 1
end	
qB[1] = term[3] - term[4];
qB[2] = term[3] + term[4];
qB[3] = - qB[1]
qB[4] = - qB[2]

answB = lib.math.random_shuffle(qB)
for i = 1,4 do  
    if(answB[i] == qB[1]) then 
       indB = i-1
    end
end	
