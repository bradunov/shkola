
measure = {"mm",  "cm",  "dm", "m"}

ind = math.random(2)

min = 1;
max = 29;

circ = (min + math.random(max - min)) 
temp = math.floor(circ/4)
rest = circ - temp * 4
if(rest == 0) then
   side = temp
   mes_c = ind
   mes_s = ind   
else
   side = circ * 25
   mes_c = ind+2
   mes_s = ind
   temp = math.floor(side/10)
   rest = side - temp * 10
   if(rest == 0) then
      side = temp
      mes_s = ind+1
   end  
end	


            
            
           


     
               

