
--[[ deljivost sa 2, 4, 5, 10 ]]--

include("terms")

denum = {2, 4, 5, 10} 

cifre = {}

answ = {"","","","","","",""}

max = 5

index = math.random(4)

if (index == 1) then
    figo = {1, 3, 5, 7, 9}
    fige = {0, 2, 4, 6, 8}
	qo = lib.math.random_shuffle(figo)
	qe = lib.math.random_shuffle(fige)
	qchoice = {}
	tp = 1
	for i = 1,5 do
	    des = math.random(2)
	    if (des == 1 and tp < 3) then
	        qchoice[i] = qe[i]
	        tp = tp + 1
	    else
	        qchoice[i] = qo[i]
        end	
    end		
    q = lib.math.argsort(qchoice) 
	for i = 1,5 do
	    cifre[i] = qchoice[q[i]]
	end
else	
    cifre[1] = math.random(3) - 1;
    cifre[2] = cifre[1] + math.random(4 - cifre[1]);
    cifre[3] = cifre[2] + math.random(6 - cifre[2]);
    cifre[4] = cifre[3] + math.random(8 - cifre[3]);
    cifre[5] = cifre[4] + math.random(9 - cifre[4]);
end			

ind = 0

if (index == 4) then
    if (cifre[1] == 0) then
	    for i = 2, max do
            for j = 2, max do
                if (j ~= i) then	
				    number = (cifre[i] * 10 + cifre[j]) * 10				
		            count = math.floor(ind/6)
		            answ[count+1] = answ[count+1] .. lib.check_number(number) .. " " 		
					ind = ind + 1			
			    end
            end
        end		
    end
else	
    if (cifre[1] == 0) then
        imin = 2
    else
        imin = 1
    end	
    for i = imin, max do
        for j = 1, max do
            if (j ~= i) then
                for k = 1, max do
			        if (k ~= i and k ~= j) then
                        number = (cifre[i]*10 + cifre[j]) * 10 + cifre[k]					
			            temp = math.floor(number/denum[index])
				        rest = number - denum[index] * temp
				        if (rest == 0) then
		                    count = math.floor(ind/6) 							
		                    answ[count+1] = answ[count+1] .. lib.check_number(number) .. " " 	
					        ind = ind + 1
                        end
                    end
		        end	
            end
        end
    end
end	

if (ind == 0) then
    answ[1] = lib.check_string(msg[1]) .. " " .. lib.check_string(msg[2]) .. " " .. lib.check_string(msg[3]) .. " " .. lib.check_string(msg[4]) .. " " .. lib.check_number(denum[index]) 
end
