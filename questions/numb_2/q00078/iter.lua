
coef2 = {}
coef3 = {}
c2 = {}
c3 = {}
root2 = {""}
root3 = {""}

r2 = math.sqrt (2)
r3 = math.sqrt (3)
dim = 7
dim2 = 3

for i = 1,dim do
    coef2[i] = - 5 + math.random(9) 
    coef3[i] = - 5 + math.random(9)
    if (coef2[i] == 0) then
        coef2[i] = -2
    end	
    if (coef3[i] == 0) then
        coef3[i] = 2
    end			
end 

for i = 2,3 do
    c2[i-1] = coef2[i-1]    
    tmp = coef2[2*i] + coef2[2*i+1] * r2
    if (tmp < 0) then
        c2[2*i] = - coef2[2*i]
		c2[2*i+1] = - coef2[2*i+1]  
    else 
        c2[2*i] = coef2[2*i]
		c2[2*i+1] = coef2[2*i+1]  
    end	
    c3[i-1] = coef3[i-1]  	
    tmp = coef3[2*i] + coef3[2*i+1] * r3
    if (tmp < 0) then
        c3[2*i] = - coef3[2*i]
		c3[2*i+1] = - coef3[2*i+1]  
    else 
        c3[2*i] = coef3[2*i]
		c3[2*i+1] = coef3[2*i+1]  
    end			
end 
c2[3] = 0
c3[3] = 0
value2 = 0
value3 = 0
for i = 2,3 do
     c2[3] = c2[3] - c2[i-1] * c2[2*i+1]
     c3[3] = c3[3] - c3[i-1] * c3[2*i+1]  
     value2 = value2 + c2[i-1] * c2[2*i] 
	 value3 = value3 + c3[i-1] * c3[2*i] 	 
end	 
coef2[3] = c2[3]
coef3[3] = c3[3]


for i = 2,3 do
	root2[i] =  "√(" .. coef2[2*i]
	if (coef2[2*i+1] > 0) then
	    root2[i] =  root2[i] .. " + " 		
    else		
	    root2[i] =  root2[i] .. " - "   
    end	
    if (math.abs(coef2[2*i+1]) ~= 1) then	
        root2[i] = root2[i] .. math.abs (coef2[2*i+1]) .. " * "	
    end	
    root2[i] = root2[i] .. " √2)² "	
	root3[i] =  "√(" .. coef3[2*i]
	if (coef3[2*i+1] > 0) then
	    root3[i] =  root3[i] .. " + " 		
    else		
	    root3[i] =  root3[i] .. " - "   
    end	
    if (math.abs(coef3[2*i+1]) ~= 1) then	
        root3[i] = root3[i] .. math.abs (coef3[2*i+1]) .. " * "	
    end	
    root3[i] = root3[i] .. " √3)² "	
end

if (coef2[3] == 0) then
    root2[1] = ""
else
    if (coef2[3] == 1) then	
        root2[1] = "√2 " 
    else		
        root2[1] =  coef2[3] .." * √2 " 
	end	
end
if (coef3[3] == 0) then
    root3[1] = ""
else
    if (coef3[3] == 1) then	
        root3[1] = "√3 " 
    else	
        root3[1] =  coef3[3] .." * √3 "
	end	
end	

quest = ""
value = 0
choice = math.random(3)
if (choice < 3) then
	value = value + value2
    quest = quest .. root2[1]
	for i = 1,2 do
	    if (coef2[i] > 0) then  
            quest = quest .. " + " 
        else
            quest = quest .. " - " 
        end			
        if (math.abs(coef2[i]) ~= 1) then	
            quest = quest .. math.abs (coef2[i]) .. " * "	
        end				
		quest = quest .. root2[i+1]
    end
end
if 	(choice > 1) then
	value = value + value3
    if (choice == 2) then
	    if (coef3[3] >= 0) then 
            quest = quest .. " + " .. root3[1]
        else
            quest = quest .. " - ".. math.abs (coef3[3]) .. " * √3 "
        end	
	else
        quest = quest .. root3[1]	
	end		
	for i = 1,2 do	
	    if (coef3[i] > 0) then
            quest = quest .. " + "  			
        else	
            quest = quest .. " - "  
		end	
        if (math.abs(coef3[i]) ~= 1) then	
            quest = quest .. math.abs (coef3[i]) .. " * "	
        end			
		quest = quest .. root3[i+1]
	end
end

result = 0
if (choice < 3) then	
    result = result + c2[1] * c2[4] + c2[2] * c2[6]
end
if (choice > 1) then	
    result = result + c3[1] * c3[4] + c3[2] * c3[6]
end
            