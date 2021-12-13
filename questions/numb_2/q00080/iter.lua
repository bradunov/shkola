
coef2 = {}
coef3 = {}
c2 = {}
c3 = {}
root2 = {""}
root3 = {""}


r2 = math.sqrt (2)
r3 = math.sqrt (3)
dim = 4
dim2 = 2

for i = 1,dim2 do
    coef2[i] = -1 + math.random(7)  
    coef3[i] = -1 + math.random(7)	
    coef2[dim2 + i] = 2 + math.random(7) 
    coef3[dim2 + i] = 1 + math.random(6)		
end
if (coef2[1] * coef2[2] == 0) then
    coef2[1] = 3 + math.random(4)
end	
if (coef3[1] * coef3[2] == 0) then
    coef3[2] = 1 + math.random(5)
end	
if (coef2[3] == coef2[4]) then
    coef2[4] = coef2[3] + math.random(4)
end	
if (coef3[3] == coef3[4]) then
    coef3[4] = coef3[3] + math.random(4)
end	

for i = 1, dim2 do
    c2[i] = coef2[dim2 + i] * coef2[dim2 + i] * 2  
    c3[i] = coef3[dim2 + i] * coef3[dim2 + i] * 3
	root2[i] =  coef2[i] .. " * √(" .. c2[i].. ")"	
	root3[i] =  coef3[i] .. " * √(" .. c3[i] .. ")"
end	


val2 = 0
val3 = 0
quest = ""

for i = 1, dim2 do	
    if (coef2[i] ~= 0) then
        sg = math.random(2)	
	    if (sg == 1) then 
            quest = quest .. " - " .. root2[i]
            val2 = val2 - coef2[i] * coef2[dim2 + i] 			
        else
            if (quest == "" ) then
                quest = quest .. root2[i]	
            else				
                quest = quest .. " + " .. root2[i]
            end				
            val2 = val2 + coef2[i] * coef2[dim2 + i] 			
        end			
    end		
    if (coef3[i] ~= 0) then
	    sg = math.random(2)
	    if (sg == 1) then 		
            if (quest == "" ) then
                quest = quest .. root3[i]
            else			
                quest = quest .. " + " .. root3[i]
		    end	
            val3 = val3 + coef3[i] * coef3[dim2 + i] 			
        else
            quest = quest .. " - " .. root3[i]	
            val3 = val3 - coef3[i] * coef3[dim2 + i] 
        end			
    end	
end
 
value = val2 * r2 + val3 * r3
answ = lib.check_number(val2, 20) .. " * √" .. lib.check_number(2, 20) .. " + " .. lib.check_number(val3, 20) .. " * √" .. lib.check_number(3, 20)
              