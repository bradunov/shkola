
include("terms")
                
qq = {2, 4, 5, 8}
out = lib.math.random_shuffle(qq)

fact1 = 1 + math.random(3)
fact2 = fact1 + math.random(7 - fact1)
q = lib.math.gcd(fact1, fact2)
fact1 = lib.math.round(fact1/q)
fact2 = lib.math.round(fact2/q)

win = 2 + math.random(4)
total = (fact1 + fact2) * win
win = win * fact2  

temp = math.floor(total/10)
rest = total - 10 * temp
term1 = name[1]
if (temp ~= 1) then
    if (rest > 1 and rest < 5) then
        term1 = name[2]
	else
        if (rest == 1) then
           term1 = name[3]	
        end	
    end		
end	

temp = math.floor(win/10)
rest = win - 10 * temp
term2 = name[1]
if (temp ~= 1) then
    if (rest > 1 and rest < 5) then
        term2 = name[2]	
    end		
end	
  
        