
include("terms")

value = {}
answ = {""}
week = {}
dim = {}
ord = {}

value[1] = 22 + math.random(12)

ind = 2 + math.random(2)

if (ind == 3) then
    value[4] = 30
    if (value[1] == value[4]) then
        value[1] = value[1] + 1
    end		
else
    value[4] = 31
    if (value[1] == value[4]) then
        value[1] = value[1] - 1
    end			
end	
                  				  
temp =  math.floor(value[1]/7)
value[2] = temp * 7
rest = value[1] - value[2]
if (rest == 0) then
    value[1] = value[1] + 1
end
week[1] = temp	

temp =  math.ceil(value[1]/7)
value[3] = temp * 7
rest = value[3] - value[1]
if (rest == 0) then
    value[1] = value[1] - 1
end
week[2] = temp	

temp = value[1] - 10 * math.floor(value[1]/10)
if (temp == 1) then
    dim[1] = measure1[1]
else
    dim[1] = measure2[1]	
end

for i = 2,3 do
    if (week[i-1] < 5) then
	    dim[i] = measure1[2]
	else
	    dim[i] = measure2[2]
    end		
end	
	
				  
answ[1] = tostring(math.floor(value[1])) .. " " .. dim[1] 
answ[2] = tostring(math.floor(week[1])) .. " " .. dim[2]	               
answ[3] = tostring(math.floor(week[2])) .. " " .. dim[3]               
answ[4] = measure1[ind] 

sign = math.random(2)

ord = lib.math.argsort(value)  

if (sign == 1) then	
    index = ord[1] - 1
else
    index = ord[4] - 1
end	                        
   