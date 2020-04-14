oper = {"+", "-"}
sign = {}

ind = math.random(2)

term1 = math.random(29) + 30;


if(ind == 1) then
   factor = math.ceil(term1/10) + 1 + math.random(2) 
   temp = factor * 10
   term3 = temp - term1
   term2 = 11 + math.random(term1 - 15)
   rest = (term1 - term2)%10 
   if (rest == 0) then
       term2 = term2 + 1
   end 
   if (term2 == term3) then
       term2 = term2 + 2
   end    
   value = temp - term2
   sign[1] = oper[1]
   sign[2] = oper[2]
else
   factor = math.floor(term1/10) - math.random(2) 
   temp = factor * 10
   term3 = term1 - temp
   term2 = 11 + math.random(89 - temp)
   rest = (term1 + term2)%10 
   if (rest == 0) then
       term2 = term2 - 1
   end 
   if (term2 == term3) then
       term2 = term2 - 2
   end       
   value = temp + term2
   sign[1] = oper[2]
   sign[2] = oper[1]
end
   
                     
                  
