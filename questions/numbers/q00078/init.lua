value = {}

term1 = math.random(299) + 700;
term2 = math.random(199) + 300;

temp = term1 - term2;

if(temp > term2) then
   ind = term2;
else
   ind = temp;
end

term3 = math.random(ind - 100) + 100;

for i = 1,4 do
    value[i] = temp + term3*(-1)^i;
end	



          
         
                     