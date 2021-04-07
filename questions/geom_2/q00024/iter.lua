
measure = {"\(^\circ\)", "'", "''"}

numb = {}
index = {}

for i = 1,3 do
    index[i] = math.random(5) - 1
	if (index[i] > 0) then
	    index[i] = 1
	end	
end	

numb[1] = index[1] * math.random(180)
value = numb[1]
for i = 2,3 do
    numb[i] = index[i] * math.random(59)  
    value = value * 60 + numb[i]	
end

if (value == 0) then
    numb[1] = math.random(90)
	value = numb[1] * 3600
end
    
answ = ""
for i = 1,3 do  
    answ = answ .. " " .. tostring(lib.check_number(numb[i],30)) .. measure[i]
end			
              
              
   