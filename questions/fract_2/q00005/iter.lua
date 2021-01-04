
imen1 = 10 + math.random(19)
broj1 = math.random(imen1-1)

imen2 = 5 + math.random(19)
broj2 = math.random(imen2-1)

fact1 = broj1 * imen2
fact2 = broj2 * imen1


if (fact1 < fact2) then 
    sign = "<"
else
    if (fact1 > fact2) then
        sign = ">"
	else
        sign = "="
    end
end	
	
                 
