
number = 21 + math.random(78)

max = math.floor(number/2)

answ = "1"

for i = 2,max do  
    j = max + 2 - i  
    factor = math.floor(number/j) 
	rest = number - factor*j
	if (rest == 0) then
		answ = answ .. " " .. lib.check_number(factor,20)
	end		   
end

answ = answ .. " " .. lib.check_number(number,20)     
     
         