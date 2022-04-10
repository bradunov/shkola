
angle = {}
out = {}

nr = 4 + math.random(6)
nr2 = math.floor(nr/2)
rest = nr - 2*nr2

sum = (nr - 2) * 180
mid = math.floor(180 - 360/nr)

check = 0
for i = 1,nr2 do
	add = 2 + math.random(20)
	if (mid + add >= 180) then
	    add = 170 - mid 
	end	
	angle[i] = mid + (-1)^i * add
	angle[nr+1-i] = mid - (-1)^i * add
    check = check + angle[i] + angle[nr+1-i]
end
if (rest ~= 0) then
    angle[nr2+1] = sum - check		
    check = check + angle[nr2+1]	
end	 
        	
ind = math.random(2)
if (ind == 2) then
    sumang = 0
    for i = 1,nr do
		add = 2 + math.random(10)
		angle[i] = angle[i] + (-1)^i * add
	    sumang = sumang + angle[i]
	end	
else
    sumang = check	
end	  

index = math.random(2)

quest1 = msg[index]
quest2 = ""
if (index == 1) then
	for i = 1,nr-1 do
	    quest2 = quest2 .. tostring(math.floor(angle[i])) .. meas .. ", " .. space
	end	
	quest2 = quest2 .. tostring(math.floor(angle[nr])) .. meas	
else
    quest2 = tostring(math.floor(sumang)) .. meas
end	

ch = 0
for i = 1,nr do
    if (angle[i] >= 180) then
		ch = 1
	end	
end	
   
answ = ""
if (ch == 1) then
    answ = reply[2]
else
	if (sumang == sum) then
		answ = reply[1]
	else
		answ = reply[2]	
	end	
end	
            
            