
answ = {"=", "<", ">"}

broj1 = 11 - math.random(21);
broj2 = 11 - math.random(21); 

if (broj1 == broj2) then
    if (broj1 == 0) then  
        broj1 = 5
		broj2 = -5
	else
        broj1 = - broj1
    end		
else
    if (broj1 > 0 and broj2 > 0) then
        broj2 = - broj2
	end	
end	

fact = broj1 - broj2 

sign = "="
if (fact < 0) then sign = "<"
end

if (fact > 0) then sign = ">"
end  
                          
