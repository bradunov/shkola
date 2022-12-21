        
fact =  2 + math.random(3);
day1 = 5 + math.random(6-fact)
numb2 = fact * day1

day2 = 2 + math.random(day1-fact)
numb1 = fact * day2   

result = numb2 - numb1

equ =  lib.check_number(numb1, 20) .. lib.check_string("*", 15) .. lib.check_number(day1, 20) .. " = " .. "( " .. lib.check_number(numb1,20) .. lib.check_string("+", 15) .. lib.check_string("x",20) .. " ) * " .. lib.check_number(day2,20)             
   