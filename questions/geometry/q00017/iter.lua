side = {}
min = 4;
max = 20;

side[1] = min + math.random(max - min);
side[2] = side[1] + math.random(max - min);
side[3] = side[1] + math.random(side[2] - side[1]); 
side[4] = side[1]
side[5] = side[2]

for i=1,3 do
    if(side[i] > side[i+1] + side[i+2]) then
       side[i] = side[i+1]        
    end
end

if (ITEM == 1) then
   result = side[1] + side[2] + side[3]
   answ = "trougla, ako su njegove stranice " .. tostring(math.floor(side[1])) .. "cm, " .. tostring(math.floor(side[2])) .. "cm i " .. tostring(math.floor(side[3])) .. "cm."
else
   if (ITEM == 2) then
       result = side[2] * 4
       answ = "kvadrata, ako je njegova stranica " .. tostring(math.floor(side[2])) .. "cm."
   else
       result = (side[1] + side[3]) * 2
       answ = "pravougaonika, ako su njegove stranice " .. tostring(math.floor(side[1])) .. "cm i " .. tostring(math.floor(side[3])) .. "cm."
   end
end            
      	
    


     
               

