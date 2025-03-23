
include("terms")

meas = "°"
sp = "\(\ \ \ \)"

index = {5, 6, 9, 12, 15, 18}
dim = 6

ang = {}
out = {}

sum = index[math.random(dim)]
omega = math.floor(180/sum)
max = math.floor(sum/2)
numb = math.random(max-1)
ang[2] = numb * omega   
ang[3] = (sum - numb) * omega	
	
sign = math.random(3)

if (sign == 1) then
	ang[1] = 90
	ang[4] = 90
else	
    if (sign == 2) then
	   ang[1] = ang[2]
	   ang[4] = ang[3]
	else
       sum = index[math.random(dim)]
       omega = math.floor(180/sum)
       max = math.floor(sum/2)
	   numb = math.random(max-1)
       ang[1] = numb * omega   
       ang[4] = (sum - numb) * omega	
    end	   
end	

if (ang[1] == ang[2]) then
    sign = 2
end
	
name = msg[sign]

ind = math.random(2)
if (ind == 1) then
    out[1] = ang[1]
    out[4] = ang[4]
else
    out[1] = ang[4]
    out[4] = ang[1]    
end	
ind = math.random(2)
if (ind == 1) then
    out[2] = ang[2]
    out[3] = ang[3]
else
    out[2] = ang[3]
    out[3] = ang[2]    
end	

quest = ""
if (sign == 2) then
    quest = out[1] .. meas
else
    quest = out[1] .. meas .. ", " .. sp .. out[2] .. meas
end	

if (sign == 2) then
    qq = 4
else	
    qq = 3
end        
     