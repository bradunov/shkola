
include("terms")

numb = {}  

ch = math.random(2)	

min_range = 5
max_range = 8
numb[1] = min_range + math.random(max_range)
numb[2] = min_range + math.random(max_range)
fct = 1 +  math.random(max_range-2)
if (ch == 1) then
	numb[3] = numb[2] /math.sqrt(fct) 
	numb[4] = fct 	
else	
	numb[3] = numb[2] / fct	
	numb[4] = fct^2 
end	
for i = 3,4 do
	numb[i] = lib.math.round_dec(numb[i],1)
end
       