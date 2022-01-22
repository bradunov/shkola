
include("terms")

numb = {}
part = {}
name = {}
out = {}
tmp = {}

max_numb = 0
ind = 1
for i = 1,5 do
    numb[i] = math.random(7)
	if (numb[i] > max_numb) then
	    ind = i
		max_numb = numb[i]
	end	
end
numb[ind] = max_numb + 1

number = 0
for i = 1,5 do
	number = number + numb[i]
	name[i] = msg[1]
	if (numb[i] == 1) then
	    name[i] = msg[2]	
	end    
end

aver = 20 + math.random(10)

for i = 1,5 do
    sign = math.random(2)
	if(sign == 1) then
       part[i] = aver - math.random(9)
	else   
       part[i] = aver + math.random(9)	
    end	   
end

out = lib.math.argsort(part)
for i = 1,4 do
    if (part[out[i]] == part[out[i+1]]) then
	    part[out[i]] = part[out[i]] - (5 - i)*2 
	end	
end	
out = lib.math.argsort(part)
	
total = 0	
for i = 1,5 do	
	total = total + part[i] * numb[i] 	
end	
aver = lib.math.round_dec(total/number,2)	

nr = 0
for i = 1,5 do
    for j = 1,numb[out[i]] do
	    nr = nr + 1
        tmp[nr] = part[out[i]]
	end	
end

nr2 = math.floor(nr/2)
if (nr - 2*nr2 == 0) then
    med = (tmp[nr2] + tmp[nr2+1]) * 0.5
else
    med = tmp[nr2+1]
end	

modus = part[ind]  