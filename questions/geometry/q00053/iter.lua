
if (value[ITEM] == 60) then
   if (ind60 == 1) then
       term1 = measure1[1]
       term2 = measure2[1]
	   ind60 = 3 - ind60
	else 
       term1 = measure1[2]
       term2 = measure2[2]	
	   ind60 = 3 - ind60
	end   
end   

if (value[ITEM] == 24) then
   term1 = measure1[3]
   term2 = measure2[3]
end 

if (value[ITEM] == 12) then
   term1 = measure1[5]
   term2 = measure2[5]
end 

if (value[ITEM] == 10) then
   if (ind10 == 1) then
       term1 = measure1[6]
       term2 = measure2[6]
	   ind10 = 3 - ind10
	else 
       term1 = measure1[7]
       term2 = measure2[7]	
	   ind10 = 3 - ind10
	end 
end                  
                  