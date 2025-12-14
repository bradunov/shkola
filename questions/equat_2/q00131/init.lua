 
rel = {" < ", " ≤ "}

num = {}
partx = ""
partinx = ""

opl = math.random(2)
opr = math.random(2)

sg = math.random(2)
num[1] = math.random(8)
if (sg == 2) then
    num[1] = - num[1]
end	
num[2] = 7 - math.random(13)

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
ineq = partx
if (num[2] ~= 0) then 
	if (num[2] > 0) then 
		ineq = ineq .. " + " .. num[2] 
	else
		ineq = ineq .. " - " .. math.abs(num[2])
    end		
end	
  
x = 7 - math.random(13)
val = num[1] * x + num[2] 
lb = 2 + math.random(5)
rb = 3 + math.random(5) 
num[3] = val - lb
num[4] = val + rb
lftb = math.floor((num[3] - num[2])/num[1])  
rghb = math.floor((num[4] - num[2])/num[1]) 
ineq = num[3] .. " " .. rel[opl] .. " " .. ineq .. " " .. rel[opr] .. " " .. num[4] 

if (lftb <= rghb) then
	minrange = lftb
	maxrange = rghb
else
	minrange = rghb
	maxrange = lftb
end
reply = 0
for y = minrange, maxrange do
	vy = num[1] * y + num[2]
    if (vy > num[3] and vy < num[4] ) then
	    reply = reply + 1
	end
	if (vy == num[3] and opl == 2) then
		reply = reply + 1
	end	
	if (vy == num[4] and opr == 2) then
		reply = reply + 1
	end		
end	