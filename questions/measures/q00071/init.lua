
include("terms")

ind = {}
ind[1] = math.random(5)
ind[2] = math.random(3)
ind[3] = math.random(4)
ind[4] = math.random(5)

out = {}
for i = 1,4 do
    if (i == 1 and ind[i] == 5) then
		out[i] = measure[i][3]
    else	
	   if (i == 4 and ind[i] == 5) then
			out[i] = measure[i][1]
		else			
			out[i] = measure[i][ind[i]]
		end
	end
end
