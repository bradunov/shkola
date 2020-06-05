
ind_dec = math.random(10)
ind_cent = math.random(6)

index = math.random(2)

if(ind_cent == 6) then
   year = 1900
else
   year = (2 * ind_cent - 1) * 100  
end   

if (index == 1) then 
    year = year + (ind_dec - 1) * 10 + 1
else
    year = year + ind_dec * 10 	
end	
                  