
prime = {23, 29, 31, 37, 41, 43, 47, 51, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97}

div = {}

number = 21 + math.random(79)

for i = 1, 18 do
    if (number == prime[i]) then
	    number = number + 1
	end
end	
		
max = math.floor(number/2)

answ = ""
index = 0
prod = 1
for j = 2,max do  
    if (index < 5) then  
        factor = math.floor(number/j) 
	    rest = number - factor*j
	    if (rest == 0) then
		    answ = answ .. tostring(factor) .. ", "
		    index = index + 1
			div[index] = factor
	    end	
    end	
end

if (index == 1) then
   	answ = answ .. tostring(2) .. ", "   
    number = div[index] * 2 
else
    ind = 0
    for i = 2, index do	
	    temp = math.floor(div[1]/div[i]) 
        rest = div[1] - temp * div[i]
        if (rest ~= 0) then	
            ind = 1
        end
    end		
    if (ind == 0) then     
	    number = div[1]
    end		
end	      