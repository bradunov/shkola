style = {["width"] = 25,
        ["height"] = 100,
        ["ratio"] = 0.4,
		["text-align"] = "inline",
	    ["color"] = "aaf"};
           
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
    term[i] = term[i] * 10;
end

summA = term[1] + term[2];
summB = term[3] + term[4];
                  

qA[1] = term[1]
qA[2] = term[1] + math.random(9) * 10

if (term[1] == term[2]) then
    qA[3] = 1
else
    qA[3] = 0
end	

qA[4] = term[1] - term[2]

if (term[1] < term[2]) then
    qA[4] = term[2] - term[1]   
end

answA = lib.math.random_shuffle(qA)                  



qB[1] = term[4]
qB[2] = term[4] + math.random(9) * 10

if (term[3] == term[4]) then
    qB[3] = 1
else
    qB[3] = 0
end	

qB[4] = term[3] - term[4]

if (term[3] < term[4]) then
    qB[4] = term[4] - term[3]   
end

answB = lib.math.random_shuffle(qB)                  
                    
                  