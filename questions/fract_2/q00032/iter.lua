
include("terms")

round = math.random(4)
dec = 10^round 

if (round == 1) then
    name = msg[1]
else
    name = msg[2]	
end	
                                                                                                
brojilac  = 2 + math.random(997)
imenilac = 2 + math.random(497)

if (brojilac - imenilac * math.floor(brojilac/imenilac) == 0) then
    brojilac = brojilac - 1
end	

value = brojilac/imenilac 
              
result = lib.math.round_dec(value, round)  