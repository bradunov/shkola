
include("terms")

dist = {}
pt = {"A", "B", "C", "D"}
ans = {""}
index = {}
ind = {}
out = {}
ord = {}

meas = "cm"

for i = 1,4 do
    index[i] = i
end

ind = lib.math.random_shuffle(index)

radius = 2 + math.random(10)
dist[ind[1]] = math.random(radius-1)
dist[ind[2]] = radius
dist[ind[3]] = radius + math.random(10)
dist[ind[4]] = 0
for i = 1,4 do
    for j = 1,4 do 
        if (i == ind[j]) then
	        out[i] = dist[ind[j]]
		end
    end
end	

for i = 1,4 do
    ans[i] = msg[5] .. lib.check_string_case(pt[ind[i]], 15) .. msg[i]    
end	

ord = lib.math.random_shuffle(index)   
             