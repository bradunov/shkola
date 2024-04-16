
include("terms")

ind = {}
numb = {}
name = {""}
ans = {""}

for i = 1,11 do
     ind[i] = i
end	 
ind = lib.math.random_shuffle(ind)

for i = 1,3 do
	numb[i] = ind[i]
	if (numb[i] == 6) then 
		numb[i] = ind[11]
	end
	if (numb[i] == 1) then
		name[i] = hour[1]
	else	
		if (numb[i] < 5) then
			name[i] = hour[2]
		else
			name[i] = hour[3]
		end
	end	
	if (numb[i] < 3  or numb[i] > 9) then
		ans[i] = angle[1]
	else	
		if (numb[i] == 3  or numb[i] == 9) then
			ans[i] = angle[2]	
		else
			ans[i] = angle[3]
		end
	end  
end
    