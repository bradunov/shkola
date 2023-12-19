
meas = {"cm", "cm²", "cm³"}
edge = {}
body = {}
out = {}

pi = 22/7
r3 = math.sqrt(3)

--[[lopta]]--
numb = 2 + math.random(8)
area = numb^2 * pi
vol = area * numb / 6

--[[kocka   math.sqrt(pi/6)]]--
   edge[1] =  math.sqrt(area / 6)  
   body[1] = edge[1]^3

--[[valjak math.sqrt(2/3) ]]--
   edge[2] =  math.sqrt(area / (6*pi))  
   body[2] = 2 * pi * edge[2]^3
   
--[[kupa  2/3  ]]--
   edge[3] =  math.sqrt(area / (3*pi))  
   body[3] = pi * edge[3]^3 / r3

area = lib.math.round_dec(area,1)
vol = lib.math.round_dec(vol,1)
for i = 1,3 do
	out[i] = lib.math.round_dec(100 * body[i]/vol,1)
end                        
            