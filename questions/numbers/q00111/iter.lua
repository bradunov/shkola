broj1 = math.random(10);
ind1 = math.random(2)

broj2 = math.random(10); 
ind2 = math.random(2)

if (broj2 == broj1) then 
    if (broj1 == 1) then   
	    broj2 = broj2 + 1
	else
        broj2 =	broj2 - 1
	end
end	


if (ind1 == 1) then
   broj1 = broj1 * 1000
else
   broj1 = broj1 * 10000
end
    
   
if (ind2 == 2) then
   broj2 = broj2 * 1000
else
   broj2 = broj2 * 10000
end

fact = broj1 - broj2
znak = "="   

if (fact < 0) then znak = "<"
end

if (fact > 0) then znak = ">"
end  
                         
             
          