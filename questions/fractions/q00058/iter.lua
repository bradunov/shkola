
include("terms")

indev = math.random(6)
part = dev[indev]
fract = indev + 2

result = math.random(29)+11

numb1 = math.random(7) + 2
numb2 = fract*numb1
                  
indcomp = math.random(2) 

if (numb2 * result > 1000) then
   indcomp = 1
end

sign = compare[indcomp]

if (indcomp == 1) then
    numb1 = numb1 * result
else 
    numb2 = numb2 * result
end	          
