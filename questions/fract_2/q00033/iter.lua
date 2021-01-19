
measure = {}
for i = 1,4 do
    measure[i] = {""}
end
measure[1] = {"m", "dm", "cm", "mm"}
measure[2] = {"m\(^2\)","dm\(^2\)","cm\(^2\)","mm\(^2\)"}
measure[3] = {"m\(^3\)","dm\(^3\)","cm\(^3\)","mm\(^3\)"}
measure[4] = {"t", "kg", "g"}

--[[ dm^3 = litar]]--

dim_meas = {4, 4, 4, 3}
step_meas = {1, 2, 3, 3}

numb = {}

index = math.random(4)

nr = 1 + math.random(2)

for i = 1,nr do
    if(index > 2) then
       numb[i] = math.random(98) 
	   dec = 10^3
    end 
    if(index == 2) then
       numb[i] = math.random(8) 
	   dec = 10^2
    end 
    if (index == 1) then
        numb[i] = math.random(9)  
		dec = 10
    end 
end

q = {}
q1 = {}
q2 = {}
q3 = {}
qq = {}

for i = 1,dim_meas[index] do
    q[i] = i
end	
q1 = lib.math.random_shuffle(q)
for i = 1,nr do
    q2[i] = q1[i]
end	
q3 = lib.math.argsort(q2)   
for i = 1,nr do
    qq[i] = q2[q3[i]]
end	

ind = math.random(dim_meas[index])

value = 0
max = 0
for i = 1, nr do
    step = ind-qq[i]	
	if (step >= 0) then
       value = value + numb[i] * dec^step
	else
	   step = -step
       if (max < step) then
           max = step
       end			
       value = value + numb[i] / dec^step	
	end  
end
  
answ = ""
for i = 1,nr do    
    answ = answ .. " " .. tostring(math.floor(numb[i])) .. measure[index][qq[i]]
end	

round = max * step_meas[index]
result = lib.math.round_dec(value, round) 

       
            
            
            
            			