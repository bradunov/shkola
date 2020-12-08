
number = 10 + math.random(29)

max = math.floor(100/number)

answ = ""

for i = 1,max do   
    factor = number*i 
	answ =  answ .. " " .. lib.check_number(factor,20)	   
end
      
     