
include("terms")	

meas = {"cm", "cm³"} 

ind = math.random(3)
numb = 2 + math.random(8)
	
if (ind == 1) then
	coef = 0.25 * math.sqrt(3)
end	
if (ind == 2) then
	coef = 1 
end	
if (ind == 3) then
	coef = 1.5 * math.sqrt(3)
end	

vol = coef * numb^3
vol = lib.math.round_dec(vol, 2)    
                        
            