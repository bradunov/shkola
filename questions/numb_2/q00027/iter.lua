
include("terms")

prime = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97}
dim = 10                                    --[[25]]--

deg = {}

stampa = 6
numbmin = 50
numbmax = 10000

number = 1
sum = 0
for i = 1,dim do
    if (i < 5) then
	    max = 3
    else
        max = 2
    end		
    if (sum < stampa and number < numbmax) then	
        deg[i] = math.random(max) - 1
	else
        deg[i] = 0
    end		
	sum = sum + deg[i]
	if (deg[i] > 0) then
	    for j = 1,deg[i] do
            number = number * prime[i]
	    end
	end	
end

if (number < numbmin) then
    number = 1
	sum = 5
    temp = 1 + math.random(3)
    for i = 1,dim do
	    if (i >= temp and i <= temp + 4) then
		    deg[i] = 1
			number = number * prime[i]
		else 
            deg[i] = 0
        end	
    end		
end	

if (deg[5] == 0) then
    deg[5] = 1
	number = number * prime[5] 
	sum = sum + 1
end	

answ = ""

term = number 
for i = 1, dim do
    if (deg[i] ~= 0) then
	    for j = 1, deg[i] do
		    term = term/prime[i]
     		answ = answ .. " " .. lib.check_number(prime[i],20)			
        end
    end
end       
     
	 