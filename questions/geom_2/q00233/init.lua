
include("terms")

meas = {"dm", "dm²", "dm³"}
pi = 22/7
r2 = math.sqrt(2)
r3 = math.sqrt(3)

--[[lopta]]--
numb = 2 + math.random(8)
area = numb^2 * pi
vol = area * numb / 6

ind = math.random(3)
if (ind == 1) then                    --[[kocka]]--
   edge =  numb / r3  
   surf = 6 * edge^2
   body = edge^3
   text = rod[1]
end   
if (ind == 2) then                    --[[valjak]]--
   edge =  numb / r2  
   surf = 1.5 * pi * edge^2
   body = 0.25 * pi * edge^3
   text = rod[2]   
end   
if (ind == 3) then                    --[[kupa]]--
   edge =  numb * r3 / 2 
   surf = 0.75 * pi * edge^2
   body = pi * edge^3 / (8*r3)
   text = rod[1]   
end  

area = lib.math.round_dec(area,2)
vol = lib.math.round_dec(vol,2)
surf = lib.math.round_dec(surf,2)
body = lib.math.round_dec(body,2)
                