 
include("terms") 

rel = {" < ", " > ", " ≤ ", " ≥ "}
brac = {"(", ")", "[", "]"}

num = {}
index = {}
ind = {}
quest = ""
partx = ""
partinx = ""
ineq = {""}
reply = {""}

dim = 4
for i = 1,dim do
    index[i] = i
end	
ind = lib.math.random_shuffle(index)

opqu = math.random(4)
if (opqu < 3) then
    opcont = 3 - opqu
else	
    opcont = 7 - opqu
end

sg = math.random(2)
num[1] = math.random(9)
if (sg == 2) then
    num[1] = - num[1]
end	
num[2] = 10 - math.random(19)

if (math.abs(num[1]) ~= 1) then
	partx = num[1] 
	partinx = -num[1]	
else
    if (num[1] == -1) then
        partx = "- "
	else
        partinx = "- "	
    end
end	
partx = partx .. " x "	
partinx = partinx .. " x "
quest = partx
if (num[2] ~= 0) then 
	if (num[2] > 0) then 
		quest = quest .. " + " .. num[2] 
	else
		quest = quest .. " - " .. math.abs(num[2])
    end		
end	
quest = quest .. rel[opqu] .. " 0 "        
 
num[3] = 1 

--[[
    a x + b = 0,     a, c: =/= 0,    b: >, =, < 0, 
    a x = - b            			ind = 1 , mod = 1, 2, 3, 4,     
				ax = b,                         mod = 5, 6, 7, 8,
	- a x = b              			ind = 2
	            - a x = - b
	b = - a x         				ind = 3	
	            b = a x	
	 - b = a x                      ind = 4
	 	        - b = - a x
				
#	uopstenje prethodnog          ch = 0:    c = 1
                                  ch = 1:    c < -1
                                  ch = 1:    c > 1								  
    c (a x + b) = 0            	   c < 0  opqu -> opcont
]]--
	         