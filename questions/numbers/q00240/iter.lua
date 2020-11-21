
sign1 = " "
operat = {"+", "-"}

factor1 = math.random(7) + 2
factor2 = math.random(20 - factor1) + 11
factor3 = math.random(7) + 2

ind = math.random(2)

if (ITEM == 1) then  
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = (factor2 - factor1) * factor3
	else		
	    value = (factor2 + factor1) * factor3
	end	
	
	dis = 1 + math.random(3)
	term2 = dis * factor3
	if (term2 >= value) then
	    term2 = factor3
	end	
	index = math.random(2)
	if (index == 1) then
	    term1 = value - term2
		sign3 = "+"
	else
	    term1 = value + term2
		sign3 = "-"	
    end			
	answ = lib.check_string("(",5) .. tostring(term1) .. sign3 .. lib.check_string("",5) .. tostring(term2) .. lib.check_string(")",5) .. sign1 .. lib.check_string("",5) .. tostring(factor3) .. lib.check_string("",5) .. sign2 .. tostring(factor1) .. lib.check_string("",5) .. " = " .. tostring(factor2)
end

if (ITEM == 2) then  
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = (factor2 + factor1) * factor3
	else		
	    value = (factor2 - factor1) * factor3
	end	
	dis = 1 + math.random(3)
	term2 = dis * factor2
	if (term2 >= value) then
	    term2 = factor2
	end	
	index = math.random(2)
	if (index == 1) then
	    term1 = value - term2
		sign3 = "+"
	else
	    term1 = value + term2
		sign3 = "-"	
    end			
	answ = lib.check_string("(",5) .. tostring(term1) .. sign3 .. lib.check_string("",5) .. tostring(term2) .. lib.check_string(")",5) .. sign1 .. lib.check_string("(",5) .. tostring(factor2) .. lib.check_string("",5) .. sign2 .. tostring(factor1) .. lib.check_string(")",5) .. " = " .. tostring(factor3)
end

if (ITEM == 3) then  
    sign1 = "·"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor1 * factor2 + factor3 
	else
		value = factor1 * factor2 - factor3 
	end
	dis = 1 + math.random(3)
	term2 = dis * factor2
	index = math.random(2)	
	if (factor1 <= term2) then
	    index = 2
	end	
	if (index == 1) then
	    term1 = factor1 - term2
		sign3 = "+"
	else
	    term1 = factor1 + term2 
		sign3 = "-"	
    end			
	answ = lib.check_string("(",5) .. tostring(term1) .. sign3 .. lib.check_string("",5) .. tostring(term2) .. lib.check_string(")",5) .. sign1 .. lib.check_string("",5) .. tostring(factor2) .. lib.check_string("",5) .. sign2 .. tostring(factor3) .. lib.check_string("",5) .. " = " .. tostring(value)
	end

if (ITEM == 4) then  
    sign1 = "·"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = factor1 * (factor2 + factor3) 
	else
	    value = factor1 * (factor2 - factor3) 
	end	
	result = factor2
	dis = 1 + math.random(3)
	term2 = dis * factor2
	index = math.random(2)	
	if (factor1 <= term2) then
	    index = 2
	end	
	if (index == 1) then
	    term1 = factor1 - term2
		sign3 = "+"
	else
	    term1 = factor1 + term2 
		sign3 = "-"	
    end			
	answ = lib.check_string("(",5) .. tostring(term1) .. sign3 .. lib.check_string("",5) .. tostring(term2) .. lib.check_string(")",5) .. sign1 .. lib.check_string("(",5) .. tostring(factor2) .. lib.check_string("",5) .. sign2 .. tostring(factor3) .. lib.check_string(")",5) .. " = " .. tostring(value)
end
  
if (ITEM == 5) then  
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = (factor2 - factor1) * factor3
	else		
	    value = (factor2 + factor1) * factor3
	end	
	
	dis = 1 + math.random(3)
	term2 = dis * factor3
	if (term2 >= value) then
	    term2 = factor3
		dis = 1
	end	
	index = math.random(2)
	if (index == 1) then
	    term1 = value - term2		 
		result = term1 + (dis + factor1)		
		sign3 = "+"
	else
	    term1 = value + term2
	    result = term1 - (dis + factor1)			
		sign3 = "-"	
    end	
	
	answ = lib.check_string("",5) .. tostring(term1) .. sign3 .. lib.check_string("(",5) .. tostring(term2) .. lib.check_string("",5) .. sign1 .. lib.check_string("",5) .. tostring(factor3) .. lib.check_string("",5) .. "+" .. tostring(factor1) .. lib.check_string(")",5) .. " = " .. tostring(result)
end

 if (ITEM == 6) then  
	sign1 = ":"
    sign2 = operat[ind]	
	if (ind == 1) then
		value = (factor2 - factor1) * factor3
	else		
	    value = (factor2 + factor1) * factor3
	end	
	
	dis = 1 + math.random(3)
	term2 = dis * factor3
	if (term2 >= value) then
	    term2 = factor3
		dis = 1
	end	
	index = math.random(2)
	if (index == 1) then
	    term1 = value - term2		 
		if (ind == 1) then
		    result = term1 + (dis + factor1)
		else
		    result = term1 + (dis - factor1)	
        end			
		sign3 = "+"
	else
	    term1 = value + term2
		if (ind == 1) then
		    result = term1 - dis + factor1
		else
		    result = term1 - dis - factor1	
        end				
		sign3 = "-"	
    end	
	
	answ = lib.check_string("",5) .. tostring(term1) .. sign3 .. lib.check_string("",5) .. tostring(term2) .. lib.check_string("",5) .. sign1 .. lib.check_string("",5) .. tostring(factor3) .. lib.check_string("",5) .. sign2 .. tostring(factor1) .. lib.check_string("",5) .. " = " .. tostring(result)
end
         
           
     