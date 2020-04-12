
number = {}
value = {""}

max = 8

number[1] = 11 - math.random(21)
value[1] = tostring( math.floor(number[1]))
add = math.random(3)
	
if (number[1] >= 0) then
    add = -add
end

ind1 = 0
ind2 = 0
stampa = math.random(2)
if (stampa == 1) then
    reply = value[1] 
	ind1 = ind1 + 1	
else
    reply = lib.check_number(number[1],20) 	
	ind2 = ind2 + 1
end

for i = 2,max do
    number[i] = number[i-1] + add
	value[i] = tostring( math.floor(number[i]))
	stampa = math.random(2)
	if (ind1 > max/2) then
	    stampa = 2
	end	
	if (ind2 > max/2) then
	    stampa = 1
	end	
	if (stampa == 1) then
	    reply = reply .. ", " .. value[i]
		ind1 = ind1 + 1
	else
	    reply = reply .. ", " .. lib.check_number(number[i],20)
		ind2 = ind2 + 1
	end	
end	                
                                                                                                                                                                              
       