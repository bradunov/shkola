
x1 = "x\(\small_1\)"
x2 = "x\(\small_2\)"

fact = math.random(20) - 1;
term = math.random(15);
sg = math.random(2)
if (sg == 1) then
	term = - term 
end		

answ1 = ""
answ2 = ""
if (fact == 0) then
    answ1 = x1 .. " = " .. lib.check_number(fact)
    answ2 = x2 .. " = " .. lib.check_number(fact)	
else	
    answ1 = x1 .. " = " .. lib.check_number(fact)
    answ2 = x2 .. " = " .. lib.check_number(-fact)	
end

quest = ""
if (ITEM == 1) then 
    summ = fact + term; 	
	quest = "| x | + ( " .. tostring(term) .. " ) = " .. tostring(summ)
end
if (ITEM == 2) then  
    summ = fact - term;
	quest = "| x | - ( " .. tostring(term) .. " ) = " .. tostring(summ)
end
if (ITEM == 3) then  
    summ = term + fact;
	quest = "( " .. tostring(term) .. " ) + | x | = " .. tostring(summ)
end
if (ITEM == 4) then 
    summ = term - fact; 
	quest = "( " .. tostring(term) .. " ) - | x | = " .. tostring(summ)
end

            