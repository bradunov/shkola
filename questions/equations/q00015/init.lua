term = {} 
qA = {}
qB = {}
answA = {}
answB = {}


term[1] = math.random(59) + 10;
term[2] = math.random(90 - term[1]) + 10;

term[3] = math.random(59) + 10 ;
term[4] = math.random(90 - term[3]) + 10;

for i=1,4 do
    term[i] = term[i];
end

summA = term[1] + term[2];
summB = term[3] + term[4];
                  

qA[1] = term[1]
qA[2] = term[1] + math.random(9) 

qA[3] = term[1] - math.random(9) 
if (qA[3] < 0) then
    qA[3] = - qA[3]
end	

qA[4] = term[1] - term[2]
if (term[1] < term[2]) then
    qA[4] = -qA[4]   
end

for i = 1,3 do
    if(qA[4] == qA[i]) then
	   qA[4] = 0
	end
end	

answA = lib.math.random_shuffle(qA)                  

for i = 1,4 do  
    if(answA[i] == term[1]) then 
       indA = i-1
    end
end	


qB[1] = term[4]
qB[2] = term[4] + math.random(9)

qB[3] = term[4] - math.random(9)
if (qB[3] < 0) then
    qB[3] = - qB[3]
end	

qB[4] = term[3] - term[4]
if (term[3] < term[4]) then
    qB[4] = -qB[4]   
end

for i = 1,3 do
    if(qB[4] == qB[i]) then
	   qB[4] = 0
	end
end	

answB = lib.math.random_shuffle(qB)                  
                    
for i = 1,4 do  
    if(answB[i] == term[4]) then 
       indB = i-1
    end
end                