
number = {}
value = {""}

max = 8
start = 0
add = math.random(3)
deg = 10^3

sign = math.random(2)

for i = 1,max do
    if (sign == 1) then
        number[i] = (start + (i-1)* add) * deg
    else
        number[i] =  (start + (max - i) * add) * deg
	end		
	value[i] = tostring( math.floor(number[i]))
end

ind1 = 0
ind2 = 0
stampa = math.random(2)
if (stampa == 1) then
    reply = value[1] 
	ind1 = ind1 + 1	
else
    reply = lib.check_number(number[1],35) 	
	ind2 = ind2 + 1
end

for i = 2,max do
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
	    reply = reply .. ", " .. lib.check_number(number[i],35)
		ind2 = ind2 + 1
	end	
end	                
                      
                                                                                                                                                                              
       