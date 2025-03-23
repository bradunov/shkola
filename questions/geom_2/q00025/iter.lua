
measure = {"°", "'", "''"}

numb = {}
index = {}

for i = 1,3 do
    index[i] = math.random(4) - 1
	if (index[i] > 0) then
	    index[i] = 1
	end	
end	
if (index[1] == 0 and index[2] == 0) then
    index[1] = 1
end	

numb[1] = index[1] * math.random(180)
value = numb[1]
for i = 2,3 do
    numb[i] = index[i] * math.random(59)  
    value = value * 60 + numb[i]	
end
   
answ = ""
for i = 1,3 do 
    if (numb[i] ~= 0) then 
        answ = answ .. " " .. tostring(numb[i]) .. measure[i]
    end		
end		  			
               
              
   