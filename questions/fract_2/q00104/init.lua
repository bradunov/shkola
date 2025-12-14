
include("terms")

include("names")
r = math.random(#zensko_ime_nom)
name = zensko_ime_nom[r] 

tmp = 1 + math.random(4) 
rest = 3*tmp
neib = 2*tmp  

ch = 0
j = 2 + math.random(3)
for i = 1,j-1 do	
	if (ch == 0) then
		part = j-i		
		ind = j + i
		if (j < 5) then
			ind = ind - 6 + j
		end
		if (rest - part*math.floor(rest/part) == 0) then
			ch = j
			total = j * rest / part		
		end
	end
end
if (ch == 0) then
	total = 2 * rest
end
      