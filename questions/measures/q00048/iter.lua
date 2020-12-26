
value = {}
sign = {}
                                            
ind = math.random(4)

if(ind < 4) then
   value[1] = math.random(ind+1)
   value[2] = value[1] * number[ind]
end

if(ind == 4) then
   value[1] = math.random(4)
   value[2] = value[1] * number[ind]
   ind = ind + 1
end  

for i = 1,2 do
   temp = value[i]
   q = 0
   if (i == 2) then
       q = math.floor(temp/10)
	   temp = temp - q*10
   end 	   
   if(temp == 1) then  
      sign[i] = 1
	  if (i == 2 and q == 1) then
	      sign[i] = 3
      end
   end
   if(temp > 1 and temp <= 4) then  
      sign[i] = 2
	  if (i == 2 and q == 1) then
	      sign[i] = 3
      end
   end   
   if(temp == 0 or temp > 4) then  
      sign[i] = 3
   end 
end

index = math.random(3)

if (index == 1) then
   leftval = value[1]
   rightval = value[2]
   if(sign[1] == 1) then  
      term1 = measure1[ind+1]
   else
      if(sign[1] == 2) then
         term1 = measure2[ind+1]
	  else
         term1 = measure3[ind+1]	
      end		 	  
   end
   if(sign[2] == 1) then  
      term2 = measure1[ind]
   else
      if(sign[2] == 2) then
         term2 = measure2[ind]
	  else
         term2 = measure3[ind]	
      end		 	  
   end   
end

if (index == 2) then 
   leftval = value[2]
   rightval = value[1]
   q = sign[2]
   sign[2] = sign[1]
   sign[1] = q
   if(sign[1] == 1) then  
      term1 = measure1[ind]
   else
      if(sign[1] == 2) then
         term1 = measure2[ind]
	  else
         term1 = measure3[ind]	
      end		 	  
   end
   if(sign[2] == 1) then  
      term2 = measure1[ind+1]
   else
      if(sign[2] == 2) then
         term2 = measure2[ind+1]
	  else
         term2 = measure3[ind+1]	
      end		 	  
   end   
end  
                
if (index == 3) then 
   if (ind ~= 3) then
       leftval = half
       rightval = math.floor(number[ind]/2)
       term1 = measure2[ind+1]
       term2 = measure3[ind]
	else
       leftval = value[1]
       rightval = value[2]
       if(sign[1] == 1) then  
          term1 = measure1[ind+1]
       else
          if(sign[1] == 2) then
             term1 = measure2[ind+1]
	      else
             term1 = measure3[ind+1]	
          end		 	  
       end
       if(sign[2] == 1) then  
          term2 = measure1[ind]
       else
          if(sign[2] == 2) then
             term2 = measure2[ind]
	      else
             term2 = measure3[ind]	
          end		 	  
       end       
    end	   
end               
                              