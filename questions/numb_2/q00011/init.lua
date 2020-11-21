
--[[ deljivost sa 3, 6, 9 ]]--

denum = {3, 6, 9} 

answ = {"","","","","","",""}

cifre = {}

q1={}
q2={}
q3={}

cifre[1] = math.random(2);
cifre[2] = cifre[1] + math.random(4 - cifre[1]);
cifre[3] = cifre[2] + math.random(6 - cifre[2]);
cifre[4] = cifre[3] + math.random(8 - cifre[3]);
cifre[5] = cifre[4] + math.random(9 - cifre[4]);


max = 5
index = math.random(3)

if (index < 3) then
	dev = 3
else
    dev = 9	
end	
	
ind = 0
	
for i = 1, max do
    for j = 1, max do
        if (j ~= i) then
            for k = 1, max do
			    if (k ~= i and k ~= j) then
                    summ = cifre[i] + cifre[j] + cifre[k]					
			        temp = math.floor(summ/dev)
				    rest = summ - dev * temp
				    if (rest == 0) then
					    ind = ind + 1
					    q1[ind] = i
					    q2[ind] = j
					    q3[ind] = k
                    end
                end
		    end	
        end
    end
end

count6 = 0

number = 0

for i = 1,ind do
    if (index ~= 2) then
        number = cifre[q1[i]] * 100 + cifre[q2[i]] * 10 + cifre[q3[i]]	
		count = math.floor((i-1)/6)
        answ[count+1] = answ[count+1] .. lib.check_number(number) .. " " 				
	else
        temp = math.floor(cifre[q3[i]]/2)
        rest = cifre[q3[i]] - 2* temp	
        if (rest == 0) then	
            number = cifre[q1[i]] * 100 + cifre[q2[i]] * 10 + cifre[q3[i]]
			count = math.floor(count6/6)
            answ[count+1] = answ[count+1] .. lib.check_number(number) .. " " 		
			count6 = count6 + 1
		end
    end			
end                 

if (number == 0) then
    answ[1] = lib.check_string("nema") .. " " .. lib.check_string("broja") .. " " .. lib.check_string("deljivog") .. " " .. lib.check_string("sa") .. " " .. lib.check_number(denum[index]) 
end	  
            