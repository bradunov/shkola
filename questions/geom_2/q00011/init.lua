
include("terms")

ln = {"a", "b", "c", "d"}
pt = {"OA", "OB", "OC", "OD"}

dist = {}
ans = {""}
index = {}
ind = {}
out = {}

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

def = ""
for i = 1,4 do
    if (dist[i] < radius) then
	   def = msg[1]
	end   
    if (dist[i] == radius) then
	   def = msg[2]
	end  
    if (dist[i] > radius) then
	   def = msg[4]
	end
    if (dist[i] == 0) then
	   def = msg[3]
	end 	
    ans[i] = msg[5] .. lib.check_string_case(ln[i], 15) .. def    
end	

out = lib.math.random_shuffle(index)   
  