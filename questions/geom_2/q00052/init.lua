
include("terms")

ind = math.random(4)

qq = math.random(4)
pp = qq + math.random(8 - qq)
temp = lib.math.gcd(pp, qq)
pp = math.floor(pp/temp)
qq = math.floor(qq/temp)
fact = math.random(3)
numb = fact *(qq + 2 * pp)
if (ind < 4) then      
   name = msg1[ind]
   quest = msg2[1]
   reply = "."      
else
   name = msg1[2]  
   quest = "" 
   reply = numb .. "cm " .. msg2[2] .. pp .. ":" .. qq .. "."  
end

if (ind == 1) then
   edge1 = 1
   edge2 = 1
   edge3 = 1
end   

if (ind == 2) then
   edge1 = 1
   edge2 = 2
   edge3 = 2
end   

if (ind == 3) then
   edge1 = 2
   edge2 = 3
   edge3 = 4
end  
   
if (ind == 4) then   
   edge1 = fact * qq
   edge2 = fact * pp
   edge3 = fact * pp
end
