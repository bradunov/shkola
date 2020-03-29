include("operation")
ind = math.random(2)

numb1 = math.random(500)+101

fact1 = math.random(7)+2
fact2 = math.random(6)+3

numb2 = fact1*fact2

if (ind == 1) then
    result = numb1 + fact2
    work = operation[1]
else	
    result = numb1 - fact2
    work = operation[2]
end	
                  
                    
   