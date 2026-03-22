
out = {}
qq = {}
reply = {}          
			
numb = 2 + math.random(3)							
if (numb == 3) then
	free = 4
	dif = 4
	ind = 3
else
	if (numb == 4) then
		free = 3
		dif = 3	
		ind = 4
	else
		free = 9
		dif = 3	
		ind = 3		
	end
end
for i = 1,4 do
    coef = i + 1
    out[i] = coef .. "a + "	.. free
	free = free + dif
end
	
test = {1,2,3,4}
qq = lib.math.random_shuffle(test)
for i = 1,4 do
    reply[i] = out[qq[i]]
	if (qq[i] == ind) then
	    res = i - 1
	end
end			
   