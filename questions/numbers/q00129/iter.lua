
temp = {}
cifre = {};
reply1 = {""}
reply2 = {""}

dig = 4

cifre[1] = math.random(10) - 1
value = cifre[1]
for i = 2,dig do
    cifre[i] = math.random(9)
	value = value  * 10 + cifre[i]
end

ind = math.random(dig)

for i=1,4 do
    temp[i] = cifre[i] * 10^(4-i)
end	

if (cifre[1] ~= 0) then
    if (ind == 1) then
	    result = temp[1]
	    reply1 = ""
        reply2 = " + " .. tostring(math.floor(temp[2])) .. " + " .. tostring(math.floor(temp[3])) .. " + " .. tostring(math.floor(temp[4]))  
    end	
	if (ind == 2) then
	    result = temp[2]
        reply1 = tostring(math.floor(temp[1])) .. " + " 
		reply2 = " + " .. tostring(math.floor(temp[3])) .. " + " .. tostring(math.floor(temp[4]))   
    end
    if (ind == 3) then
	    result = temp[3]
        reply1 = tostring(math.floor(temp[1])) .. " + " .. tostring(math.floor(temp[2])) .. " + " 
        reply2 = " + " .. tostring(math.floor(temp[4]))   
    end	
    if (ind == 4) then
	    result = temp[4]
        reply1 = tostring(math.floor(temp[1])) .. " + " .. tostring(math.floor(temp[2])) .. " + " .. tostring(math.floor(temp[3])) .. " + "   
		reply2 = ""
    end		
else	
	if (ind == 2) then
	    result = temp[2]
        reply1 = "" 
		reply2 = " + " .. tostring(math.floor(temp[3])) .. " + " .. tostring(math.floor(temp[4]))      
	end
    if (ind == 1 or ind == 3) then
	    result = temp[3]
        reply1 = tostring(math.floor(temp[2])) .. " + " 
		reply2 = " + " .. tostring(math.floor(temp[4]))     
    end	
    if (ind == 4) then
	    result = temp[4]
        reply1 = tostring(math.floor(temp[2])) .. " + " .. tostring(math.floor(temp[3])) .. " + "   
		reply2 = ""
    end
end

           