include("terms")

sign = {"+", "-",  "*" , ":"}

quest = " "
answ = " "

number1 = 111 + math.random(389)
number2 = 101 + math.random(number1 - 110)
factor = 3 + math.random(9)

ind1 = math.random(2)
ind2 = math.random(2)

if (ITEM == 1) then
    if (ind2 == 2) then
	    number1 = number1 * factor
        number2 = number2 * factor
    end	
    quest = operation[ind1] .. brojeva_str .. tostring(number1) .. i_str .. tostring(number2) .. " " .. work[ind2] .. " " .. tostring(factor) .. puta_str 
    if (ind1 == 1) then
        value = number1 + number2
    else
        value = number1 - number2	
    end		
    if (ind2 == 1) then
        result = value * factor
    else
        result = value / factor	
    end		
    answ = "(" .. lib.check_number(number1,35) .. " " .. lib.check_string(sign[ind1],10) .. " " .. lib.check_number(number2,35) .. ") " .. lib.check_string(sign[ind2+2],10) .. " " .. lib.check_number(factor, 35) .. " = " .. lib.check_number(result,50)
end  

if (ITEM == 2) then
    if (ind1 == 2) then
	    number1 = number1 * factor
        temp = number2 
        number2 = factor		
		factor = temp
    end	
    quest = operation[2+ind1] .. brojeva_str .. tostring(number1) .. i_str .. tostring(number2) .. " " .. work[ind2] .. za_str .. tostring(factor) 
    if (ind1 == 1) then
        value = number1 * number2
    else
        value = number1 / number2	
    end		
    if (ind2 == 1) then
        result = value + factor
    else
        result = value - factor	
    end		
    answ = lib.check_number(number1,35) .. " " .. lib.check_string(sign[2+ind1],10) .. " " .. lib.check_number(number2,35) .. " " .. lib.check_string(sign[ind2],10) .. " " .. lib.check_number(factor, 35) .. " = " .. lib.check_number(result,50)
end  	

if (ITEM == 3) then
    if (ind2 == 1) then
	    number1 = number1 * factor
    else		
	    number2 = number2 * factor
    end	
    quest = broj_str .. tostring(number1) .. " " .. work[ind1] .. za_str .. operation[2+ind2] .. brojeva_str .. tostring(number2) .. i_str .. tostring(factor)  
    if (ind2 == 1) then
        value = number2 * factor
    else
        value = number2 / factor	
    end		
    if (ind1 == 1) then
        result = number1 + value 
    else
        result = number1 - value 	
    end		
    answ = lib.check_number(number1,35) .. " " .. lib.check_string(sign[ind1],10) .. " " .. lib.check_number(number2,35) .. " " .. lib.check_string(sign[2+ind2],10) .. " " .. lib.check_number(factor, 35) .. " = " .. lib.check_number(result,50)
end  	

