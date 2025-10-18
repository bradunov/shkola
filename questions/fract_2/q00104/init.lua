
include("terms")

include("names")
r = math.random(#zensko_ime_nom)
name = zensko_ime_nom[r] 

tmp = 1 + math.random(4) 
rest = 3*tmp
neib = 2*tmp   
if (rest - 4*math.floor(rest/4) == 0) then
	ind = 2 + math.random(3)
	part = 6 - ind 
	total = 4 * rest / part
else
	if (rest - 5*math.floor(rest/5) == 0) then	
		ind = 5 + math.random(4)
		part = 10 - ind 
		total = 5 * rest / part
	else
		ind = math.random(2)
		part = 3 - ind
		total = 3 * rest / part	
	end
end
sale = total - rest
        
      