
include("terms")

meas = "\(^\circ\)"
trian = "\(\small\triangle\)"
symb = {"α", "β", "γ", "δ", "ω"}
sp = "\(\ \)"

index = {2, 3, 4, 5, 6, 9, 12, 15, 18, 24, 30, 45}
dim = 12
numb = {}
ang = {}

q = {}
q1 = {}
q2 = {}
qq = {}

sum = 0
for i = 1,3 do
    numb[i] = 3 + math.random(2+i)
    sum = sum + numb[i]
end	
numb[4] = 1
for i = 1,dim-1 do	
    if (sum >= index[i] and sum < index[i+1]) then
            tmp = i + math.random(dim - i)
	    numb[4] = index[tmp] - sum
	end	
end	
sum = sum + numb[4]

q1 = lib.math.gcd(numb[1], numb[2])
q2 = lib.math.gcd(numb[3], numb[4])
qq = lib.math.gcd(q1, q2)
if (qq ~= 1) then
    sum = 0
	for i = 1,4 do
        numb[i] = math.floor(numb[i]/qq)
		sum = sum + numb[i]
	end
end	

val = math.floor(360/sum)

for i = 1,4 do
    ang[i] = numb[i] * val		
end
ind = 0
for i = 1,4 do
    if (ang[i] == 180) then
        ind = i
	end	
end
if (ind ~= 0) then
    q = lib.math.argsort(numb)
	numb[ind] = numb[ind] - 1
    ang[ind] = numb[ind] * val	
	numb[q[1]] = numb[q[1]] + 1
    ang[q[1]] = numb[q[1]] * val	
end		
	
sign = 1
if (ang[1] == ang[3] and ang[2] == ang[4] ) then
    sign = 2
end	
if (ang[1] == 90 and ang[2] == 90 and ang[3] == 90 and ang[4] == 90 ) then
    sign = 3
end
if (ang[1] + ang[4] == 180  and ang[2] + ang[3] == 180) then
    sign = 4
end	
if (ang[1] + ang[2] == 180  and ang[3] + ang[4] == 180) then
    sign = 4
end	
if (ang[1] == ang[3]  and ang[2] ~= ang[4]) then
    sign = 5
end	
if (ang[1] ~= ang[3]  and ang[2] == ang[4]) then
    sign = 5
end
for i = 1,4 do
    if (ang[i] > 180) then
        sign = 6
	end	
end	
name = msg[sign]

           
quest = ""
for i = 1,4 do
    if (numb[i] == 1) then
	    text = ""
	else
        text = tostring( math.floor(numb[i]))
    end	
    quest = quest .. sp .. sp .. sp .. symb[i] .. " = " .. text .. symb[5] .. ", " 
end	   
        