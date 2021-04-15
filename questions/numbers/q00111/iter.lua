
answ = {"=", "<", ">"}

br1 = math.random(10);
ind1 = math.random(2)

br2 = math.random(10); 
ind2 = math.random(2)

if (br2 == br1) then 
    if (ind2 == 1) then   
	    ind1 = 2
	else
            ind1 = 1
	end
end	

if (ind1 == 1) then
   broj1 = br1 * 1000
else
   broj1 = br1 * 10000
end
    
   
if (ind2 == 1) then
   broj2 = br2 * 1000
else
   broj2 = br2 * 10000
end

fact = broj1 - broj2
sign = "="   

if (fact < 0) then sign = "<"
end

if (fact > 0) then sign = ">"
end  
                 
                                      
             
          