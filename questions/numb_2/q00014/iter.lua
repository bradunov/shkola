
include("terms")

factor1 = 30 + math.random(69)
factor2 = 100 + math.random(899) 

number = 2 + math.random(7)

prod = factor1 * factor2

ind = math.random(2)

if (ind == 1) then
    result = factor1 * (factor2 - number)
else
    result = factor1 * (factor2 + number)	
end

reply1 = "answer == '" .. factor1 .. "' "  ..
        "|| answer == '" .. factor2 .. "'" ;
ans1 = "answer = '" .. factor1 .. "' ";

reply2 = "answer == '" .. factor2 .. "' "  ..
        "|| answer == '" .. factor1 .. "'" ;
ans2 = "answer = '" .. factor2 .. "' ";            

                                                        
       
            
       