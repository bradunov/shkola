 
dim = 1 + math.random(2)
round = math.random(3) - 1
err = lib.math.round_dec(1/10^round, round)  
	   
quest = ""  
sum = 10000
for i = 1,dim do                                                         
    number  = 2 + math.random(997)
    value = math.sqrt (number)
    coef =  5 - math.random(10)  
	if (coef ~= 0) then
        if (sum == 10000) then
	        sum = coef * value
			if (coef == 1) then
	            quest = quest .. "√" .. number	
			else
	            quest = quest .. coef .. " * √" .. number	
            end				
        else	
	        sum = sum + coef * value		
            if (coef > 0) then 
		        quest = quest .. " + " 		
	        else		
  		        quest = quest .. " - " 	
            end	
			if (math.abs(coef) == 1) then
		        quest = quest .. "√" .. number
            else 
  		        quest = quest .. math.abs(coef) .. " * √" .. number
            end				
        end	
	end
end	
result = lib.math.round_dec(sum, round)    
        