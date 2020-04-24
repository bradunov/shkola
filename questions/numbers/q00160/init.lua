
oper = {"+", "-"}
answ = {""}

ind = math.random(2)

term1 = math.random(29) + 30;



if(ind == 1) then
   factor = math.ceil(term1/10) + 1 + math.random(3) 
   temp = factor * 10
   term3 = temp - term1
   term2 = 11 + math.random(temp - 10)
   sign1 = oper[2] 
   sign2 = oper[1]
   value = temp - term2
else
   factor = math.floor(term1/10) - math.random(2) 
   temp = factor * 10
   term3 = term1 - temp
   term2 = 11 + math.random(89 - temp)
   sign1 = oper[1] 
   sign2 = oper[2]
   value = temp + term2
end

