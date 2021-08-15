
include("terms")

ind1 = math.random(2);
sign1 = operat1[ind1]
	
term1 = math.random(69900) + 20100;
term2 = math.random(term1 - 15000) + 10000;

if (ind1 == 1) then 
    value1 = term1 - term2
else
    value1 = term1 + term2	
end	

ind3 = math.random(2);
sign3 = operat1p[ind3]

term3 = math.random(59900) + 30100;
term4 = math.random(term3 - 20000) + 10000;

if (ind3 == 1) then 
    value3 = term3 - term4
else
    value3 = term3 + term4	
end	

if (value1 == value3) then
    temp = 100 * math.random(50)
    term1 = term1 + temp
	value1 = value1 + temp
end	
   
if(value1 > value3) then
   result = value1 - value3; 
   if (ind1 == 1) then
       sign2 = operat2a[2]
   else
       sign2 = operat2i[2]	
   end	
else 
   result = value3 - value1; 
   if (ind1 == 1) then       
       sign2 = operat2a[1]
   else
       sign2 = operat2i[1]	
   end	
end

         

         